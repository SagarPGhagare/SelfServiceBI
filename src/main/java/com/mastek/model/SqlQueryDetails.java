package com.mastek.model;

import java.util.Map;

public class SqlQueryDetails {
	
	private String tableName;
	private Map<String, String> tabColDetails;
	
	
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public Map<String, String> getTabColDetails() {
		return tabColDetails;
	}
	public void setTabColDetails(Map<String, String> tabColDetails) {
		this.tabColDetails = tabColDetails;
	}
	
}
