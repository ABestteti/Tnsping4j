package br.com.interop.db;

import java.sql.PreparedStatement;

import br.com.interop.enumeration.DBConnectionTypeEnum;

/**
 * Classe reponsavel armazenar as informacoes de conexao com o banco Oracle.
 * <p>
 * <b>Empresa:</b> Acao Sistemas de Informatica Ltda.
 * <p>
 * Alterações:
 * <p>
 * 2018.03.15 - ABS - Adicionado JavaDoc na classe.
 * 
 * @author Anderson Bestteti
 */
public final class DBConnectionInfo {

	/**
	 * Define os tipos possíveis métodos de conexão JDBC com
	 * o banco de dados Oracle.
	 */
	public static final String THINCONNECTION = "jdbc:oracle:thin:@";
	public static final String OCICONNECTION  = "jdbc:oracle:oci:@";

	/**
	 * Define códigos de erro Oracle que devem ser descartados numa
	 * eventual exceção durante o teste de conexão com o banco de 
	 * dados.
	 */
	public static final int INVALID_USERNAME_PASSWORD = 1017;
	
	/**
	 * Define a quantidade maxima de registros a serem recuperados
	 * numa operacao de fetch. Esse constante pode ser usada em objetos
	 * do tipo {@link PreparedStatement} para evitar estouro de memoria 
	 * da JVM quando existe a possibilidade de recuperar do banco milhoes
	 * de linhas em uma unica operacao de fetch.
	 */
	public static int MAX_FETCH_SIZE = 100;
	
	/**
	 * Define a quantidade maxima de comandos SQL que serao armazenados
	 * em cache para melhorar a performance de execucao de consultas que
	 * sao executadas repetidamente pela aplicacao.
	 */
	public static int MAX_STATEMENT_CACHE = 10;
	
	// Nome do usuario do banco de dados
	private static String dbUserName;

	// Senha do usuario do banco de dados
	private static String dbPassWord;

	// Sintaxe da string de conexão deve seguir
	// o padrão do Oracle: localhost:1521:xe ou
	// (DESCRIPTION=(ENABLE=BROKEN)
	//   (ADDRESS=(PROTOCOL=tcp)(PORT=port_no)(HOST=host_name))
	//   (CONNECT_DATA=(SERVICE=service_name)))
	private static String dbStrConnect;
	
	// Identifica o método de conexão com o banco de dados
	// Oracle: THIN driver, ou OCI.
	private static DBConnectionTypeEnum dbConnType;
	
	private DBConnectionInfo() {
		dbUserName   = "system";
		dbPassWord   = "dummypassword";
		dbStrConnect = null;
		dbConnType   = DBConnectionTypeEnum.THIN;
	}

	public static String getDbUserName() {
		return dbUserName;
	}

	public static String getDbPassWord() {
		return dbPassWord;
	}

	public static String getDbStrConnect() {
		return dbStrConnect;
	}

	public static void setDbStrConnect(String dbStrConnect) {
		DBConnectionInfo.dbStrConnect = dbStrConnect;
	}

	public static DBConnectionTypeEnum getDbConnType() {
		return dbConnType;
	}

	public static void setDbConnType(DBConnectionTypeEnum dbConnType) {
		DBConnectionInfo.dbConnType = dbConnType;
	}
}