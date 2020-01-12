package league;

public class Team {
	private int id;
	private String name, logo;
	private League leagueId;

	public Team(int id, League leagueId, String name, String logoPath) {
		this.id = id;
		this.leagueId = leagueId;
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
		return this.id;
	}

	public League getLeagueId() {
		return this.leagueId;
	}

	public boolean equals(Team other) {
		return other.getId() == this.getId();
	}
}