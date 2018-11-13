package br.com.interop.main;

import br.com.interop.db.DBConnect;
import br.com.interop.db.DBConnectionInfo;

public class Main {

	public static void main(String[] args) {
		System.out.println(Versao.ver()+"\n");
		if (args.length != 1) {
			System.out.println("Not enough parameters...");
			System.out.println("java -cp [JDBC driver path] -jar tnsping4j.jar [connect string]");
			System.exit(1);
		}
		        
		// Salva em memoria as informacoes de conexao com o banco
		// de dados para posterior uso pela classe de conexão com o banco.
		DBConnectionInfo.setDbStrConnect(args[0]);
		
		DBConnect connTest = new DBConnect();
		
		connTest.connectDBThin();
		
		System.exit(0);
	}

}
