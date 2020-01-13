package league;

public class Result {
	public Integer matchId;
	public Integer goalsHome;
    public Integer goalsAway;
    public String homeName;
    public String awayName;

    public Result(Integer matchId, Integer goalsHome, Integer goalsAway) {
        this.matchId = matchId;
        this.goalsHome = goalsHome;
        this.goalsAway = goalsAway;
    }
    
    public Result(Integer matchId, Integer goalsHome, Integer goalsAway, String homeName, String awayName) {
        this.matchId = matchId;
        this.goalsHome = goalsHome;
        this.goalsAway = goalsAway;
        this.homeName = homeName;
        this.awayName = awayName;
    }

    public String getMatchName() {
        return homeName + " - " + awayName;
    }

    public String getScore() {
        String score;
        if (goalsHome != null && goalsAway != null) {
            score = goalsHome + " - " + goalsAway;  
        } else {
            score = "Scheduled";
        }
        return score;
    }
}