//author IOANNA SIMITZI 8170117

package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;


public class LeagueDAO {

 public List<League> getAllLeagues() throws Exception {

	Connection con = null;
	DatabaseAccess db = new DatabaseAccess();
	String SQLQuery = "SELECT * FROM league;";
	PreparedStatement stmt = null;
	ResultSet rs = null;

	con = db.getConnection();

	List<League> leagues = new ArrayList<League>();

	try {

		con = db.getConnection();
		stmt = con.prepareStatement(SQLQuery);
		rs = stmt.executeQuery();

		while (rs.next()) {

			leagues.add(new League(rs.getInt("idleague"), rs.getString("name"), rs.getString("logo_path")));
		}

		rs.close();
		stmt.close();


		return leagues;

	} catch (Exception e){

		throw new Exception("An error has occured while getting leagues from db: " + e.getMessage());

	} finally {

		if (con != null)
			con.close();

	}

 }

 public static League getLeagueByName(String leagueName) {
 		League league = null;
 		Connection con = null;
 		PreparedStatement stmt = null;
 		ResultSet rs = null;
 		try {
 			con = DatabaseAccess.getConnection();
 			String query = "SELECT * FROM league WHERE league.name = ?";
 			stmt = con.prepareStatement(query);
 			stmt.setString(1, leagueName);
 			rs = stmt.executeQuery();
 			while (rs.next()) {
 				league = new League(rs.getInt(1), rs.getString(2), rs.getString(3));
 			}
 		} catch (SQLException e) {
 			System.out.println(e.getMessage());
 		} finally {
 			try {
 				rs.close();
 			} catch (Exception e) {
 				/* ignored */ }
 			try {
 				stmt.close();
 			} catch (Exception e) {
 				/* ignored */ }
 			try {
 				con.close();
 			} catch (Exception e) {
 				/* ignored */ }
 			return league;
 		}
	}

	public void register(League league, String pass) throws Exception {

				Connection con = null;
				DatabaseAccess db = new DatabaseAccess ();
				String insertNewUserSQL = "INSERT INTO league "
						+ " ( name, logo_path ) "
						+ " VALUES (?, ?);";

				try {

						con = db.getConnection(); //get Connection

						PreparedStatement stmt = con.prepareStatement(insertNewUserSQL);

						stmt.setString(1, league.getName());
						stmt.setString(2, league.getLogo());

						stmt.executeUpdate();
						stmt.close();


				} catch (SQLIntegrityConstraintViolationException  e) {
						// if username or email already registered
						throw new Exception("League already exists.");

				} catch (SQLException e) {

						throw new Exception(e.getMessage());

				} catch (Exception e) {

						throw new Exception(e.getMessage());

				} finally {

						if(con != null) // if connection is still open, then close.
							con.close();

			}

	}//end of register


}