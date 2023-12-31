package hotel.data;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import hotel.model.Room;

import java.util.List;


@Repository
public interface RoomRepository extends CrudRepository<Room, Long>{
    List<Room> findByFloor(Long floor);

    List<Room> findByFloorAndType(Long floor, String type);

    Room findByName(String roomName);

    List<Room> findByStatus(String status); // Thêm phương thức tìm phòng theo trạng thái

    // đếm số tầng khả dụng
    @Query("SELECT COUNT(DISTINCT r.floor) FROM Room r WHERE r.floor > 0")
    long countAvailableFloors();
}
