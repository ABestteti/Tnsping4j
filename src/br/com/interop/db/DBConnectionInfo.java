package br.com.interop.db;

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

	// A string de conexao deve ser no seguinte
	// format: localhost:1521:xe
	private static String dbStrConnect;
	
	private DBConnectionInfo() {
		dbUserName   = "system";
		dbPassWord   = "dummypassword";
		dbStrConnect = null;
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
	
	
}