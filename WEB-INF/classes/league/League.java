package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.sql.*;

public class League {

	private int league_id;
	private String name;
	private String logo_path;

	public League(int id, String name, String logo) {
		this.league_id = id;
		this.name = name;
		this.logo_path = logo;
	}

	// Search for a league in the database with the give name. If it does not exist
	// return null
	public static League getByName(String leagueName) {
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
			while (rs.next()) {
				Team currTeam = new Team(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4));
				teams.add(currTeam);
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
		}
		return teams;
	}

	public ArrayList<Group> getLeagueGroups() {
		ArrayList<Group> groups = new ArrayList<Group>();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT * FROM " + DatabaseAccess.getDatabaseName() + ".group WHERE league_id = ?";
			stmt = con.prepareStatement(query);
			stmt.setInt(1, this.league_id);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Group currGroup = new Group(rs.getInt(1), rs.getString(3));
				groups.add(currGroup);
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
		}
		return groups;
	}

	public String getName() {
		return this.name;
	}

	public String getLogo() {
		return this.logo_path;
	}
}