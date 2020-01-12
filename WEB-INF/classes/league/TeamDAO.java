//author IOANNA SIMITZI 8170117

package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;


public class TeamDAO {

	public void register(Team team, League leaguechoice) throws Exception {


		Connection con = null;
		DatabaseAccess db = new DatabaseAccess ();
		String insertNewUserSQL = "INSERT INTO team"
			+ " ( league_id, name,  logo_path ) "
			+ " VALUES (?, ?, ?);";

			try {

				con = db.getConnection(); //get Connection

				PreparedStatement stmt = con.prepareStatement(insertNewUserSQL);

				stmt.setInt(1, leaguechoice.getId());
				stmt.setString(2, team.getName());
				stmt.setString(3, team.getLogo());

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


}