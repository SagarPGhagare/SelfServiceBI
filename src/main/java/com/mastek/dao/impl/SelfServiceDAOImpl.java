package com.mastek.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.stereotype.Service;

import com.mastek.dao.SelfServiceDAO;

@Service
@Configuration
@ComponentScan(basePackages = { "com.mastek.selfservicebi.*" })
@PropertySource("classpath:config.properties")
public class SelfServiceDAOImpl implements SelfServiceDAO {

	@Value("${jdbcUrl}")
	private String jdbcUrl;
	
	public String getJdbcUrl() {
		return jdbcUrl;
	}

	public void setJdbcUrl(String jdbcUrl) {
		this.jdbcUrl = jdbcUrl;
	}

	public String getJdbcDriver() {
		return jdbcDriver;
	}

	public void setJdbcDriver(String jdbcDriver) {
		this.jdbcDriver = jdbcDriver;
	}

	@Value("${jdbcDriver}")
	private String jdbcDriver;
	
	public Connection createConnection() throws Exception {
	    Connection con = null;
	    //System.out.println("jdbcDriver"+jdbcDriver);
	    Class.forName(jdbcDriver);
    	con =DriverManager.getConnection(jdbcUrl);
		//con = new Driver().connect(DRILL_JDBC_LOCAL_URI, getDefaultProperties());
	    return con;
	  }
	
	public Statement createStatement(Connection con) throws SQLException {
		Statement stmt = null;
	    if(con != null){
	    	//con = new Driver().connect(DRILL_JDBC_LOCAL_URI, getDefaultProperties());
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
	
	  /*public static Properties getDefaultProperties() {
	    final Properties properties = new Properties();
	    properties.setProperty(oadd.org.apache.drill.exec.ExecConstants.HTTP_ENABLE,"false");
	    return properties;
	  }*/
	  
	  public ResultSet executeQuery(Statement stmt,String sqlQuery) throws SQLException {
			if (stmt == null){
				throw new SQLException();
			}
			ResultSet rs = stmt.executeQuery(sqlQuery);
			return rs;
		}
		
		public ResultSetMetaData executeResultSetMetaData(ResultSet rs) throws SQLException {
			if (rs == null){
				throw new SQLException();
			}
			ResultSetMetaData resMetaData = rs.getMetaData();
			return resMetaData;
		}
	  
	  public void closeConnection (Connection con) throws SQLException {		 
		  if (con != null) {
     		 con.close();
     	 }else{
     		 throw new SQLException();
     	 }
	  }

	  @Bean
		public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
			return new PropertySourcesPlaceholderConfigurer();
		}
}
