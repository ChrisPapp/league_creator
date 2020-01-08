package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;
import java.time.LocalTime;

public class Match {

    private final int matchId;
    private final Team home;
    private Stats homeStats;
    private final Team away;
    private Stats awayStats;
    private String refereeName;
    private LocalTime matchDate;

    public Match(int id, Team home, Stats homeStats, Team away, Stats awayStats, String refName, LocalTime date) {
        this.matchId = id;
        this.home = home;
        this.homeStats = homeStats;
        this.away = away;
        this.awayStats = awayStats;
        this.refereeName = refName;
        this.matchDate = date;
    }

    // Search for a match in the database with the given name. If it does not exist
	// return null
	public static Match getById(int id) {
		Match match = null;
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT m.idmatch, referee.name, referee.surname, m.date, home.*, homeStats.goals_scored, homeStats.yellowcards, homeStats.redcards, away.*, awayStats.goals_scored, awayStats.yellowcards, awayStats.redcards " +
            "FROM ismgroup62.match m " +
            "JOIN team home ON m.team_home = home.idteam " +
            "JOIN stats homeStats " +
            "ON m.idmatch = homeStats.match_id AND home.idteam = homeStats.team_id " +
            "JOIN team away ON m.team_away = away.idteam " +
            "JOIN stats awayStats " +
            "ON m.idmatch = awayStats.match_id AND away.idteam = awayStats.team_id " +
            "LEFT JOIN ismgroup62.user referee ON m.referee_id = referee.iduser " +
            "WHERE m.idmatch = ?;";
			stmt = con.prepareStatement(query);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			while (rs.next()) {
                Integer goals, yellow, red;
                Team home = new Team(rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8));
                goals = rs.getInt(9);
                if (rs.wasNull()){
                    goals = null;
                }
                yellow = rs.getInt(10);
                if (rs.wasNull()){
                    yellow = null;
                }
                red = rs.getInt(11);
                if (rs.wasNull()){
                    red = null;
                }
                Stats homeStats = new Stats(goals, yellow, red);
                Team away = new Team(rs.getInt(12), rs.getInt(13), rs.getString(14), rs.getString(15));
                goals = rs.getInt(16);
                if (rs.wasNull()){
                    goals = null;
                }
                yellow = rs.getInt(17);
                if (rs.wasNull()){
                    yellow = null;
                }
                red = rs.getInt(18);
                if (rs.wasNull()){
                    red = null;
                }
                Stats awayStats = new Stats(goals, yellow, red);
				match = new Match(rs.getInt(1), home, homeStats, away, awayStats, rs.getString(2)!= null && rs.getString(3) != null ? rs.getString(2) + rs.getString(3) : "", (LocalTime) rs.getObject(4));
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
			return match;
		}
    }

    public void update(int refId)
    {

		Connection con = null;
		PreparedStatement stmt = null;
        ResultSet rs = null;
        
		try {
            con = DatabaseAccess.getConnection();
            String queryMatch = "UPDATE " + DatabaseAccess.getDatabaseName() + ".match SET " +
            "referee_id = ?, " + 
            "date = ? " + 
            "WHERE idmatch = ?";    
            stmt = con.prepareStatement(queryMatch);
            stmt.setObject(1, refId);
            stmt.setObject(2, this.matchDate);
            stmt.setInt(3, this.matchId);
            stmt.executeUpdate();
            String queryStats = "UPDATE " + DatabaseAccess.getDatabaseName() + ".stats SET " +
            "goals_scored = ?, " + 
            "yellowcards = ?, " + 
            "redcards = ? " + 
            "WHERE match_id = ? AND team_id = ?";

            stmt = con.prepareStatement(queryStats);
            stmt.setObject(1, this.getHomeStats().goalsScored); // Using setObject to handle NULL. int primitive cannot be null.
            stmt.setObject(2, this.getHomeStats().yellowCards);
            stmt.setObject(3, this.getHomeStats().redCards);
            stmt.setObject(4, this.matchId);
            stmt.setObject(5, this.home.getId());
            stmt.addBatch();
            stmt.setObject(1, this.getAwayStats().goalsScored);
            stmt.setObject(2, this.getAwayStats().yellowCards);
            stmt.setObject(3, this.getAwayStats().redCards);
            stmt.setObject(4, this.matchId);
            stmt.setObject(5, this.away.getId());
            stmt.addBatch();
            con.setAutoCommit(false);
            stmt.executeBatch();
            con.commit();
			
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
    }

    public int getMatchId() {
        return matchId;
    }

    public Team getHome() {
        return home;
    }

    public Stats getHomeStats() {
        return homeStats;
    }

    public void setHomeStats(Stats homeStats) {
        this.homeStats = homeStats;
    }

    public Team getAway() {
        return away;
    }

    public Stats getAwayStats() {
        return awayStats;
    }

    public void setAwayStats(Stats awayStats) {
        this.awayStats = awayStats;
    }

    public String getRefereeName() {
        return refereeName;
    }

    public void setRefereeName(String refereeName) {
        this.refereeName = refereeName;
    }

    public LocalTime getMatchDate() {
        return matchDate;
    }

    public void setMatchDate(LocalTime matchDate) {
        this.matchDate = matchDate;
    }
    
}