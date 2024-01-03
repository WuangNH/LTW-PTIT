package hotel.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import hotel.model.Booking;
import hotel.model.Room;
import hotel.data.BookingRepository;
import hotel.data.RoomRepository;

@Controller
@RequestMapping("/manage/booking") 
@SessionAttributes("bookingRoom") 
public class ManageBookingController {

	@Autowired 
	private BookingRepository bookingRepo;

	@Autowired
	private RoomRepository roomRepo;

	@ModelAttribute("bookingRoom")
	private Room bookingRoom() {
		return new Room();
	}

//	tiếp nhận yêu cầu xem danh sách đặt phòng của các khách hàng 
	@GetMapping("/{id}") 
	private String viewBookingList(
			@PathVariable("id") Long id, Model model,
			@ModelAttribute("bookingRoom") Room bookingRoom) {
		Room room = roomRepo.findById(id).orElse(null);
		List<Booking> bookings = filterByCancel(bookingRepo.findAllByRoom(room));
		model.addAttribute("bookings", bookings);
		bookingRoom.setId(room.getId());
		return "manageBookingList"; 
	}

//	tìm những phòng được đặt bởi khách mà chưa bị hủy
	private List<Booking> filterByCancel(List<Booking> bookings) {
		List<Booking> list = new ArrayList<>();
		for (Booking booking : bookings) {
			if (booking.isCancelled() == false) { 
				list.add(booking);
			}
		}
		return list;
	}
	
//	tiếp nhận yêu cầu hủy đặt phòng của khách theo id
	@GetMapping("/cancel/{id}") // xử lý yêu cầu HTTP trên đường dẫn "/manage/cancel/{id}"
	public String cancelBooking(
			@PathVariable("id") Long id,
			@RequestParam(name = "roomName", required = false) String roomName,
			@SessionAttribute("bookingRoom") Room bookingRoom)
	{
		Booking booking = bookingRepo.findById(id).orElse(null);
		if (booking != null) {
			// Xóa Booking từ cơ sở dữ liệu
			bookingRepo.delete(booking);
			System.out.println("Đã xóa Booking thành công.");
		} else {
			System.out.println("Không tìm thấy Booking với ID: " + id);
		}

		Long maPhong = bookingRoom.getId();
		String link = "redirect:/manage/booking/" + maPhong.toString();
		return link;
	}

	@GetMapping("/checkout/{id}") // đây là hàm chấp nhận thanh toán và nhận phòng
	public String checkoutAccount(@PathVariable("id") Long id,
								  @RequestParam(name = "roomName", required = false) String roomName,
								  @SessionAttribute("bookingRoom") Room bookingRoom) {
		Booking booking = bookingRepo.findById(id).orElse(null);
		booking.setStatus("Đã trả phòng");
		booking.setReceive(false);
		bookingRepo.save(booking);
		Long maPhong = bookingRoom.getId();
		String link = "redirect:/manage/booking/" + maPhong.toString();
		return link;
	}
	@GetMapping("/enableb/{id}") // đây là hàm chấp nhận thanh toán và nhận phòng
	public String enableAccount(@PathVariable("id") Long id,
								@RequestParam(name = "roomName", required = false) String roomName,
								@SessionAttribute("bookingRoom") Room bookingRoom) {
		Booking booking = bookingRepo.findById(id).orElse(null);
		if (!booking.isReceive()) {
			booking.setReceive(true);
			booking.setPaid(true);
			booking.setStatus("Đã nhận phòng và thanh toán");
			bookingRepo.save(booking);
		}
		Long maPhong = bookingRoom.getId();
		String link = "redirect:/manage/booking/" + maPhong.toString();
		return link;
	}
	@GetMapping("/disableb/{id}") // đầy là hàm hủy đặt phòng
	public String disableAccount(@PathVariable("id") Long id,
								 @RequestParam(name = "roomName", required = false) String roomName,
								 @SessionAttribute("bookingRoom") Room bookingRoom) {
		Booking booking = bookingRepo.findById(id).orElse(null);
		Room room = booking.getRoom();
//		System.out.println(room);
//		room.setStatus("Trống");

//		System.out.println(booking.getRoom());
		if (booking != null) {
			// Xóa Booking từ cơ sở dữ liệu
			booking.setStatus("Đã hủy bởi quản lý");
			booking.setCancelled(true);
			bookingRepo.delete(booking);
		} else {
			System.out.println("Không tìm thấy Booking với ID: " + id);
		}

		Long maPhong = bookingRoom.getId();
		String link = "redirect:/manage/booking/" + maPhong.toString();
		return link;
	}
	
}
