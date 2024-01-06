/*
 * package conn;
 *
 * import java.sql.Connection; import java.sql.DriverManager; import
 * java.sql.SQLException;
 *
 * import com.mysql.cj.jdbc.DatabaseMetaData;
 *
 * public class JDBCUtil { public static Connection getConnection() { // phuong
 * thuc tra ve kieu du lieu la Connection Connection c = null; try {
 * DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());// dang ky MySQL
 * Driver voi DriverManager
 *
 * // Các thông số String url = "jdbc:mySQL://localhost:3306/httt"; String
 * username = "root"; String password = "root";
 *
 * //Tạo kết nối c = DriverManager.getConnection(url, username, password);
 *
 *
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } return c; } public static void
 * closeConnection(Connection c) { try { if (c != null) { c.close(); } }catch
 * (Exception e) { // TODO: handle exception e.printStackTrace(); } } public
 * static void printInfo(Connection c) { try { if (c != null) { DatabaseMetaData
 * mtdt = (DatabaseMetaData) c.getMetaData();
 * System.out.println(mtdt.getDatabaseProductName());
 * System.out.println(mtdt.getDatabaseProductVersion()); } } catch (SQLException
 * e) { // TODO Auto-generated catch block e.printStackTrace(); } } }
 */


package hotel.Conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    public static Connection getConnection() {
        Connection c = null;
        try {
            // Các thông số
            String url = "jdbc:mysql://localhost:3306/hotel?useUnicode=true&characterEncoding=UTF-8";
            String username = "root";
            String password = "root";

            // Tạo kết nối
            c = DriverManager.getConnection(url, username, password);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public static void closeConnection(Connection c) {
        try {
            if (c != null) {
                c.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
