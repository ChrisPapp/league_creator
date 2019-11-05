package database;
import league.Team;

public class DatabaseAccess {
	// In the future we will access the database with username and password
	String username, password;

	// In the future it will access the database and get the teams.
	// Now it returns some random teams
	public Team[] getLeagueTeams(int leagueId) {
		Team[] teams = new Team[6];
		teams[0] = new Team(1, 1, "Olympiacos", "https://seeklogo.com/images/O/Olympiacos_FC-logo-8F8F1A05DD-seeklogo.com.png");
		teams[1] = new Team(1, 1, "Panathinaikos", "https://upload.wikimedia.org/wikipedia/el/thumb/5/56/Panathinaikos_FC_logo.svg/300px-Panathinaikos_FC_logo.svg.png");
		teams[2] = new Team(1, 1, "Aek", "https://upload.wikimedia.org/wikipedia/en/thumb/0/04/AEK_Athens_FC_logo.svg/1200px-AEK_Athens_FC_logo.svg.png");
		teams[3] = new Team(1, 1, "Paok", "https://upload.wikimedia.org/wikipedia/en/thumb/9/92/PAOK_FC_logo.svg/1200px-PAOK_FC_logo.svg.png");
		teams[4] = new Team(1, 1, "Aris", "https://upload.wikimedia.org/wikipedia/en/thumb/e/e4/Aris_Thessaloniki_F.C._logo.svg/1200px-Aris_Thessaloniki_F.C._logo.svg.png");
		teams[5] = new Team(1, 1, "Atromitos", "https://seeklogo.com/images/A/atromitos-athens-logo-24668C3087-seeklogo.com.jpg");
		return teams;
	}
}