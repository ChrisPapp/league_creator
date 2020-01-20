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


	public User authenticate(String username, String password, int leagueId) throws Exception {

			Connection con = null;
			DatabaseAccess db = new DatabaseAccess();
			String sqlQuery = "SELECT * FROM user LEFT JOIN team ON team_id = team.idteam WHERE username=? AND pswd=? AND user.league_id = ?;";
			PreparedStatement stmt = null;
			ResultSet rs = null;
		 	User user = null;

			try {

					con = db.getConnection();

					stmt = con.prepareStatement(sqlQuery);
					stmt.setString(1, username);
					stmt.setString(2, password);
					stmt.setInt(3, leagueId);

					rs = stmt.executeQuery();

					if ( !rs.next() ) {

						throw new Exception("Wrong username or password");
					}

					user = User.constructUser(rs, null);

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
			String insertNewUserSQL ="INSERT INTO user ( name, surname, pswd, mail, phone, league_id, username, canPost, canReferee, isAdmin )  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

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
					stmt.setBoolean(8, user.canPost());
					stmt.setBoolean(9, user.canReferee());
					stmt.setBoolean(10, user.isAdmin());

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
