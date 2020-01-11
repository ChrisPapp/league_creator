
// *
 //* @author ������� ������ 8170117
 //*
 //*/

package league;

import database.DatabaseAccess;

public class User {

	private int id;
	private String name;
	private String surname;
	private String email;
	private String username;
	private String password;
	private String phone;
	private boolean canReferee;
	private int leagueid;


	public User(String name, String surname, String email, String username, String password, String phone, boolean canReferee, int leagueid) {
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.username = username;
		this.password = password;
		this.phone = phone;
		this.canReferee = canReferee;
		this.leagueid = leagueid;
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
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
			return phone;
		}


		public void setPhone(String phone) {
			this.phone = phone;
	}

	public boolean canReferee()
	{
		return this.canReferee;
	}

	public int getId(){
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

} //End of class
