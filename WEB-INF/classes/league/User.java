
// *
//* @author ������� ������ 8170117
//*
//*/

package league;

import java.sql.*;
import database.DatabaseAccess;

public class User {

	private int id;
	private String name;
	private String surname;
	private String email;
	private String username;
	private String phone;
	private String profilePic; // Link to profile picture (assumes that it is valid)
	private boolean canReferee;
	private boolean canPost;
	private boolean isAdmin;
	private int leagueid;

	public User(int id, String name, String surname, String email, String username, String phone,
			String profilePic, boolean canReferee, boolean canPost, boolean isAdmin, int leagueid) {
		this.id = id;
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.username = username;
		this.phone = phone;
		this.canPost = canPost;
		this.isAdmin = isAdmin;
		this.canPost = canPost;
		this.canReferee = canReferee;
		this.leagueid = leagueid;
	}

	public static User getById(int id) {
		User user = null;
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = DatabaseAccess.getConnection();
			String query = "SELECT * FROM " + DatabaseAccess.getDatabaseName() + ".user WHERE iduser=?;";
			stmt = con.prepareStatement(query);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			while (rs.next()) {
				user = new User(rs.getInt("iduser"), rs.getString("name"), rs.getString("surname"),
						rs.getString("mail"), rs.getString("username"), rs.getString("phone"),
						rs.getString("profile_pic"), rs.getBoolean("canReferee"), rs.getBoolean("canPost"),
						rs.getBoolean("is_admin"), rs.getInt("league_id"));
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
			return user;
		}
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the surname
	 */
	public String getSurname() {
		return surname;
	}

	/**
	 * @param surname the surname to set
	 */
	public void setSurname(String surname) {
		this.surname = surname;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public boolean canReferee() {
		return this.canReferee;
	}

	public int getId() {
		return this.id;
	}

	public int getLeagueid() {
		return leagueid;
	}

	public void setLeagueid(int leagueid) {
		this.leagueid = leagueid;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", name=" + name + ", surname=" + surname + ", email=" + email + "]";
	}

	public String getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}

	public boolean isCanPost() {
		return canPost;
	}

	public void setCanPost(boolean canPost) {
		this.canPost = canPost;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

} // End of class
