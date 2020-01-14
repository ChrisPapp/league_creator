
//author IOANNA SIMITZI 8170117

package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;


public class TeamDAO {

	public void register(Team team) throws Exception {


		Connection con = null;
		DatabaseAccess db = new DatabaseAccess ();
		String insertNewUserSQL = "INSERT INTO team"
			+ " ( league_id, team_name,  logo_path, leader_id ) "
			+ " VALUES (?, ?, ?, ?);";

			try {

				con = db.getConnection(); //get Connection

				PreparedStatement stmt = con.prepareStatement(insertNewUserSQL);

				stmt.setInt(1, team.getLeagueId());
				stmt.setString(2, team.getName());
				stmt.setString(3, team.getLogo());
				stmt.setInt(4, team.getLeaderId());

				stmt.executeUpdate();
				stmt.close();


			} catch (SQLIntegrityConstraintViolationException  e) {

				throw new Exception("Team already exists.");

			} catch (SQLException e) {

				throw new Exception(e.getMessage());

			} finally {

				if(con != null) // if connection is still open, then close.
				con.close();

			}

		}//end of register

		public static Team getByName(String teamName, User user) {

				Team team = null;
				Connection con = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;

				try {
					con = DatabaseAccess.getConnection();
					String query = "SELECT * FROM team WHERE team.team_name = ? AND team.leader_id = ?";
					stmt = con.prepareStatement(query);
					stmt.setString(1, teamName);
					stmt.setInt(2, user.getId());

					rs = stmt.executeQuery();
					while (rs.next()) {
						team = new Team(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5));
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
					return team;
				}
	}

	public void insertteamid(User user, Team team) throws Exception {

			Connection con = null;
			DatabaseAccess db = new DatabaseAccess();
			String SQLQuery = "	UPDATE user SET team_id=? WHERE username=? ";
			PreparedStatement stmt = null;
			ResultSet rs = null;


			try {

				con = db.getConnection();

				con.prepareStatement(SQLQuery);

				stmt.setInt(1, team.getId());
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


}