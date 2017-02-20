package com.mastek.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.mastek.model.DatabaseDetails;
import com.mastek.model.ResultSetMetadataDetails;
import com.mastek.model.SqlQueryDetails;
import com.mastek.model.TableDetails;

public interface SelfService {
	
	public String getSchemaName();
	
	public String getQueryForTables();
	
	public String getQueryForCol();
	
	public List<DatabaseDetails> getSchemaObjectDetails(Statement stmt) throws SQLException;
	
	public List<DatabaseDetails> getSchemaObjectDetails(PreparedStatement stmt) throws SQLException;
	
	public Connection createConnection() throws Exception;
	
	public Statement createStatement(Connection con) throws SQLException;
	
	public Statement createPrepareStatement(Connection con, String sqlQuery) throws SQLException;
	
	public void closeConnection (Connection con) throws SQLException;
	
	public List<TableDetails> executeQuery(Statement stmt, List<SqlQueryDetails> sqlQueryDetail) throws Exception;
	
	public List<TableDetails> executeQuery(PreparedStatement stmt, List<SqlQueryDetails> sqlQueryDetail) throws Exception;
	
	public ResultSetMetadataDetails executeResultSetMetaData(ResultSet rs) throws SQLException;
}
