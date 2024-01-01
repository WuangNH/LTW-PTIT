package hotel.controller;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import hotel.data.*;
import hotel.model.Account;
import hotel.model.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import hotel.model.Booking;

// controller đầu tiên khi chạy sẽ hiển thị
@Controller
public class HomeController {
	@Autowired
	private RoomRepository roomRepo;
	@Autowired
	private BookingRepository bookingRepo;

	@Autowired // tự động tiêm các đối tượng để sử dụng các phương thức và thuộc tính
	private AccountRepository accountRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private ClientRepository clientRepo;
	
	@RequestMapping("/") // tiếp nhận yêu cầu từ trang /
	public String home(Model model, HttpSession session) {
		// dùng model để lưu data từ session
		if (session.getAttribute("currentAccount") != null) {
			model.addAttribute("account", session.getAttribute("currentAccount"));
		}
		return "home";
	}

	@SuppressWarnings("deprecation")
	@RequestMapping(method = RequestMethod.GET, value = "/viewReport")  // tiếp nhập từ trang /viewReport tính năng của manager
	public String viewReport(@RequestParam(name = "startDate", required = false) String startDateStr,
	                          @RequestParam(name = "endDate", required = false) String endDateStr,
	                          Model model) {
	    if (StringUtils.isEmpty(startDateStr) || StringUtils.isEmpty(endDateStr)) {
	    	float total = 0;
	        List<Booking> bookings = filterByCancel((List<Booking>) bookingRepo.findAll());
	        for(Booking booking:bookings) {
				if (booking.isPaid()) {
					total += booking.getTotalPrice();
				}
	        }
	        model.addAttribute("total",total);
	        model.addAttribute("bookings", bookings);
	    } else {
	    	float total = 0;
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        LocalDate startDate = LocalDate.parse(startDateStr, formatter);
	        LocalDate endDate = LocalDate.parse(endDateStr, formatter);

	        // Lọc danh sách booking theo ngày bắt đầu và kết thúc
	        List<Booking> bookings = filterByCancel((List<Booking>) bookingRepo.findAll());
	        List<Booking> filteredBookings = filterAllByCheckBetween(bookings, startDate, endDate);
			for (Booking booking : filteredBookings) {
				// Sử dụng equals() để so sánh chuỗi, và kiểm tra xem booking có trạng thái "Đã thanh toán" không
				if (booking.isPaid()) {
					total += booking.getTotalPrice();
				}
			}
	        model.addAttribute("total",total);
	        model.addAttribute("bookings", filteredBookings);
	        model.addAttribute("startDate", startDateStr);
	        model.addAttribute("endDate", endDateStr);
	    }if (!model.containsAttribute("startDate")) {
	        model.addAttribute("startDate", "");
	    }
	    if (!model.containsAttribute("endDate")) {
	        model.addAttribute("endDate", "");
	    }
	    return "viewReport";
	}
	@GetMapping("/checkout/{id}") // đây là hàm chấp nhận thanh toán và nhận phòng
	public String checkoutAccount(@PathVariable("id") Long id) {
		Booking booking = bookingRepo.findById(id).orElse(null);
		booking.setStatus("Đã trả phòng");
		booking.setReceive(false);
		bookingRepo.save(booking);
		return "redirect:/viewReport";
	}
	@GetMapping("/enableb/{id}") // đây là hàm chấp nhận thanh toán và nhận phòng
	public String enableAccount(@PathVariable("id") Long id) {
		Booking booking = bookingRepo.findById(id).orElse(null);
		if (!booking.isReceive()) {
			booking.setReceive(true);
			booking.setPaid(true);
			booking.setStatus("Đã nhận phòng và thanh toán");
			bookingRepo.save(booking);
		}
		return "redirect:/viewReport";
	}
	@GetMapping("/disableb/{id}") // đầy là hàm hủy đặt phòng
	public String disableAccount(@PathVariable("id") Long id) {
		Booking booking = bookingRepo.findById(id).orElse(null);
		Room room = booking.getRoom();
//		System.out.println(room);
//		room.setStatus("Trống");

//		System.out.println(booking.getRoom());
		if (booking != null) {
			// Xóa Booking từ cơ sở dữ liệu
			booking.setStatus("Đã hủy bởi quản lý");
			booking.setCancelled(true);
			bookingRepo.save(booking);
		} else {
			System.out.println("Không tìm thấy Booking với ID: " + id);
		}

		return "redirect:/viewReport";
	}

//	tìm những phòng được đặt bởi khách mà chưa bị hủy
	private List<Booking> filterByCancel(List<Booking> bookings) {
		List<Booking> list = new ArrayList<>();
		for (Booking booking : bookings) {
			if (booking.isCancelled() == false) { // nếu chưa bị hủy thì cho vào danh sách 
				list.add(booking);
			}
		}
		return list;
	}

	// Lọc danh sách booking theo ngày bắt đầu và kết thúc
	private List<Booking> filterAllByCheckBetween(List<Booking> bookings, LocalDate startDate, LocalDate endDate) {
	    List<Booking> filteredBookings = new ArrayList<>();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    for (Booking booking : bookings) {
	        LocalDate checkin =  LocalDate.parse( booking.getCheckin(), formatter);
	        LocalDate checkout = LocalDate.parse( booking.getCheckout(), formatter);
	        if (checkin != null && checkout != null && !booking.isCancelled()) {
	            if (checkin.compareTo(startDate) >= 0 && checkout.compareTo(endDate) <= 0) {
	                filteredBookings.add(booking);
	            }
	        }
	    }
	    return filteredBookings;
	}

	@GetMapping("/login") // tiếp nhận yêu cầu từ trang /login
	public String login(HttpSession session) {
		if (session.getAttribute("currentAccount") != null) {
			return "logout";
		}
		return "login";
	}

	@GetMapping("/logout") // tiếp nhận yêu cầu từ trang /logout
	public String logout(HttpSession session) {
		return "logout";
	}

	@PostMapping("/logout")
	protected String logout2(HttpSession session) {
		// Xử lý đăng xuất ở đây (invalidate session, xóa thông tin đăng nhập, v.v.)
		session.invalidate();
		return "redirect:/"; // Sau khi đăng xuất, bạn có thể chuyển người dùng đến trang chủ hoặc trang khác tùy ý.
	}

 // đây là hàng hủy đặt phòng
	@GetMapping("/cancel/{id}") // xử lý yêu cầu HTTP trên đường dẫn "/manage/cancel/{id}"
	public String cancelBooking(
			@PathVariable("id") Long id,
			@RequestParam(name = "roomName", required = false) String roomName)
	{
//		Booking booking = bookingRepo.findById(id).orElse(null);
//		if (booking != null) {
//			booking.setCancelled(true);
//			bookingRepo.save(booking);
//		}
		Room room = roomRepo.findByName(roomName);
		System.out.println(roomName);
		if (room != null) {
			room.setStatus("Trống");
			roomRepo.save(room);
			System.out.println(room.getStatus());
		}
//		Long maPhong = bookingRoom.getId();

		return "redirect:/viewReport";
	}

}


