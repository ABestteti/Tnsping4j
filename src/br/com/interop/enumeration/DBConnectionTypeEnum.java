package br.com.interop.enumeration;

public enum DBConnectionTypeEnum {
	
	/**
	 * Enumeração para indicar o tipo
	 * de conexão Thin.
	 */
	THIN("thin", "JDBC Thin driver"),	
	/**
	 * Enumeração para indicar o tipo
	 * de conexão OCI (Oracle Call Interface)
	 */
	OCI("oci", "JDBC OCI driver");
	
	private String id;
	private String description;

    /**
     * Construtor padrão para a Enum.
     * @param id com o código.
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
	
}
