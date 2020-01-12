package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;


// *
// * @author SIMITZI IOANNA 8170117
// *
// *

public class UserDAO {


	public User authenticate(String username, String password) throws Exception {

			Connection con = null;
			DatabaseAccess db = new DatabaseAccess();
			String sqlQuery = "SELECT * FROM user WHERE username=? AND pswd=? ;";
			PreparedStatement stmt = null;
			ResultSet rs = null;
		 	User user = null;

			try {

					con = db.getConnection();

					stmt = con.prepareStatement(sqlQuery);
					stmt.setString(1, username);
					stmt.setString(2, password);

					rs = stmt.executeQuery();

					if ( !rs.next() ) {

						throw new Exception("Wrong username or password");
					}

					user = new User(rs.getInt("iduser"), rs.getString("name"), rs.getString("surname"),
						rs.getString("mail"), rs.getString("username"), rs.getString("phone"),
						rs.getString("profile_pic"), rs.getBoolean("canReferee"), rs.getBoolean("canPost"),
						rs.getBoolean("is_admin"), rs.getInt("league_id"));

					rs.close();
					stmt.close();

					return user;

					} catch (Exception e) {

						throw new Exception(e.getMessage());

					} finally {

						if(con != null)
							con.close();
					}
	} //End of authenticate


	public void register(User user, String pass) throws Exception {

			Connection con = null;
			DatabaseAccess db = new DatabaseAccess ();
			String insertNewUserSQL = "INSERT INTO user "
					+ " ( name, surname, pswd, mail, phone, league_id, username ) "
					+ " VALUES (?, ?, ?, ?, ?, ?, ?);";

			try {

					con = db.getConnection(); //get Connection

					PreparedStatement stmt = con.prepareStatement(insertNewUserSQL);

					stmt.setString(1, user.getName());
					stmt.setString(2, user.getSurname());
					stmt.setString(3, pass);
					stmt.setString(4, user.getEmail());
					stmt.setString(5, user.getPhone());
					stmt.setInt(6, user.getLeagueid());
					stmt.setString(7, user.getUsername());

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

	public void insertleague(User user, League league) throws Exception {

		Connection con = null;
		DatabaseAccess db = new DatabaseAccess();
		String SQLQuery = "	UPDATE user SET league_id=? WHERE username=? ";
		PreparedStatement stmt = null;
		ResultSet rs = null;
	    User user1 = null;

		try {

			con = db.getConnection();

			con.prepareStatement(SQLQuery);

			stmt.setInt(1, league.getId());
			stmt.setString(2, user.getUsername());

			stmt.executeUpdate();

			rs.close();
			stmt.close();


			} catch (Exception e) {

			throw new Exception("User not found: " + e.getMessage());


			} finally {

				if(con != null)
					con.close();

		}
	}
} //End of class
