package league;

public class Result {
	public Integer matchId;
	public Integer goalsHome;
    public Integer goalsAway;

    public Result(Integer matchId, Integer goalsHome, Integer goalsAway) {
        this.matchId = matchId;
        this.goalsHome = goalsHome;
        this.goalsAway = goalsAway;
    }
    
}