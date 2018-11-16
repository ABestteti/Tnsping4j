package br.com.interop.main;

import java.io.File;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import br.com.interop.db.DBConnect;
import br.com.interop.db.DBConnectionInfo;
import br.com.interop.enumeration.DBConnectionTypeEnum;

public class Main {
	
	public static void main(String[] args) {
				
		CommandLine cmd = validateCliOption(args);
		
		// Salva em memoria as informacoes de conexao com o banco
		// de dados para posterior uso pela classe de conexão com o banco.
		DBConnectionInfo.setDbStrConnect(cmd.getOptionValue("conn"));
		
		if (cmd.hasOption("oci")) {
			// Caso tenha sido passado na linha de comando o parâmetro
			// "-oci", então o teste de conexão será feito usando a instalação
			// do cliente Oracle com SQL*Net configurado.
			DBConnectionInfo.setDbConnType(DBConnectionTypeEnum.OCI);
		} else {
			// Caso não tenha sido passado na linha de comando o parâmetro
			// "-oci", então o teste de conexão com o banco será feito usando
			// o driver THIN do JDBC.
			DBConnectionInfo.setDbConnType(DBConnectionTypeEnum.THIN);
		}
		
		DBConnect connTest = new DBConnect();
		
		connTest.connectDB();
		
		System.exit(0);
	}

	private static void usage(Options options) {
		HelpFormatter formatter = new HelpFormatter();
		formatter.printHelp( "tnsping4j", options );
		System.out.println("\nTo run tnsping4j, issue the following command:");
		System.out.println("java -classpath lib/commons-cli-1.4.jar" +
		                   File.pathSeparator  + 
		                   "lib/tnsping4j.jar" +
		                   File.pathSeparator  +
		                   "Oracle_JDBC_driver_path " +
		                   "br.com.interop.main.Main " +
		                   "-conn net_service_name|net_service_string [-oci]");
		System.out.println("\nWhere:");
		System.out.println("* Oracle_JDBC_driver_path: is the Oracle JDBC driver file to be used by tnsping4j.");
		System.out.println("* net_service_name.......: must exist in tnsnames.ora file in case of '-oci' option is used.");
		System.out.println("* net_service_string.....: a valid connect string to be used by Oracle JDBC driver.");		
	}
	
	private static CommandLine validateCliOption(String[] args) {
		System.out.println(Version.ver()+"\n");

		// create Options object
		Options options = new Options();

		// add command line options to be parsed.
		options.addOption("conn",  true, "connect string that must be used to connect to remote database." );
		options.addOption("help", false, "print this help.");
		options.addOption("oci" , false, "tells tnsping4j to use OCI driver to connect to remote database. When not specified THIN driver will be used.");

		if (args.length < 1) {			
			System.out.println("Not enough parameters...");
			usage(options);			
			System.exit(1);
		}
		
		CommandLineParser parser = new DefaultParser();
		CommandLine       cmd    = null;
				
		try {
			cmd = parser.parse(options, args);
		}
		catch (ParseException e) {			
			usage(options);
			throw new RuntimeException(e.getMessage());
		}

		if (cmd.hasOption("help")) {
			usage(options);
			System.exit(0);			
		}
		
		return cmd;
	}
	
}
