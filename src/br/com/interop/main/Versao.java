package br.com.interop.main;

/**
 * Classe para retornar a versao do programa
 * 
 * @author Anderson Bestteti Santos
 *
 */
public final class Versao {
    
	private static String descricao = "JDBC Ping utility: ";
	private static String programa  = "TNSPING4J";
	private static String versao    = "1.0.13.11.2018";
	
	
	public static String getStringVersao() {
		return programa + " Version " + versao;
	}
	
	public static String ver() {
		return descricao+getStringVersao();
	}

}