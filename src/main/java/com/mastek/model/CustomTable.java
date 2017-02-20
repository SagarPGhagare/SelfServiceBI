package com.mastek.model;

import java.util.List;

public class CustomTable {
	
	public String name;
	public List<CustomColumn> columns;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<CustomColumn> getColumns() {
		return columns;
	}
	public void setColumns(List<CustomColumn> columns) {
		this.columns = columns;
	} 
	
}
