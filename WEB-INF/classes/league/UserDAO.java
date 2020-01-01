package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;


// *
// * @author ”…Ã…‘∆« …Ÿ¡ÕÕ¡ 8170117
// *
// *

public class UserDAO {


	public User authenticate(String username, String password) throws Exception {

			Connection con = null;
			DatabaseAccess db = new DatabaseAccess();
			String sqlQuery = "SELECT * FROM user WHERE username=? AND password=? ;";
			PreparedStatement stmt = null;
			ResultSet rs = null;
		 	User user = null;

			try {

					con = db.getConnection();

					stmt = con.prepareStatement(sqlQuery);
					stmt.setString(1, username);
					stmt.setString(2, password);

					rs = stmt.executeQuery();

					if ( rs.next() ) {

						user = new User(rs.getString("name"), rs.getString("surname"), rs.getString("email"), rs.getString("username"), rs.getString("password"));
					}
					rs.close();
					stmt.close();


					return user;

					} catch (Exception e) {

						throw new Exception("Wrong username or password:" + e.getMessage());

					} finally {

						if(con != null)
							con.close();
					}
	} //End of authenticate


	public void register(User user) throws Exception {

			Connection con = null;
			DatabaseAccess db = new DatabaseAccess ();
			String insertNewUserSQL = "INSERT INTO user "
					+ " ( username, name, surname, email, password) "
					+ " VALUES (?, ?, ?, ?, ?);";

			try {

					con = db.getConnection(); //get Connection

					PreparedStatement stmt = con.prepareStatement(insertNewUserSQL);

					stmt.setString(1, user.getUsername());
					stmt.setString(2, user.getName());
					stmt.setString(3, user.getSurname());
					stmt.setString(4, user.getEmail());
					stmt.setString(5, user.getPassword());

					stmt.executeUpdate();
					stmt.close();


			} catch (SQLIntegrityConstraintViolationException  e) {
					// if username or email already registered
					throw new Exception("User already exists.");

			} catch (SQLException e) {

					throw new Exception(e.getMessage());

			} catch (Exception e) {

					throw new Exception(e.getMessage());

			} finally {

					if(con != null) // if connection is still open, then close.
						con.close();

		}



	}//end of register

} //End of class
