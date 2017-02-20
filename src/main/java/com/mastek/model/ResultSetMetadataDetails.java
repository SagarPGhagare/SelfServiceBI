package com.mastek.model;

import java.util.Map;

public class ResultSetMetadataDetails {
	
	private int noOfCols;
	private String ColNames[];
	private Map<String, String> tabColDetails;
	
	public Map<String, String> getTabColDetails() {
		return tabColDetails;
	}
	public void setTabColDetails(Map<String, String> tabColDetails) {
		this.tabColDetails = tabColDetails;
	}
	public int getNoOfCols() {
		return noOfCols;
	}
	public void setNoOfCols(int noOfCols) {
		this.noOfCols = noOfCols;
	}
	public String[] getColNames() {
		return ColNames;
	}
	public void setColNames(String[] colNames) {
		ColNames = colNames;
	}

}
