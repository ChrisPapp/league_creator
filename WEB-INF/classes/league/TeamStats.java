package league;

public class TeamStats implements Comparable{
    private static final int POINTS_PER_WIN = 3;
    private static final int POINTS_PER_DRAW = 1;
    private static final int POINTS_PER_DEFEAT = 0;
    public Team team;
    public Integer goalsScored;
    public Integer goalsAgainst;
    public Integer wins;
    public Integer draws;
    public Integer defeats;

    public TeamStats(Team team, Integer goalsScored, Integer goalsAgainst, Integer wins, Integer draws, Integer defeats) {
        this.team = team;
        this.goalsScored = goalsScored;
        this.goalsAgainst = goalsAgainst;
        this.wins = wins;
        this.draws = draws;
        this.defeats = defeats;
    }

    // Sort first by points, then by matches played, and then by goalsScored
    public int compareTo(Object otherObj) throws ClassCastException, NullPointerException{
        if (otherObj == null) {
            throw new NullPointerException("'other' passed to TeamStats compareTo was null");
        }
        if (!(otherObj instanceof TeamStats)) {
            throw new ClassCastException("Wrong Type");
        }
        TeamStats other = (TeamStats) otherObj;
        if (this.getPoints() != other.getPoints()) {
            return this.getPoints() - other.getPoints();
        }
        if (this.getTotalMatches() != other.getTotalMatches()) {
            return other.getTotalMatches() - this.getTotalMatches(); // If the have the same points, then one with less matches is better
        }
        if (this.goalsScored != other.goalsScored) {
            return this.goalsScored - other.goalsScored;
        }
        return this.team.getId() - other.team.getId(); // To avoid conflicts, just compare based on Team Id.
    }
    
    public int getPoints(){
        return (this.wins * POINTS_PER_WIN + this.draws *POINTS_PER_DRAW + this.defeats * POINTS_PER_DEFEAT);
    }

    public int getTotalMatches(){
        return this.wins + this.draws + this.defeats;
    }
}