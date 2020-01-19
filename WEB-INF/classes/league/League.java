package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.List;
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
	public ArrayList<Post> getPosts(int userId, int limit) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		User user = null;
        ArrayList<Post> postList = new ArrayList<Post>();
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT * FROM post JOIN " + DatabaseAccess.getDatabaseName() + ".user u ON post.poster_id = u.iduser LEFT JOIN team ON u.team_id = team.idteam WHERE u.league_id = ? ";
			if (userId > 0) {
				query+= "AND u.iduser = ? ";
			}
			query += " ORDER BY date DESC ";
			if (limit > 0) {
				query += "LIMIT ? ";
			}
			stmt = con.prepareStatement(query);
			stmt.setInt(1, this.getId());
			if (userId > 0 && limit > 0) {
				stmt.setInt(2, userId);
				stmt.setInt(3, limit);
			} else if (userId > 0) {
				stmt.setInt(2, userId);
			} else if (limit > 0) {
				stmt.setInt(2, limit);
			}
			rs = stmt.executeQuery();
			while (rs.next()) {
				user = User.constructUser(rs);
				java.sql.Timestamp ts = rs.getObject("date", java.sql.Timestamp.class);
                LocalDateTime dateTime = ts.toLocalDateTime();
				Post post = new Post(rs.getInt("idpost"), rs.getString("title"), rs.getString("content"), user, dateTime);
				postList.add(post);
			}
		} catch (SQLException e) {
			/*Post post = new Post(1, e.getMessage(), e.getStackTrace().toString(), user, LocalDateTime.now());
			postList.add(post); // Debug hacks */
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

	// Do a transaction. Ensures that if any of the queries fail, then the others are roled back

	public static void createLeagueAndAdmin(League league, User user, String pass) throws SQLException {

		Connection con = null;
		PreparedStatement addLeague = null;
		PreparedStatement addAdmin = null;
		ResultSet rs = null;

		String leagueQuery = "INSERT INTO league ( name, logo_path ) VALUES (?, ?);";

		String adminQuery = "INSERT INTO user ( name, surname, pswd, mail, phone, league_id, username, canPost, canReferee, is_admin )  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

		try {
			con = DatabaseAccess.getConnection();
			con.setAutoCommit(false);
			addLeague = con.prepareStatement(leagueQuery, PreparedStatement.RETURN_GENERATED_KEYS);
			addAdmin = con.prepareStatement(adminQuery, PreparedStatement.RETURN_GENERATED_KEYS);


			addLeague.setString(1, league.getName());
			addLeague.setString(2, league.getLogo());
			addLeague.executeUpdate();

			rs = addLeague.getGeneratedKeys();
			rs.next();
			user.setLeagueid(rs.getInt(1));
			league.setId(rs.getInt(1));

			addAdmin.setString(1, user.getName());
			addAdmin.setString(2, user.getSurname());
			addAdmin.setString(3, pass);
			addAdmin.setString(4, user.getEmail());
			addAdmin.setString(5, user.getPhone());
			addAdmin.setInt(6, user.getLeagueid());
			addAdmin.setString(7, user.getUsername());
			addAdmin.setBoolean(8, user.canPost());
			addAdmin.setBoolean(9, user.canReferee());
			addAdmin.setBoolean(10, user.isAdmin());
			addAdmin.executeUpdate();
			rs = addAdmin.getGeneratedKeys();
			rs.next();
			user.setId(rs.getInt(1));
			con.commit();
		} catch (SQLException e ) {
			if (con != null) {
				try {
					con.rollback();
					throw e;
				} catch(SQLException excep) {
					throw excep;
				}
			}
		} finally {
			if (addLeague != null) {
				addAdmin.close();
			}
			if (addLeague != null) {
				addLeague.close();
			}
			con.setAutoCommit(true);
		}
	}

	public int getId() {
		return league_id;
	}

	public void setId(int league_id) {
		this.league_id = league_id;
	}

	public static List<LeagueStats> getAllLeagueStats() throws SQLException {
        List<LeagueStats> list = new ArrayList<LeagueStats>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = DatabaseAccess.getConnection();
            final String query = 
            "SELECT l.*, count(iduser) as userCount, teams.teamCount FROM league l " + 
			"LEFT JOIN user u ON u.league_id = l.idleague " +
			"JOIN ( SELECT l.*, count(idteam) as teamCount FROM league l " +
			"LEFT JOIN team t ON t.league_id = l.idleague " +
			"GROUP BY idleague ) AS teams USING (idleague) " +
			"GROUP BY l.idleague ORDER BY userCount DESC";
            stmt = con.prepareStatement(query);
            rs = stmt.executeQuery();
            while (rs.next()) {
				League league = new League(rs.getInt(1), rs.getString(2), rs.getString(3));
				LeagueStats stats = new LeagueStats(league, rs.getInt(4), rs.getInt(5));
                list.add(stats);
            }
        } catch (final SQLException e) {
            throw e;
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
		return list;
	}

}