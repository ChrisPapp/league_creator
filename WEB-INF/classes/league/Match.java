package league;

import database.DatabaseAccess;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;

public class Match {

    private final int matchId;
    private final Team home;
    private final Team away;
    private User refereeUser;
    private Date matchDate;

    public Match(int id, Team home, Team away, User ref, java.util.Date date) {
        this.matchId = id;
        this.home = home;
        this.away = away;
        this.refereeUser = ref;
        this.matchDate = date;
    }
}