package league;

import java.sql.*;
import database.DatabaseAccess;
import java.util.List;
import java.util.ArrayList;

public class Team {
	private int id;
	private String name, logo;
	private int leagueId;
	private int leaderId;
	private List<User> members;

	public Team(int id, int leagueId, String name, String logoPath) {
		this.id = id;
		this.leagueId = leagueId;
		this.name = name;
		this.logo = logoPath;
		this.leaderId = -1;
		this.members = null;
	}

	public Team(int id, int leagueId, String name, String logoPath, int leaderId) {
		this.id = id;
		this.leagueId = leagueId;
		this.name = name;
		this.logo = logoPath;
		this.leaderId = leaderId;
		this.members = null;
	}

	public Team(int id, int leagueId, String name, String logoPath, int leaderId, List<User> members) {
		this.id = id;
		this.leagueId = leagueId;
		this.name = name;
		this.logo = logoPath;
		this.leaderId = leaderId;
		this.members = null;
	}

	public String getName() {
		return this.name;
	}

	public String getLogo() {
		return this.logo;
	}

	public int getId() {
		return this.id;
	}

	public int getLeagueId() {
		return this.leagueId;
	}

	public int getLeaderId() {
		return this.leaderId;
	}

	public boolean equals(Team other) {
		return other.getId() == this.getId();
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<User> getMembers() {
		return this.members;
	}

	public void setMembers(List<User> members) {
		this.members = members;
	}

	// Adds a new Team to the Databas and returns the auto-generated id of the new Team record
	public static Integer createTeam(Team team) throws Exception {


		Connection con = null;
		String insertNewUserSQL = "INSERT INTO team"
			+ " ( league_id, team_name,  logo_path, leader_id ) "
			+ " VALUES (?, ?, ?, ?);";
		Integer teamId = null;

			try {

				con = DatabaseAccess.getConnection(); //get Connection

				PreparedStatement stmt = con.prepareStatement(insertNewUserSQL, PreparedStatement.RETURN_GENERATED_KEYS);

				stmt.setInt(1, team.getLeagueId());
				stmt.setString(2, team.getName());
				stmt.setString(3, team.getLogo());
				stmt.setInt(4, team.getLeaderId());

				stmt.executeUpdate();   // User table will also be updated via trigger in SQL
				ResultSet rs = stmt.getGeneratedKeys();
				rs.next();
				teamId = rs.getInt(1);
				stmt.close();


			} catch (SQLIntegrityConstraintViolationException  e) {

				throw new Exception("Team already exists.");

			} catch (SQLException e) {

				throw new Exception(e.getMessage());

			} finally {

				if(con != null) // if connection is still open, then close.
				con.close();

			}
			return teamId;

		}//end of register

		// Returns a team with all its members
		public static Team getById(int teamId, int leagueId) throws SQLException {
			Team team = null;
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				con = DatabaseAccess.getConnection();
				String query = "SELECT * FROM team WHERE idteam = ? AND team.league_id = ?";
				stmt = con.prepareStatement(query);
				stmt.setInt(1, teamId);
				stmt.setInt(2, leagueId);
				rs = stmt.executeQuery();
				while (rs.next()) {
					team = new Team(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5));
				}
				if (team != null) {
					List<User> members = new ArrayList<User>();
					query = "SELECT * FROM user WHERE user.team_id = ?";
					stmt = con.prepareStatement(query);
					stmt.setInt(1, team.getId());
					rs = stmt.executeQuery();
					while (rs.next()) {
						User user = User.constructUser(rs, team);
						members.add(user);
					}
					team.setMembers(members);
				}
			} catch (SQLException e) {
				throw e;
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
			return team;
		}

		public void setName(String name) {
			this.name = name;
		}

		public void setLogo(String logo) {
			this.logo = logo;
		}

		public void update() throws SQLException {

		Connection con = null;
		PreparedStatement stmt = null;
        
		try {
            con = DatabaseAccess.getConnection();
            String query = "UPDATE " + DatabaseAccess.getDatabaseName() + ".team SET " +
            "team_name = ?, " + 
			"logo_path = ? " + 
            "WHERE idteam = ?";    
            stmt = con.prepareStatement(query);
			stmt.setString(1, this.name);
			stmt.setString(2, this.logo);
            stmt.setInt(3, this.id);
            stmt.executeUpdate();
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				stmt.close();
			} catch (Exception e) {
				throw e;
			}
			try {
				con.close();
			} catch (Exception e) {
				throw e; }
		}
	}

	
}