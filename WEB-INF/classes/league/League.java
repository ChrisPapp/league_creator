package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.sql.*;
import java.time.LocalDateTime;

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

	// Get League Posts ordered by date
	public ArrayList<Post> getPosts() {
		Connection con = null;
		PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Post> postList = new ArrayList<Post>();
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT * FROM post JOIN " + DatabaseAccess.getDatabaseName() + ".user u ON post.poster_id = u.iduser WHERE u.league_id = ?";
			stmt = con.prepareStatement(query);
            stmt.setInt(1, this.getId());
			rs = stmt.executeQuery();
			while (rs.next()) {
				java.sql.Timestamp ts = rs.getObject("date", java.sql.Timestamp.class);
                LocalDateTime dateTime = ts.toLocalDateTime();
                User user = new User("Chris", "Pappas", "chrispappas99@yahoo.gr", "chrispappas", "1234", "6969696969", true);
				Post post = new Post(rs.getInt("idpost"), rs.getString("title"), rs.getString("content"), user, dateTime);
				postList.add(post);
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
		return postList;
	}

	public int getId() {
		return league_id;
	}

	public void setId(int league_id) {
		this.league_id = league_id;
	}

}