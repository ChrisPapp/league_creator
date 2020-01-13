
// *
//* @author ������� ������ 8170117
//*
//*/

package league;

import java.sql.*;
import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;

public class User {

	private int id;
	private String name;
	private String surname;
	private String email;
	private String username;
	private String phone;
	private String profilePic; // Link to profile picture (assumes that it is valid)
	private boolean canReferee;
	private boolean canPost;
	private boolean isAdmin;
	private int leagueid;
	private Team team;

	public User(int id, String name, String surname, String email, String username, String phone, String profilePic,
			boolean canReferee, boolean canPost, boolean isAdmin, int leagueid, Team team) {
		this.id = id;
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.username = username;
		this.phone = phone;
		this.profilePic = profilePic;
		this.canPost = canPost;
		this.isAdmin = isAdmin;
		this.canPost = canPost;
		this.canReferee = canReferee;
		this.leagueid = leagueid;
		this.team = team;
	}

	public User(int id, String name, String surname) {
		this.id = id;
		this.name = name;
		this.surname = surname;
	}

	public static User getById(int id) {
		User user = null;
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT * FROM " + DatabaseAccess.getDatabaseName() + ".user LEFT JOIN team ON user.team_id=team.idteam WHERE iduser=?;";
			stmt = con.prepareStatement(query);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			while (rs.next()) {
				user = User.constructUser(rs);
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
			return user;
		}
	}

	// Creates a User object from a ResultSet. The given ResultSet should be checked for validity.
	// rs.next should have been called outside this function
	public static User constructUser(ResultSet rs){
		Team team;
		int teamId, leagueId;
		String name, logoPath;
		User user = null; 
		
		try {
		teamId = rs.getInt("team_id");
		if (rs.wasNull()) {
			team = null;
		} else {
			leagueId = rs.getInt("league_id");
			name = rs.getString("team_name");
			logoPath = rs.getString("logo_path");
			team = new Team(teamId, leagueId, name, logoPath);
		}
		user = new User(rs.getInt("iduser"), rs.getString("name"), rs.getString("surname"),
				rs.getString("mail"), rs.getString("username"), rs.getString("phone"),
				rs.getString("profile_pic"), rs.getBoolean("canReferee"), rs.getBoolean("canPost"),
				rs.getBoolean("is_admin"), rs.getInt("league_id"), team);
		} catch (SQLException e){

		}
		
		return user;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the surname
	 */
	public String getSurname() {
		return surname;
	}

	/**
	 * @param surname the surname to set
	 */
	public void setSurname(String surname) {
		this.surname = surname;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public boolean canReferee() {
		return this.canReferee;
	}

	public int getId() {
		return this.id;
	}

	public int getLeagueid() {
		return leagueid;
	}

	public void setLeagueid(int leagueid) {
		this.leagueid = leagueid;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", name=" + name + ", surname=" + surname + ", email=" + email + "]";
	}

	public String getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}

	public boolean isCanPost() {
		return canPost;
	}

	public void setCanPost(boolean canPost) {
		this.canPost = canPost;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getFullName() {
		if (name == null && surname == null) {
			return "Anonymous";
		} else if (name == null) {
			return this.surname;
		} else if (surname == null) {
			return this.name;
		} else {
			return this.name + " " + this.surname;
		}
	}

	// Return a list with match Results
	// If referee is True, it will return matches where this user was Referee
	// If referee is False, it will return matches where this user's Team was playing
	public List<Result> getMatches(boolean referee) {
		List<Result> resList = new ArrayList<Result>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
			con = DatabaseAccess.getConnection();
			String whereClause = referee ? "WHERE m.referee_id = ? " : "WHERE m.team_home = ? OR m.team_away = ? ";
            final String query = 
            "SELECT m.idmatch, homeStats.goals_scored, awayStats.goals_scored, home.team_name, away.team_name " + 
			"FROM " + DatabaseAccess.getDatabaseName() + ".match m " + 
			"JOIN stats homeStats ON m.idmatch = homeStats.match_id AND m.team_home = homeStats.team_id " +
			"JOIN team home ON homeStats.team_id = home.idteam " +
			"JOIN stats awayStats ON m.idmatch = awayStats.match_id AND m.team_away = awayStats.team_id " +
			"JOIN team away ON awayStats.team_id = away.idteam " +
			whereClause +
			"ORDER BY date DESC;";
			stmt = con.prepareStatement(query);
			if (referee) {
				stmt.setInt(1, this.getId());
			} else {
				stmt.setInt(1, this.getTeam().getId());
				stmt.setInt(2, this.getTeam().getId());
			}
            rs = stmt.executeQuery();
            while (rs.next()) {
                Integer nValue = rs.getInt(1);                      // Notice getInt will return 0 if SQL value was null, therefore we use rs.wasNull
                Integer matchId = rs.wasNull() ? null : nValue;
                nValue = rs.getInt(2);
                Integer goalsHome = rs.wasNull() ? null : nValue;
                nValue = rs.getInt(3);
				Integer goalsAway = rs.wasNull() ? null : nValue;
				String homeName = rs.getString(4);
				String awayName = rs.getString(5);
                final Result res = new Result(matchId, goalsHome, goalsAway, homeName, awayName);
                resList.add(res);
            }
        } catch (final SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                rs.close();
            } catch (final Exception e) {
                /* ignored */ }
            try {
                stmt.close();
            } catch (final Exception e) {
                /* ignored */ }
            try {
                con.close();
            } catch (final Exception e) {
                /* ignored */ }
        }
		return resList;
	}

	public void update()
    {

		Connection con = null;
		PreparedStatement stmt = null;
        
		try {
            con = DatabaseAccess.getConnection();
            String query = "UPDATE " + DatabaseAccess.getDatabaseName() + ".user SET " +
            "name = ?, " + 
			"surname = ?, " + 
			"mail = ?, " + 
			"phone = ?, " + 
			"profile_pic = ? " + 
            "WHERE iduser = ?";    
            stmt = con.prepareStatement(query);
			stmt.setString(1, this.name);
			stmt.setString(2, this.surname);
			stmt.setString(3, this.email);
			stmt.setString(4, this.phone);
			stmt.setString(5, this.profilePic);
            stmt.setInt(6, this.id);
            stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				stmt.close();
			} catch (Exception e) {
				/* ignored */ }
			try {
				con.close();
			} catch (Exception e) {
				/* ignored */ }
		}
	}

	public void updateTeam(Integer teamId)
    {

		Connection con = null;
		PreparedStatement stmt = null;
        
		try {
            con = DatabaseAccess.getConnection();
            String query = "UPDATE " + DatabaseAccess.getDatabaseName() + ".user SET " +
            "team_id = ? " + 
            "WHERE iduser = ?";    
            stmt = con.prepareStatement(query);
			if (teamId != null){
				stmt.setInt(1, teamId);
			} else {
				stmt.setNull(1, java.sql.Types.INTEGER);
			}
			stmt.setInt(2, this.id);
            stmt.executeUpdate();
		} catch (SQLException e) {

		} finally {
			try {
				stmt.close();
			} catch (Exception e) {
				/* ignored */ }
			try {
				con.close();
			} catch (Exception e) {
				/* ignored */ }
		}
	}
	
	public Team getTeam(){
		return this.team;
	}

	public boolean isTeamLeader(){
		return this.team != null && this.team.getId() == this.id;
	}

} // End of class
