package com.mastek.service.impl;

import java.lang.annotation.Annotation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.healthmarketscience.sqlbuilder.SelectQuery;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbColumn;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbSchema;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbSpec;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbTable;
import com.mastek.dao.SelfServiceDAO;
import com.mastek.dao.impl.SelfServiceDAOImpl;
import com.mastek.model.DatabaseDetails;
import com.mastek.model.ResultSetMetadataDetails;
import com.mastek.model.SqlQueryColumnDetails;
import com.mastek.model.SqlQueryDetails;
import com.mastek.model.TableDetails;
import com.mastek.service.SelfService;

@Component
@PropertySource("classpath:config.properties")
public class SelfServiceImpl implements SelfService {
	
	@Autowired
	public SelfServiceDAO dao;
	
	private static final Logger slf4jLogger = LoggerFactory.getLogger(SelfServiceImpl.class);
	//private final Logger slf4jLogger = LoggerFactory.getLogger(Service.class);
	
	@Value("${schemaName}")
	private String schemaName;
	
	@Value("${sqlForTables}")
	private String queryForTables;
	
	@Value("${sqlForCols}")
	private String queryForCol;
	
	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
	}

	public String getQueryForTables() {
		return queryForTables;
	}

	public void setQueryForTables(String queryForTables) {
		this.queryForTables = queryForTables;
	}

	public String getQueryForCol() {
		return queryForCol;
	}

	public void setQueryForCol(String queryForCol) {
		this.queryForCol = queryForCol;
	}

	public List<DatabaseDetails> getSchemaObjectDetails(Statement stmt) throws SQLException{
		//System.out.println(schemaName);
		slf4jLogger.trace("schemaName "+schemaName);
		//DAO drillDao = ContextFactory.getDrillConnection();
		//String sqlForTables = "SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE FROM INFORMATION_SCHEMA.`TABLES` where LOWER(TABLE_SCHEMA) = 'dfs.tmp' ORDER BY TABLE_NAME DESC;";
		//System.out.println(queryForTables);
		
		//Fetching Database tables Details from Drill view
		ResultSet databaseDetails = dao.executeQuery(stmt, queryForTables);
		//System.out.println(tableDetailsFromDrillView);

		//Get tables from database
		List<String> tables = getTables(databaseDetails);
				
		return getColumnDetails(tables,dao,stmt);
	}
	
	private List<DatabaseDetails> getColumnDetails(List<String> tables, SelfServiceDAO drillDao, Statement stmt) throws SQLException {
		String sqlForTabCols;
		List<DatabaseDetails> tableDetailsFromDrill = new ArrayList<DatabaseDetails>();
		for (String tabName : tables) {
			//System.out.println("tabName "+tabName);
			DatabaseDetails tabDetail = new DatabaseDetails();
			tabDetail.setSchemaName(schemaName);
			tabDetail.setTableName(tabName);
			sqlForTabCols = ""+queryForCol+"'"+tabName+"'";
			ResultSet executeQueryColDetails = drillDao.executeQuery(stmt, sqlForTabCols);
			//System.out.println("executeQueryColDetails "+executeQueryColDetails);
			List<SqlQueryColumnDetails> listOfcolDetails = new ArrayList<SqlQueryColumnDetails>();
			
			 while (executeQueryColDetails.next())
			  {	
				 SqlQueryColumnDetails sqlColDetails = new SqlQueryColumnDetails();
				 String colName = executeQueryColDetails.getString(1);
				 //System.out.println("colName "+colName);
				 sqlColDetails.setColName(colName);
				 String colDataType = executeQueryColDetails.getString(2);
				 //System.out.println("colDataType "+colDataType);
				 sqlColDetails.setColDataType(colDataType);
				 listOfcolDetails.add(sqlColDetails);
			  }
			 tabDetail.setColDetail(listOfcolDetails);
			 //System.out.println("tabDetail "+tabDetail);
			 tableDetailsFromDrill.add(tabDetail);
		}
		//String sqlForCols = "SELECT COLUMN_NAME, DATA_TYPE FROM "+schemaName+".COLUMNS WHERE TABLE_NAME = 'Orders';";
		/*ResultSet executeQueryColDetails = drillDao.executeQuery(stmt, sqlForCols);
		System.out.println("executeQueryColDetails "+executeQueryColDetails);
		 while (executeQueryColDetails.next())
		  {
		      
		  }*/
		return tableDetailsFromDrill;
	}

	public List<DatabaseDetails> getSchemaObjectDetails(PreparedStatement stmt) throws SQLException{
		//System.out.println(schemaName);
		slf4jLogger.trace("schemaName "+schemaName);
		//System.out.println("schemaName "+schemaName);
		//DAO drillDao = ContextFactory.getDrillConnection();
		
		
		//String sqlForTables = "SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE FROM INFORMATION_SCHEMA.`TABLES` where LOWER(TABLE_SCHEMA) = 'dfs.tmp' ORDER BY TABLE_NAME DESC;";
		//System.out.println(queryForTables);
		
		//Fetching Database tables Details from Drill view
		ResultSet databaseDetails = dao.executeQuery(stmt, queryForTables);
		//System.out.println(tableDetailsFromDrillView);

		//Get tables from database
		List<String> tables = getTables(databaseDetails);
		
		return getColumnDetails(tables,dao,stmt);
	}
	
	private List<DatabaseDetails> getColumnDetails(List<String> tables, SelfServiceDAO drillDao, PreparedStatement stmt) throws SQLException {
		String sqlForTabCols;
		List<DatabaseDetails> tableDetailsFromDrill = new ArrayList<DatabaseDetails>();
		for (String tabName : tables) {
			//System.out.println("tabName "+tabName);
			DatabaseDetails tabDetail = new DatabaseDetails();
			tabDetail.setSchemaName(schemaName);
			tabDetail.setTableName(tabName);
			sqlForTabCols = "SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '"+tabName+"'";
			ResultSet executeQueryColDetails = drillDao.executeQuery(stmt, sqlForTabCols);
			//System.out.println("executeQueryColDetails "+executeQueryColDetails);
			List<SqlQueryColumnDetails> listOfcolDetails = new ArrayList<SqlQueryColumnDetails>();
			 while (executeQueryColDetails.next())
			  {
				 SqlQueryColumnDetails sqlColDetails = new SqlQueryColumnDetails();
				 String colName = executeQueryColDetails.getString(1);
				 //System.out.println("colName "+colName);
				 sqlColDetails.setColName(colName);
				 String colDataType = executeQueryColDetails.getString(2);
				 //System.out.println("colDataType "+colDataType);
				 sqlColDetails.setColDataType(colDataType);
				 listOfcolDetails.add(sqlColDetails);
			  }
			 tabDetail.setColDetail(listOfcolDetails);
			 //System.out.println("tabDetail "+tabDetail);
			 tableDetailsFromDrill.add(tabDetail);
		}
		//String sqlForCols = "SELECT COLUMN_NAME, DATA_TYPE FROM "+schemaName+".COLUMNS WHERE TABLE_NAME = 'Orders';";
		/*ResultSet executeQueryColDetails = drillDao.executeQuery(stmt, sqlForCols);
		System.out.println("executeQueryColDetails "+executeQueryColDetails);
		 while (executeQueryColDetails.next())
		  {
		      
		  }*/
		return tableDetailsFromDrill;
	}

	private List<String> getTables(ResultSet databaseDetails) throws SQLException {
		List<String> tables = new ArrayList<String>();
		while (databaseDetails.next())
		  {
			String tableName = databaseDetails.getString(2);
		      //System.out.println(tableName);
		      tables.add(tableName);
		  }
		//System.out.println(tables);
		return tables;
	}

	public Connection createConnection() throws Exception {
		//System.out.println(schemaName);
		//DAO drillDao = ContextFactory.getDrillConnection();
		/*ResultWrapperImpl resultWrap = new ResultWrapperImpl();
		resultWrap.setJdbcUrl(jdbcUrl);
		resultWrap.setJdbcDriver(jdbcDriver);*/
		Connection conn = dao.createConnection();
	    return conn;
	  }
	
	public Statement createStatement(Connection con) throws SQLException {
		Statement stmt = null;
	    if(con != null){
	    	stmt = con.createStatement();
	    } else {
	    	throw new SQLException();
	    }
	    return stmt;
	  }
	
	public Statement createPrepareStatement(Connection con, String sqlQuery) throws SQLException {
		PreparedStatement stmt = null;
	    if(con != null){
	    	stmt = con.prepareStatement(sqlQuery); 
	    } else {
	    	throw new SQLException();
	    }
	    return stmt;
	  }
	
	 public void closeConnection (Connection con) throws SQLException {	
		 //DAO drillDao = ContextFactory.getDrillConnection();
		 dao.closeConnection(con);
	  }
	 
	public List<TableDetails> executeQuery(Statement stmt, List<SqlQueryDetails> sqlQueryDetail) throws Exception {
		//DAO drillDao = ContextFactory.getDrillConnection();
		SqlQueryDetails queryDetail = sqlQueryDetail.get(0);
		//System.out.println("queryDetail "+queryDetail);
		String sqlQuery = formQuery(queryDetail);
		ResultSet resultSetFromView = dao.executeQuery(stmt,sqlQuery);
		
		return getTableDetails(resultSetFromView, sqlQueryDetail);
		}
	
	public List<TableDetails> executeQuery(PreparedStatement stmt, List<SqlQueryDetails> sqlQueryDetail) throws Exception {
		//DAO drillDao = ContextFactory.getDrillConnection();
		SqlQueryDetails queryDetail = sqlQueryDetail.get(0);
		//System.out.println("queryDetail "+queryDetail);
		
		String sqlQuery = formQuery(queryDetail);
		
		ResultSet resultSetFromView = dao.executeQuery(stmt,sqlQuery);
		
		/*List<DatabaseDetails> tableDetailsFromDrill = new ArrayList<DatabaseDetails>();
		DatabaseDetails tabDetail = new DatabaseDetails();
		tabDetail.setSchemaName(schemaName);
		tabDetail.setTableName(queryDetail.getTableName());
		List<SqlQueryColumnDetails> colDetails = new ArrayList<SqlQueryColumnDetails>();
		SqlQueryColumnDetails sqlColDetails = new SqlQueryColumnDetails();
		 while (resultSetFromView.next())
		  {
			 String colName = resultSetFromView.getString(1);
			 System.out.println("colName "+colName);
			 sqlColDetails.setColName(colName);
			 String colDataType = executeResultSetMetaData.getString(2);
			 System.out.println("colDataType "+colDataType);
			 sqlColDetails.setColDataType(colDataType);
		  }
		 tabDetail.setColDetail(sqlColDetails);
		 System.out.println("tabDetail "+tabDetail);
		 tableDetailsFromDrill.add(tabDetail);
		 System.out.println("tableDetailsFromDrill "+tableDetailsFromDrill);*/
		/*for (String key : dataFromView.keySet()) {
		    System.out.println("Key = " + key);
		}
		for (String value : dataFromView.values()) {
		    System.out.println("Value = " + value);
		}*/
		return getTableDetails(resultSetFromView,sqlQueryDetail);
		}
	
	private List<TableDetails> getTableDetails(ResultSet resultSetFromView, List<SqlQueryDetails> sqlQueryDetail) throws SQLException {
		ResultSetMetadataDetails executeResultSetMetaData = executeResultSetMetaData(resultSetFromView);
		int nosCols = executeResultSetMetaData.getNoOfCols();
		Map<String, String> dataFromView = new HashMap<String,String>();
		List<TableDetails> tabDetails = new ArrayList<TableDetails>();
		TableDetails tableDetail= new TableDetails();
		tableDetail.setSchemaName(schemaName);
		tableDetail.setTableName(sqlQueryDetail.get(0).getTableName());
		List<SqlQueryColumnDetails> colDetails = new ArrayList<SqlQueryColumnDetails>();
		int cnt = 0;
		  while (resultSetFromView.next())
			  {
			  cnt++;
			      for (int column = 1; column <= nosCols; column++) 
			      {
			    	  SqlQueryColumnDetails queryColDetails = new SqlQueryColumnDetails();
			    	  //System.out.println(cnt);
			    	  String colName = executeResultSetMetaData.getColNames()[column-1];
			    	  queryColDetails.setColName(colName);
			    	  //System.out.println(colName);
			    	  String colType = executeResultSetMetaData.getTabColDetails().get(colName);
			    	  //System.out.println(colType);
			    	  queryColDetails.setColDataType(colType);
			    	  String colValue = resultSetFromView.getString(column);
			    	  queryColDetails.setColValue(colValue);
			    	  //System.out.println(colValue);
			          dataFromView.put(colName+cnt, colValue);
			          colDetails.add(queryColDetails);
			      }
			  }
		  tableDetail.setColDetail(colDetails);
	      tabDetails.add(tableDetail);
		//System.out.println(resultSetFromView.next());
		 // System.out.println("colDetails "+tabDetails.get(0).getColDetail());
		/*  for (SqlQueryColumnDetails sqlQueryColumnDetails : tabDetails.get(0).getColDetail()) {
			System.out.println(sqlQueryColumnDetails.getColName()+""+sqlQueryColumnDetails.getColDataType()+" "+sqlQueryColumnDetails.getColValue());
		}*/
		//System.out.println("dataFromView "+dataFromView);
		return tabDetails;
	}

	public ResultSetMetadataDetails executeResultSetMetaData(ResultSet rs) throws SQLException {
		if (rs == null){
			throw new SQLException();
		}
		ResultSetMetaData resMetaData = rs.getMetaData();
		ResultSetMetadataDetails resultSetMetaDataObj = new ResultSetMetadataDetails();
		resultSetMetaDataObj.setNoOfCols(resMetaData.getColumnCount());
		String[] arr = new String[resMetaData.getColumnCount()];
		int columnCount = resMetaData.getColumnCount();
		Map<String, String> tabColDetails = new HashMap<String, String>();
		for (int column = 0; column < columnCount; column++) {
			String columnName = resMetaData.getColumnName(column+1);
			arr[column]= columnName;
			String columnType = resMetaData.getColumnTypeName(column+1);
			tabColDetails.put(columnName, columnType);
		}
		resultSetMetaDataObj.setTabColDetails(tabColDetails);
		resultSetMetaDataObj.setColNames(arr);
		//System.out.println("resultSetMetaDataObj"+Arrays.toString(resultSetMetaDataObj.getColNames()));
		return resultSetMetaDataObj;
	}
	
	private String formQuery(SqlQueryDetails SqlQueryDetail) {
		String sqlQuery = null;
		int NoOfTables = SqlQueryDetail.getTabColDetails().size();
		//System.out.println("NoOfTables "+NoOfTables);
		//System.out.println("SqlQueryDetail "+SqlQueryDetail.getTableName());
		
		DbSpec spec = new DbSpec();
		DbSchema schema = spec.addSchema(schemaName);
		DbTable Table = schema.addTable(SqlQueryDetail.getTableName());
		
		Map<String, String> tabColDetails = SqlQueryDetail.getTabColDetails();
		int noOfCols = tabColDetails.keySet().size();
		DbColumn[] cols = new DbColumn[noOfCols];
		int i = 0;
		for (String col : tabColDetails.keySet()) {
		    //System.out.println("cols = " + col);
		    DbColumn tableCol = Table.addColumn(col);
		    cols[i]= tableCol;
		    i++;
		}
		//System.out.println("cols "+cols);
		
		sqlQuery = new SelectQuery().
				addColumns(cols).
				validate().toString();
		
		/*String[] tableCols = sqlCols.getCols();
		int noOfCols = tableCols.length;
		StringBuffer sb = new StringBuffer("Select ");
		if (!sqlDb.isAllColumns()) {
			for (String stringCol : tableCols) {
				noOfCols--;
				sb.append(stringCol);
				if (noOfCols > 0) {
					sb.append(", ");
				} else{
					sb.append(" ");
				}
			} 
			sb.append("From "+sqlDb.getSchemaName()+"."+sqlDb.getTableName()+";");
			sqlQuery = sb.toString();
		}*/
		//System.out.println(sb);
		//String query1 = new SelectQuery().addColumns(custNameCol).addCondition(BinaryCondition.equalTo(custIdCol, 1)).validate().toString();
		//System.out.println(sqlQuery);
		return sqlQuery;
	}

	/*public static void main(String[] args) {
		DbSpec spec = new DbSpec();
		DbSchema schema = spec.addSchema(schemaName);
		DbTable Table = schema.addTable(SqlQueryDetail.getTableName());
	}*/
}


