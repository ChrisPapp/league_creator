package league;
import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeSet;
import java.util.Collections;
import java.util.List;
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
            final String query = "SELECT team.idteam, team.league_id, team.team_name, team.logo_path FROM group_teams INNER JOIN team ON team.idteam = group_teams.team_id WHERE group_id = ?;";
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

    public TreeSet<TeamStats> getGroupRankings() {
        final TreeSet<TeamStats> rankings = new TreeSet<TeamStats>(Collections.reverseOrder()); // TreeSet are in ascending order, we need descending
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = DatabaseAccess.getConnection();
            final String query = "SELECT team.idteam, team.league_id, team.team_name, team.logo_path, sum(teamStats.goals_scored) AS goals_scored, " +
            "sum(enemyStats.goals_scored) AS goals_against, " +
            "count(case when teamStats.goals_scored > enemyStats.goals_scored then 1 else null end) AS wins, " +
            "count(case when teamStats.goals_scored = enemyStats.goals_scored then 1 else null end) AS draws," +
            "count(case when teamStats.goals_scored < enemyStats.goals_scored then 1 else null end) AS defeats " +
            "FROM stats teamStats " +
            "JOIN ismgroup62.match m ON m.idmatch = teamStats.match_id " +
            "JOIN stats enemyStats ON teamStats.team_id != enemyStats.team_id AND m.idmatch = enemyStats.match_id " +
            "JOIN team ON teamStats.team_id = team.idteam " +
            "WHERE m.group_id = ? " +
            "GROUP BY teamStats.team_id;";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, this.groupId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                final Team currTeam = new Team(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4));
                Integer goalsScored = rs.getInt("goals_scored");
                if (rs.wasNull()) {
                    goalsScored = null;
                }
                Integer goalsAgainst = rs.getInt("goals_against");
                if (rs.wasNull()) {
                    goalsAgainst = null;
                }
                final Integer wins = rs.getInt("wins");
                final Integer draws = rs.getInt("draws");
                final Integer defeats = rs.getInt("defeats");
                rankings.add(new TeamStats(currTeam, goalsScored, goalsAgainst, wins, draws, defeats));
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
		return rankings;
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

    public String getName() {
        return name;
    }

    public static void createGroup(List<Integer> teams, String name, int leagueId) throws SQLException
    {

		Connection con = null;
		PreparedStatement stmt = null;
        ResultSet rs = null;
        
		try {
            con = DatabaseAccess.getConnection();
            String queryGroup = "INSERT INTO " + DatabaseAccess.getDatabaseName() + ".group (league_id, name) VALUES (?, ?);";  
            stmt = con.prepareStatement(queryGroup, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, leagueId);
            stmt.setString(2, name);
            stmt.executeUpdate(); // First create Group record
            String queryGroupTeam = "INSERT INTO " + DatabaseAccess.getDatabaseName() + ".group_teams (group_id, team_id) VALUES (?, ?) ";

            // Now we have to add every team id to group_teams
            ResultSet keys = stmt.getGeneratedKeys();
            keys.next();
            int groupId = keys.getInt(1);
            stmt = con.prepareStatement(queryGroupTeam);
            stmt.setInt(1, groupId);
            for (Integer teamId : teams) {
                stmt.setInt(2, teamId);
                stmt.addBatch();
            }
            con.setAutoCommit(false);
            stmt.executeBatch();
            con.commit();
            // Then we run the stored procedure that creates/initializes the Matches and Stats records for this group
            String queryProc = "{CALL GroupCreated(?)}";
            CallableStatement cstmt = con.prepareCall(queryProc);
            cstmt.setInt(1, groupId);
            cstmt.execute();
			
		} catch (SQLException e) {
			throw new SQLException(e.getMessage());
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
    }

    public static void deleteById(int groupId) throws SQLException
    {

		Connection con = null;
		PreparedStatement stmt = null;
        ResultSet rs = null;
        
		try {
            con = DatabaseAccess.getConnection();
            // Just use the transaction stored in mySQL
            String queryProc = "{CALL DeleteGroup(?)}";
            CallableStatement cstmt = con.prepareCall(queryProc);
            cstmt.setInt(1, groupId);
            cstmt.execute();
			
		} catch (SQLException e) {
			throw new SQLException(e.getMessage());
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
    }

    public int getId() {
        return this.groupId;
    }
}