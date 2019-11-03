package league;

public class Team {
	private int id, league;
	private String name, logo;

	public Team(int id, int leagueId, String name, String logoPath) {
		this.id = id;
		this.league = leagueId;
		this.name = name;
		this.logo = logoPath;
	}

	public String getName() {
		return this.name;
	}

	public String getLogo() {
		return this.logo;
	}

	public int getId() {
		return this.league;
	}
}