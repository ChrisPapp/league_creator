package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.Locale;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;

public class Post {

    private Integer id;
    private String title;
    private String content;
    private User poster;
    private LocalDateTime time;

    public Post(Integer id, String title, String content, User poster, LocalDateTime time) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.poster = poster;
        this.time = time;
    }

    public static Post getById(int postId, int leagueId) {
        Post post = null;
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT * FROM post JOIN " + DatabaseAccess.getDatabaseName() + ".user u ON post.poster_id = u.iduser WHERE idpost = ? AND u.league_id = ?";
			stmt = con.prepareStatement(query);
            stmt.setInt(1, postId);
            stmt.setInt(2, leagueId);
			rs = stmt.executeQuery();
			while (rs.next()) {
                java.sql.Timestamp ts = rs.getObject("date", java.sql.Timestamp.class);
                LocalDateTime dateTime = ts.toLocalDateTime();
                User user = new User(rs.getInt("iduser"), rs.getString("name"), rs.getString("surname"),
                rs.getString("mail"), rs.getString("username"), rs.getString("phone"),
                rs.getString("profile_pic"), rs.getBoolean("canReferee"), rs.getBoolean("canPost"),
                rs.getBoolean("is_admin"), rs.getInt("league_id"));
				post = new Post(rs.getInt("idpost"), rs.getString("title"), rs.getString("content"), user, dateTime);
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
		return post;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getPoster() {
        return poster;
    }

    public void setPoster(User poster) {
        this.poster = poster;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }
    
    public String getDateString() {
        return "" + time.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.getDefault()) + " " + time.format(DateTimeFormatter.ofPattern("d MMM YYYY HH:mm").withLocale(Locale.getDefault()));
    }
}