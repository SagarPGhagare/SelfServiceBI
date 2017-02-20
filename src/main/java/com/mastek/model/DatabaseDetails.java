package com.mastek.model;

import java.util.List;

public class DatabaseDetails {
	
	private String schemaName;
	private String tableName;
	private List<SqlQueryColumnDetails> colDetail;
	//private List<CustomTable> tableName;
	
	public String getSchemaName() {
		return schemaName;
	}
	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public List<SqlQueryColumnDetails> getColDetail() {
		return colDetail;
	}
	public void setColDetail(List<SqlQueryColumnDetails> colDetail) {
		this.colDetail = colDetail;
	}
	/*public List<CustomTable> getTableName() {
		return tableName;
	}
	public void setTableName(List<CustomTable> tableName) {
		this.tableName = tableName;
	}*/

}
