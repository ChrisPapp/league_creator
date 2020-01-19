package league;

public class LeagueStats {

    public League league;
    public Integer userCount;
    public Integer teamCount;

    public LeagueStats(League league, Integer userCount, Integer teamCount) {
        this.league = league;
        this.userCount = userCount;
        this.teamCount = teamCount;
    }
    
}