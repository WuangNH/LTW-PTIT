package hotel.controller;

import java.util.List;

import hotel.data.AccountRepository;
import hotel.data.ClientRepository;
import hotel.data.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import hotel.model.Room;
import hotel.data.RoomRepository;

import javax.servlet.http.HttpSession;

@Controller 
@RequestMapping("/manage/room")// xử lý yêu cầu HTTP trên đường dẫn "/manage/room" mức class
@SessionAttributes("alteredRoom") // thuộc tính "alteredRoom" - được lưu trữ trong phiên
public class ManageRoomController {

	@Autowired // tự động tiêm các đối tượng để sử dụng các phương thức và thuộc tính
	private AccountRepository accountRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private ClientRepository clientRepo;

	@Autowired
	private RoomRepository roomRepo;

	@ModelAttribute("alteredRoom")
	public Room room() {
		return new Room();
	}

	@GetMapping 
	public String manageRoomFrm(Model model) {
		List<Room> rooms = (List<Room>) roomRepo.findAll();
		model.addAttribute("rooms", rooms);
		return "manageRoomList"; 
	}

	@GetMapping("/booked")
	public String manageRoomBooked(Model model) {
		List<Room> roomsOutOfStock = roomRepo.findByStatus("Hết");
		model.addAttribute("rooms", roomsOutOfStock);
		return "manageRoomBooked";
	}

	@GetMapping("/floor/{id}") //
	public String viewFloor(Model model, @PathVariable("id") Long id, HttpSession session) {
		List<Room> roomsFL = (List<Room>) roomRepo.findByFloor(id);
		model.addAttribute("roomsFL", roomsFL);
		Long floor = id;
		model.addAttribute("floor", floor);
		return "manageRoomFloor";
	}

	@GetMapping("/type")
	public String viewType(Model model,
						   @RequestParam(name = "floor", required = false) Long floor,
						   @RequestParam(name = "type", required = false, defaultValue = "Thường") String type) {


		// Lấy danh sách phòng theo floor và type
		List<Room> roomsType = roomRepo.findByFloorAndType(floor, type);

		// Thêm danh sách phòng vào model
		model.addAttribute("roomsType", roomsType);

		// Thêm giá trị floor và type vào model
		model.addAttribute("floor", floor);
		model.addAttribute("type", type);

		return "manageRoomType";
	}
	
//	xem chi tiết phòng 
	@GetMapping("/details/{id}") 
	public String manageRoomDetails(Model model, 
			@PathVariable("id") Long id) {
		Room room = roomRepo.findById(id).orElse(null);
		model.addAttribute("room", room);
		return "manageRoomDetail"; 
	}

//	thay đổi thông tin phòng theo id
	@GetMapping("/change/{id}") 
	public String changeRoomInfo(Model model, 
			@PathVariable("id") Long id,
			@SessionAttribute("alteredRoom") Room alteredroom) {
		Room room = roomRepo.findById(id).orElse(null);
		if (room != null) {
			alteredroom.setId(room.getId());
			alteredroom.setName(room.getName());
		}
		model.addAttribute("room", room);
		return "changeRoomDetail";
	}
	
	

	@PostMapping("/change") // tiếp nhận data thay đổi phòng trong SessionAttribute("alteredRoom")
	public String confirmChange(Room room, 
			@SessionAttribute("alteredRoom") Room alteredroom) {
//		cập nhập các thông tin như giá, loại phòng rồi lưu vào csdl
		alteredroom.setPrice(room.getPrice());
		alteredroom.setType(room.getType());
		alteredroom.setFloor(room.getFloor());
		alteredroom.setDescription(room.getDescription());
		alteredroom.setImage(room.getImage());
		roomRepo.save(alteredroom);
		return "redirect:/manage/room"; 
	}
	// xoá phòng theo id
	@GetMapping("/delete/{id}")
	public String deleteRoom(@PathVariable("id") Long id) {
		roomRepo.deleteById(id);
		return "redirect:/manage/room";
	}

	@GetMapping("/changeSTT/{id}")
	public String changeSTTRoom(@PathVariable("id") Long id) {
		Room room = roomRepo.findById(id).orElse(null);
		if(room.getStatus().equals("Trống")) {
			room.setStatus("Hết");
		}
		else {
			room.setStatus("Trống");
		}
		roomRepo.save(room);
		return "redirect:/manage/room/details/" + id;
	}
	
//	tiếp nhận yêu cầu thêm phòng
	@GetMapping("/add") 
	public String addRoom(Model model) {
		model.addAttribute("room", new Room());
		return "addRoom";
	}
	
//	tiếp nhận data từ đường dẫn "/manage/room/add"
	@PostMapping("/add")
	public String saveRoom(Room room) {
		roomRepo.save(room);
		return "redirect:/manage/room";
	}
	
}
