package com.mastek.model;

import java.util.List;

public class TableDetails {

	private String schemaName;
	private String tableName;
	private List<SqlQueryColumnDetails> colDetail;
	
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
	
	
}
