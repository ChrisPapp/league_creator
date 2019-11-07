package database;

import league.Team;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseAccess {
	public final static int delayPeriod = 500;
    public final static String driverClassName = "com.mysql.jdbc.Driver";
    public final static String mySqlUrl = "jdbc:mysql://195.251.249.131:3306/";
    private static final String dbName = "ismgroup62";
    private static final String username = "ismgroup62";
    private static final String password = "9xe6kf";

    public static Connection getConnection(String db, String username, String password) {
		String databaseUrl = mySqlUrl + db;
        Connection con = null;
		try {
			Class.forName(driverClassName);
			con = DriverManager.getConnection(databaseUrl, username, password);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return con;
    }

    public static Connection getConnection() throws SQLException {
            return getConnection(dbName, username, password);
    }

}