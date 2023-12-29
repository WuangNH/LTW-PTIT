package hotel.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import hotel.model.Room;
import hotel.data.RoomRepository;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/room") // xử lý yêu cầu HTTP trên đường dẫn "/room" mức class
public class
RoomController {
	@Autowired
	private RoomRepository roomRepo;

	// xem danh sách các phòng
	@GetMapping
	public String viewList(Model model, HttpSession session) {
		List<Room> rooms = (List<Room>) roomRepo.findAll();
		// Sắp xếp danh sách phòng theo thuộc tính name
		Collections.sort(rooms, Comparator.comparing(Room::getName));
		model.addAttribute("rooms", rooms);
		return "roomList";
	}

	@GetMapping("/floor/{id}") //
	public String viewFloor(Model model, @PathVariable("id") Long id, HttpSession session) {
		List<Room> roomsFL = (List<Room>) roomRepo.findByFloor(id);
		Collections.sort(roomsFL, Comparator.comparing(Room::getName));
		model.addAttribute("roomsFL", roomsFL);
		Long floor = id;
		model.addAttribute("floor", floor);
		return "roomFloor";
	}

	@GetMapping("/type")
	public String viewType(Model model,
						   @RequestParam(name = "floor", required = false) Long floor,
						   @RequestParam(name = "type", required = false, defaultValue = "Thường") String type) {


		// Lấy danh sách phòng theo floor và type
		List<Room> roomsType = roomRepo.findByFloorAndType(floor, type);
		Collections.sort(roomsType, Comparator.comparing(Room::getName));
		// Thêm danh sách phòng vào model
		model.addAttribute("roomsType", roomsType);

		// Thêm giá trị floor và type vào model
		model.addAttribute("floor", floor);
		model.addAttribute("type", type);

		return "roomType";
	}



	// xem chi tiết 1 phòng sử dụng id
	@GetMapping("/details/{id}") //
	public String viewDetails(Model model, @PathVariable("id") Long id, HttpSession session) {
		Room room = roomRepo.findById(id).orElse(null);
		model.addAttribute("room", room);
		return "roomDetail";
	}
}
