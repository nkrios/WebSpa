package net.seleucus.wsp.db;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


import org.apache.commons.io.FileUtils;

public class WSDatabase {

	private static final String DB_PATH = "web-spa-db";

	private Connection wsConnection;

	public WSActionsAvailable actionsAvailable;
	public WSActionsReceived actionsReceived;
	public WSPassPhrases passPhrases;
	public WSUsers users;

	public WSDatabase() throws ClassNotFoundException, SQLException,
			IOException {

		// Check if the database properties file is present, if not create it
		// from the bundled template...
		File propsFile = new File(DB_PATH + ".properties");
		if (!propsFile.exists()) {
			URL bundledPropsLocation = ClassLoader
					.getSystemResource("data/bundled-web-spa-db.properties");
			FileUtils.copyURLToFile(bundledPropsLocation, propsFile);
		}

		// Check if the database script file is present, if not create it from
		// the bundled template...
		File scriptFile = new File(DB_PATH + ".script");
		if (!scriptFile.exists()) {
			URL bundledScriptlocation = ClassLoader
					.getSystemResource("data/bundled-web-spa-db.script");
			FileUtils.copyURLToFile(bundledScriptlocation, scriptFile);
		}

		Class.forName("org.hsqldb.jdbcDriver");
		wsConnection = DriverManager.getConnection("jdbc:hsqldb:" + DB_PATH);
		
		actionsAvailable = new WSActionsAvailable(wsConnection);
		actionsReceived = new WSActionsReceived(wsConnection);
		passPhrases = new WSPassPhrases(wsConnection);
		users = new WSUsers(wsConnection);

	}

	public synchronized void shutdown() {

		Statement st;
		
		try {

			st = wsConnection.createStatement();
			// Normal shutdown operations...
			st.execute("SHUTDOWN");
			wsConnection.close();
			
		} catch (SQLException ex) {
			
			 throw new RuntimeException(ex);

		}

	}

	protected synchronized void deleteAllDatabaseFiles() {

		this.shutdown();

		final String[] extensions = { ".properties", ".script", ".log", 
									  ".data", ".backup" };
		
		for (String extension : extensions) {
			
			File dbFile = new File(DB_PATH + extension);
			
			if (dbFile.exists()) {
			
				dbFile.delete();
				
			}
			
		}	// for loop

	}


}
