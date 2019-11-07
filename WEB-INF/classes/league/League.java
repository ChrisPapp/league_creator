package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.sql.*;

public class League {

	private int league_id;
	private String name;

	public League(int id, String name) {
		this.league_id = id;
		this.name = name;
	}

	public ArrayList<Team> getLeagueTeams() {
		ArrayList<Team> teams = new ArrayList<Team>();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT * FROM team WHERE league_id = ?";
			stmt = con.prepareStatement(query);
			stmt.setInt(1, this.league_id);
			rs = stmt.executeQuery();
			while (rs.next()){
				Team currTeam = new Team(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4));
				teams.add(currTeam);
			}
		} catch (SQLException e) {
				System.out.println(e.getMessage());
		} finally {
			try { rs.close(); } catch (Exception e) { /* ignored */ }
			try { stmt.close(); } catch (Exception e) { /* ignored */ }
			try { con.close(); } catch (Exception e) { /* ignored */ }
        }
		return teams;
	}
}