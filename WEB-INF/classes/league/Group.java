package league;
import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.HashMap;
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
    
    /*  Returns results in map of home team ids to a another map of away team ids to coresponding Result. 
        E.g Use map.get(homeId).get(awayId) to get the Result */
    public HashMap<Integer, HashMap<Integer, Result>> getGroupResults() {
        HashMap<Integer, HashMap<Integer, Result>> resultMap = new HashMap<Integer, HashMap<Integer, Result>>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = DatabaseAccess.getConnection();
            final String query = 
            "SELECT " + DatabaseAccess.getDatabaseName() + ".match.idmatch, homeStats.goals_scored, awayStats.goals_scored, homeStats.team_id, awayStats.team_id" + 
            " FROM stats homeStats" + 
            " JOIN stats awayStats ON homeStats.match_id = awayStats.match_id" + 
            " JOIN " + DatabaseAccess.getDatabaseName() + ".match ON homeStats.match_id = " + DatabaseAccess.getDatabaseName() + ".match.idmatch" +  
            " AND homeStats.team_id = " + DatabaseAccess.getDatabaseName() + ".match.team_home" + 
            " AND awayStats.team_id = " + DatabaseAccess.getDatabaseName() + ".match.team_away" + 
            " WHERE " + DatabaseAccess.getDatabaseName() + ".match.group_id = ?;";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, this.groupId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Integer nValue = rs.getInt(1);                      // Notice getInt will return 0 if SQL value was null, therefore we use rs.wasNull
                Integer matchId = rs.wasNull() ? null : nValue;
                nValue = rs.getInt(2);
                Integer goalsHome = rs.wasNull() ? null : nValue;
                nValue = rs.getInt(3);
                Integer goalsAway = rs.wasNull() ? null : nValue;
                final Result res = new Result(matchId, goalsHome, goalsAway);
                int homeId = rs.getInt(4);
                int awayId = rs.getInt(5);
                HashMap<Integer, Result> teamResultMap = resultMap.get(homeId);
                if (teamResultMap == null) {
                    teamResultMap = new HashMap<Integer, Result>();
                    resultMap.put(homeId, teamResultMap);
                }
                resultMap.get(homeId).put(awayId, res);
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
		return resultMap;
	}
}