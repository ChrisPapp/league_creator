package league;

import java.sql.*;
import database.DatabaseAccess;

public class Team {
	private int id;
	private String name, logo;
	private int leagueId;
	private int leaderId;

	public Team(int id, int leagueId, String name, String logoPath) {
		this.id = id;
		this.leagueId = leagueId;
		this.name = name;
		this.logo = logoPath;
		this.leaderId = -1;
	}

	public Team(int id, int leagueId, String name, String logoPath, int leaderId) {
		this.id = id;
		this.leagueId = leagueId;
		this.name = name;
		this.logo = logoPath;
		this.leaderId = leaderId;
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
}