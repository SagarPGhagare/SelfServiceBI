package com.mastek.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public interface SelfServiceDAO {
	
	public Connection createConnection() throws Exception;
	
	public Statement createStatement(Connection con) throws SQLException;
	
	public Statement createPrepareStatement(Connection con, String sqlQuery) throws SQLException;
	
	public ResultSet executeQuery(Statement stmt,String sqlQuery) throws SQLException;
	
	public ResultSetMetaData executeResultSetMetaData(ResultSet rs) throws SQLException;
	
	public void closeConnection (Connection con) throws SQLException;
	
}
