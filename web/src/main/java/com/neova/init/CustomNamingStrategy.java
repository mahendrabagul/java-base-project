package com.neova.init;

import org.hibernate.cfg.ImprovedNamingStrategy;

public class CustomNamingStrategy extends ImprovedNamingStrategy {

	private static final long serialVersionUID = -8134212721121979033L;
	private String tenantName;

	@Override
	public String classToTableName(String className) {
		String tableName = super.classToTableName(className);
		return transformToTenantSpecific(tableName);
	}

	public void setTenantName(String tenantName) {

		this.tenantName = tenantName;
	}

	@Override
	public String columnName(String columnName) {
		System.out.println("+++++++++++++++++++++++++");
		System.out.println("ColumnName=" + columnName);
		System.out.println("+++++++++++++++++++++++++");
		return columnName;
	}

	private String transformToTenantSpecific(String tableName) {
		StringBuilder tenantSpecific = new StringBuilder();
		tenantSpecific.append(new String(tenantName));
		tenantSpecific.append("_" + new String(tableName));
		return tenantSpecific.toString();
	}
}