package br.com.interop.enumeration;

/**
 * This enumeration represents the JDBC drivers
 * used by application.
 * <p>
 * Change log:
 * <p>
 * 2018.11.14 - ABS - Added JavaDOc.
 * 
 * @author Anderson Bestteti Santos
 *
 */
public enum DBConnectionTypeEnum {
	
	/**
	 * Enumeration for THIN driver connection type.
	 */
	THIN("thin", "JDBC Thin driver"),	
	/**
	 * Enumeration for OCI (Oracle Call Interface) driver
	 * connection type.
	 */
	OCI("oci", "JDBC OCI driver");
	
	private String id;
	private String description;

    /**
     * Enum's default constructor.
     * @param id of enumeration.
     * @param description of enumeration.
     */
	DBConnectionTypeEnum(final String id, final String description) {
        setId(id);
        setDescription(description);
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
     * Retrieve the enumeration based on its id.
     *
     * @param id An Id value.
     * @return The enumeration found. 
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
