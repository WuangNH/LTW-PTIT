package hotel.data;

import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import hotel.model.Account;

@Repository
public interface AccountRepository extends CrudRepository<Account, Long> {
	
	//phương thức findByUsername(String username) để tìm kiếm một đối tượng Account dựa trên username
	//Optional<Account> để tránh trả về null khi không tìm thấy đối tượng Account tương ứng với username.
	Optional<Account> findByUsername(String username);

	@Query("SELECT a FROM Account a WHERE a.username = :username")
	Account findByUsername1( String username);
}
