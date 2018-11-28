package br.com.interop.main;

/**
 * This class stores the application's version.
 * 
 * @author Anderson Bestteti Santos
 *
 */
public final class Version {  
	private static String description = "JDBC ping utility: ";
	private static String program     = "TNSPING4J";
	private static String version     = "1.0.28.11.2018";
	
	
	public static String getStringVersao() {
		return program + " Version " + version;
	}
	
	public static String ver() {
		return description + getStringVersao();
	}
}