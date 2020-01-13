package league;

public class Team {
	private int id;
	private String name, logo;
	private int leagueId;
	private int leaderId;

	public Team(int id, int leagueId, String name, String logoPath) {
		this.id = id;
		this.leagueId = leagueId;
		this.name = name;
		this.logo = logoPath;
		this.leaderId = -1;
	}

	public Team(int id, int leagueId, String name, String logoPath, int leaderId) {
		this.id = id;
		this.leagueId = leagueId;
		this.name = name;
		this.logo = logoPath;
		this.leaderId = leaderId;
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

	public int getLeagueId() {
		return this.leagueId;
	}

	public int getLeaderId() {
		return this.leaderId;
	}

	public boolean equals(Team other) {
		return other.getId() == this.getId();
	}
}