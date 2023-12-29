package hotel.data;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import hotel.model.Room;

import java.util.List;


@Repository
public interface RoomRepository extends CrudRepository<Room, Long>{
    List<Room> findByFloor(Long floor);

    List<Room> findByFloorAndType(Long floor, String type);

    Room findByName(String roomName);

}
