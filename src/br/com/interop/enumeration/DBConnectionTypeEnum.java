package br.com.interop.enumeration;

/**
 * Enumeracao para representar os tipos de drivers
 * JDBC que s�o suportados pela aplica��o.
 * <p>
 * Altera��es:
 * <p>
 * 2018.11.14 - ABS - Adiconado JavaDOc.
 * 
 * @author Anderson Bestteti Santos
 *
 */
public enum DBConnectionTypeEnum {
	
	/**
	 * Enumera��o para indicar o tipo
	 * de conex�o Thin.
	 */
	THIN("thin", "JDBC Thin driver"),	
	/**
	 * Enumera��o para indicar o tipo
	 * de conex�o OCI (Oracle Call Interface)
	 */
	OCI("oci", "JDBC OCI driver");
	
	private String id;
	private String description;

    /**
     * Construtor padr�o para a Enum.
     * @param id com o c�digo.
     * @param descricao com descritivo da Enum.
     */
	DBConnectionTypeEnum(final String id, final String descricao) {
        setId(id);
        setDescription(descricao);
    }
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
     * Recupera a enumeracao com base no identificador.
     *
     * @param id
     *            Valor para o identificador.
     * @return A enumeracao alcancada.
     */
    public static DBConnectionTypeEnum getById(final String id) {
    	DBConnectionTypeEnum result = null;
        for (final DBConnectionTypeEnum someEnum : values()) {
            if (someEnum.getId().equals(id)) {
                result = someEnum;
            }
        }
        return result;
    }	
}
