
package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class PostDAO {

	public void register(Post post1, User user1) throws Exception {


			Connection con = null;
			DatabaseAccess db = new DatabaseAccess ();
			String insertNewUserSQL = "INSERT INTO post"
				+ " ( poster_id,  title, content, date) "
				+ " VALUES (?, ?, ?, NOW());";

				try {

					con = db.getConnection(); //get Connection

					PreparedStatement stmt = con.prepareStatement(insertNewUserSQL);

					stmt.setInt(1, user1.getId());
					stmt.setString(2, post1.getTitle());
					stmt.setString(3, post1.getContent());

					stmt.executeUpdate();
					stmt.close();


				} catch (SQLIntegrityConstraintViolationException  e) {

					throw new Exception("Team already exists.");

				} catch (SQLException e) {

					throw new Exception(e.getMessage());

				} finally {

					if(con != null) // if connection is still open, then close.
					con.close();

				}

		}//end of register



}