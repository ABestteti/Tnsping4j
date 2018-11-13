package br.com.interop.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

	private long startTime;
	private long endTime;
	
	public void connectDB() {
		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");

		} catch (ClassNotFoundException e) {

			System.out.println("Oracle JDBC Driver issue.....");
			e.printStackTrace();
			return;
		}

		try {
			Connection connection = null;

			System.out.println("Trying to connect to\n" + DBConnectionInfo.getDbStrConnect());
						
			startTime = System.currentTimeMillis();
			
			DriverManager.setLoginTimeout(4);
			connection = DriverManager.getConnection( DBConnectionInfo.THINCONNECTION + DBConnectionInfo.getDbStrConnect()
			                                         ,DBConnectionInfo.getDbUserName() 
			                                         ,DBConnectionInfo.getDbPassWord()
			                                        );
									
		} catch (SQLException e) {

			if (e.getErrorCode() != DBConnectionInfo.INVALID_USERNAME_PASSWORD) {
				System.out.println("Failed to connect to Oracle database.");
				e.printStackTrace();
				return;
			}
			
		} finally {
			endTime = System.currentTimeMillis();
		}

		System.out.println("OK (" + (endTime - startTime) + " msec)");
	}
}
