package league;
import database.DatabaseAccess;
import java.util.ArrayList;
import java.sql.*;

public class Group {

	private final int groupId;
    private final String name;

    public Group(final int id, final String name) {
        this.groupId = id;
        this.name = name;
    }

    public ArrayList<Team> getGroupTeams() {
        final ArrayList<Team> teams = new ArrayList<Team>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = DatabaseAccess.getConnection();
            final String query = "SELECT team.idteam, team.league_id, team.name, team.logo_path FROM group_teams INNER JOIN team ON team.idteam = group_teams.team_id WHERE group_id = ?;";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, this.groupId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                final Team currTeam = new Team(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4));
                teams.add(currTeam);
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
		return teams;
	}
}