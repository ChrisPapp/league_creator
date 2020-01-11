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


}