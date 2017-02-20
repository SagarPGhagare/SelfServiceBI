package com.mastek;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.healthmarketscience.sqlbuilder.BinaryCondition;
import com.healthmarketscience.sqlbuilder.CustomSql;
import com.healthmarketscience.sqlbuilder.FunctionCall;
import com.healthmarketscience.sqlbuilder.SelectQuery;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbColumn;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbSchema;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbSpec;
import com.healthmarketscience.sqlbuilder.dbspec.basic.DbTable;
import com.mastek.model.DatabaseDetails;
import com.mastek.model.GetBarChart;
import com.mastek.model.GetSqlQuery;
import com.mastek.model.SqlQueryColumnDetails;
import com.mastek.model.User;
import com.mastek.service.SelfService;

@Controller
public class WelcomeController {

	private String sqlQuery;
	private String tableName;
	private List<String> columnName;
	private List<DatabaseDetails> databaseDetails;
	private String userName;
	
	@Autowired
	public SelfService selfService;

	// inject via application.properties
	@Value("${welcome.message:test}")
	private String message = "Hello World";

	@Value("${schemaName}")
	private String schemaName;

	@RequestMapping("/")
	public String welcome(Map<String, Object> model) {
		model.put("message", this.message);
		return "welcome";
	}

	@RequestMapping("/SelfServiceBILogin")
	public String boottest(Map<String, Object> model) {
		model.put("message", this.message);
		return "selfservicebilogin";
	}

	List<String> tableListDB;

	public List<String> getTableListDB() {
		return tableListDB;
	}

	public void setTableListDB(List<String> tableListDB) {
		this.tableListDB = tableListDB;
	}

	@RequestMapping("/login")
	public ModelAndView login(@ModelAttribute("loginForm") User user) throws Exception {
		System.out.println("In login page start"+user);
		selfService.getSchemaName();
		System.out.println(schemaName);
		userName=user.getUserName();

		Connection con = selfService.createConnection();
		Statement stmt = selfService.createStatement(con);

		//First method call returns database details for display
		List<DatabaseDetails> databaseDetailsStmt = selfService.getSchemaObjectDetails(stmt);

		try
		   {
		     // create a mysql database connection
		     String myDriver = "org.gjt.mm.mysql.Driver";
		     String myUrl = "jdbc:mysql://localhost/self_srvc_bi";
		     Class.forName(myDriver);
		     Connection conn = DriverManager.getConnection(myUrl, "root", "root");
		   
		     System.out.println("Hello");

		     // create the mysql insert preparedstatement
		     ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM plugin_details");
		     int oo=0;
		     System.out.println(rs);
		     /*while(rs.next()){
		    	 System.out.println(""+rs.getString(oo));
		    	 
		    	 oo++;
		     }*/
		     
		     ResultSetMetaData metaData = rs.getMetaData();
				int columnCount = metaData.getColumnCount();
				while (rs.next())
		        {				
					JSONObject obj = new JSONObject();
					for (int i = 1; i <= columnCount; i++) {
						String columnName = metaData.getColumnName(i);
						String colData = rs.getString(i);
						System.out.println("columnName >>"+columnName+" colData >>"+colData);
			            //obj.put(columnName, colData);
					}	
		            //list.add(obj);
					oo++;
		        }
		     
		     conn.close();
		   }
		   catch (Exception e)
		   {
		     System.err.println("Got an exception!");
		     System.err.println(e.getMessage());
		   }

		
		DatabaseDetails databaseDetails = databaseDetailsStmt.get(0);
		List<SqlQueryColumnDetails> colDetail = databaseDetails.getColDetail();
		for (SqlQueryColumnDetails sqlQueryColumnDetails : colDetail) {
			System.out.println(""+sqlQueryColumnDetails.getColName());
			System.out.println(""+sqlQueryColumnDetails.getColDataType());
		}
		
		System.out.println("In login page username"+user.getUserName());
		System.out.println("In login page password"+user.getPassword());
		boolean flag=false;
		if (user.getUserName() != null && user.getPassword() != null) {
			if (user.getUserName().equals("admin") && user.getPassword().equals("admin")) {
				flag = true;
			} else {
				flag = false;
			}
			//model.put("message", this.message);
		}
		setDatabaseDetails(databaseDetailsStmt);
		if (flag) {
      	  System.out.println("Inside true");
      	  
               ModelAndView model = new ModelAndView("TabSql");
               model.addObject("lists", databaseDetailsStmt);
               model.addObject("User", user.getUserName());
               return model;
        } else {
      	  	//System.out.println("Inside else");
               ModelAndView model = new ModelAndView("TabSql");
               model.addObject("lists", databaseDetailsStmt);
               model.addObject("User", user.getUserName());
               return model;
        }
	}
	
	@RequestMapping("/logout")
    public String logout()
    {
 	   System.out.println("Inside logout");
 		return "redirect:/SelfServiceBILogin";
 	   
    }
	
	@RequestMapping("/sql")
	public String sql(Map<String, Object> model) {
		setTableName(null);
		setColumnName(null);
		model.put("lists", getDatabaseDetails());
		model.put("User",userName);
		return "TabSql";
	}

	@RequestMapping("/Visualization")
	public String visualization(Map<String, Object> model) {
		model.put("query", getSqlQuery());
		model.put("tableName", getTableName());
		model.put("columnName", getColumnName());
		model.put("databaseDetails", getDatabaseDetails());
		model.put("User",userName);
		return "TabVisualization";
	}

	/*Start : Execute Query Button*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getSqlQuery", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public JSONObject executeSQlQuery(@RequestBody GetSqlQuery sqlString){
				
		//System.out.println("sqlQuery >>"+sqlString.getQueryString());
		String query1 = getSqlQuery(sqlString); 
		JSONObject obj = new JSONObject();
		obj.put("sqlQuery", query1);
		return obj;
	}
	/*End : Execute Query Button*/
	
	/*Start : Execute Button*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getDataForTable", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<JSONObject> executeSQlButton(@RequestBody GetSqlQuery sqlString) {
		//String sqlQuery = getSqlQuery();
		//System.out.println("sqlQuery >>"+sqlString.getQueryString());
		String query1 = getSqlQuery(sqlString); 
		//String query1= "";
		ResultSet rs = null;
		List<JSONObject> list = new ArrayList<>();
		try {
			Connection con = selfService.createConnection();
			Statement stmt = selfService.createStatement(con);

			rs = stmt.executeQuery(query1);
			
			List<String> columnNames = new ArrayList<>();
			
			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();
			while (rs.next())
	        {				
				JSONObject obj = new JSONObject();
				for (int i = 1; i <= columnCount; i++) {
					String columnName = metaData.getColumnName(i);
					String colData = rs.getString(i);
		            obj.put(columnName, colData);
				}	
	            list.add(obj);
	        } 
			for (int i = 1; i <= columnCount; i++) {
				String columnName = metaData.getColumnName(i);
            	columnNames.add(columnName);
			}
			setColumnName(columnNames);
			
		} catch (Exception e) {
			System.out.println(e);
		} 
		
		JSONObject obj1 = new JSONObject();
		obj1.put("ResultSet", list);
		return list;
	}
	/*End : Execute Button*/
	
	//start : for barchart execution
	@RequestMapping(value = "/executeBar", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<JSONArray> getString(@RequestBody GetBarChart barchartData){
				
		//String xTable = StringUtils.substringBefore(barchartData.getxData(), "_");
		//String yTable = StringUtils.substringBefore(barchartData.getyData(), "_");

		String column1 = barchartData.getColumn1();
		String column2 = barchartData.getColumn2();
		String joinType = barchartData.getJoinType();
		
		String filter , operator = null , distinctVal = null , tblName = null , colName = null;

		System.out.println("filter "+barchartData.getFilter()+" operator "+barchartData.getOperator()+
				" distinctVal >>"+barchartData.getDistinctValue()+"<<");
		
		filter = barchartData.getFilter();
		/*if(!(StringUtils.isEmpty(filter) && StringUtils.isEmpty(operator) && StringUtils.isEmpty(distinctVal)
				&& filter.equals("select") && operator.equals("select") && distinctVal.equals(" "))) {*/
		if(!(StringUtils.isEmpty(filter) && StringUtils.isEmpty(operator) && StringUtils.isEmpty(distinctVal))){
			System.out.println("$##########################");
			String[] split1 = filter.split("\\.");
			tblName = split1[0];
			String secPart = split1[1];
			String[] secSplit = secPart.split("\\,");
			colName = secSplit[0];
		}
		operator = barchartData.getOperator();
		distinctVal = barchartData.getDistinctValue();
		
		System.out.println("joinType >> "+joinType);
		//System.out.println("table1 >> "+table1+" table2 >> "+table2+" leftPart >> "+leftPart+" rightPart >> "+rightPart);
		
		ArrayList<String> rowNames = new ArrayList<String>();
		ArrayList<String> columnNames = new ArrayList<String>();
		for (int i = 0; i < 2; i++) {
			if (i == 0) {
				for (String retval: barchartData.getxAxis().split(",")) {
					rowNames.add(retval);
					columnNames.add(retval);
				}
			}
			else 
				columnNames.add(barchartData.getyAxis());
		}
		
		String[] rowNmArr = barchartData.getRowNmArr();
	    Set<String> hs1 = new HashSet<>();
	    for (String string : rowNmArr) {
			String table = StringUtils.substringBeforeLast(string.toString(), ".");
			System.out.println("rowNmArr >>"+table);
			hs1.add(table);
		}
	    
	    String[] colNmArr = barchartData.getColNmArr();
	    Set<String> hs2 = new HashSet<>();
	    for (String string : colNmArr) {
			String table = StringUtils.substringBeforeLast(string.toString(), ".");
			System.out.println("colNmArr >>"+table);
			hs2.add(table);
		}
	    
		//query creation
		DbSpec spec = new DbSpec();
		DbSchema schema = spec.addSchema(selfService.getSchemaName());
		DbTable[] tableArray = null;
		
		int k=0;
		DbTable tabName = null;
		String[] tableNmArr = barchartData.getTableNmArr();
		for (String string : tableNmArr) {
			System.out.println("tableNmArr >> "+string);
		}
		
		Set<String> hs = new HashSet<>();
		for (String string : tableNmArr) {
			String table = StringUtils.substringBeforeLast(string.toString(), ".");
			hs.add(table);
		}
		tableArray = new DbTable[hs.size()];
		List<String> aliass = new ArrayList<>();
		for (String string : hs) {
			 tabName = schema.addTable(string);
			 String alias = tabName.getAlias();
			 aliass.add(alias);
			 tableArray[k] = tabName;
			 k++;
		}
		System.out.println("aliass >>"+aliass);

		String [] split, split2;
		int l1 = 0;
		DbColumn[] cols = new DbColumn[columnNames.size()];
		for (int i = 0; i < tableArray.length; i++) {
			if (!(tableArray[i].equals(null) && tableArray[i].equals(""))) {
				for (DbTable dbTable2 : tableArray) {
					if (!dbTable2.equals(null) && !dbTable2.equals("")) {
						String name = dbTable2.toString();
						for (String string : tableNmArr) {
							if (!(string.equals(null) && string.equals("") && StringUtils.isNotEmpty(string))) {
								split = string.split("\\.");
								String part1 = split[0];
								String part2 = split[1];
								split2 = part2.split("\\,");
								String colNm = split2[0];
								if (name.contains(part1) && l1 < columnNames.size()) {
									DbColumn addColumn1 = dbTable2.addColumn(colNm);
									System.out.println("l1 >> "+l1);
									cols[l1] = addColumn1;
									System.out.println("name >> "+name+" addColumn1 "+addColumn1);l1++;	
								}
							}					
						}
					}				
				}
			} 
		}
		
		/*for (DbColumn dbColumn : cols) {
			System.out.println(" dbColumn >> "+dbColumn);
		}*/

		int pos = 0;
		for (int i = 0; i < cols.length; i++) {
			if (cols[i].equals(colName)){
				pos=i;
			}
		}
		String query2 = null; 
		String alias = null;
		/*if (StringUtils.isEmpty(tblName)){
			for (String string1 : hs) {
				if(string1.contains(tblName)) {
					tabName = schema.addTable(string1);
					 alias = tabName.getAlias();
					 System.out.println("alias >>>>> "+alias);
				}
			}
		}		*/
		
		if (!(StringUtils.isEmpty(filter) && StringUtils.isEmpty(operator) && StringUtils.isEmpty(distinctVal))) {
			if ( hs.size() == 1) {
				//System.out.println("Hello");
				query2 =
					      new SelectQuery()
					      .addColumns(cols)
					      .addCondition(BinaryCondition.equalTo(new CustomSql((aliass.get(pos)+"."+colName)), new CustomSql(distinctVal)))
					      .validate().toString();
					    System.out.println(query2);
			}
		}
		else {
		
			if ( hs.size() == 1) {
				//System.out.println("Hello");
				query2 =
					      new SelectQuery()
					      .addColumns(cols)
					      .validate().toString();
					    System.out.println(query2);
			}
			else if ( hs.size() > 1 ) {
				query2 =
						new SelectQuery()
						//.addColumns(cols)
						//.addCustomJoin(joinStr)
						.addCustomColumns(cols[0],FunctionCall.sum().addColumnParams(cols[1]),cols[2])
						.addCustomJoin(SelectQuery.JoinType.valueOf(joinType), tableArray[0], tableArray[1],
								BinaryCondition.equalTo(new CustomSql(aliass.get(0)+"."+column1),
										new CustomSql(aliass.get(1)+"."+column2)))
						.addGroupings(cols[0],cols[2])
						.validate().toString();
				System.out.println(query2);
			}
		}
	

		//query creation

		/*tableAlias(tableArray,table1){
			for (DbColumn dbColumn : tableArray) {
				
			}
			return Alias;
		}*/
		/*String query2="SELECT t1.cif,sum(t1.balance),t0.mon "+
				"FROM dfs.tmp.DimDayView t0 INNER JOIN dfs.tmp.BankAccTrancView t1 "+  
				"ON (t0.day_key = t1.day_key) "+
				"group by t1.cif,t0.mon";*/
		String chartType = barchartData.getChartType();
		System.out.println("chartType >> "+chartType);
		List<JSONArray> list = jsonCreator(query2, chartType); //json creation

		return list;
	}
	//end : for barchart execution
	
	//start : to get distinct col values
		@RequestMapping(value = "/getDistinctVal", method = RequestMethod.POST, produces = "application/json")
		@ResponseBody
		public List<JSONObject> getDistinctVal(@RequestBody GetSqlQuery sqlString){
			
			String data = sqlString.getQueryString();
			String tableName, colName;
			
			String[] split = data.split("\\.");
			tableName = split[0];
			colName = split[1];
			 
			DbSpec spec = new DbSpec();
			DbSchema schema = spec.addSchema(selfService.getSchemaName());
			DbTable tableNm = schema.addTable(tableName);
			DbColumn colNm = tableNm.addColumn(colName);
			
			String query1 =
					new SelectQuery()
					.setIsDistinct(true)
					.addColumns(colNm)
					.validate().toString();
			System.out.println(query1);

			//System.out.println("tableName>> "+tableName+" colName >>"+colName);
			ResultSet rs = null;
			List<JSONObject> list = new ArrayList<>();
			try {
				Connection con = selfService.createConnection();
				Statement stmt = selfService.createStatement(con);

				rs = stmt.executeQuery(query1);
				
				List<String> columnNames = new ArrayList<>();
				
				ResultSetMetaData metaData = rs.getMetaData();
				int columnCount = metaData.getColumnCount();
				while (rs.next())
		        {				
					JSONObject obj = new JSONObject();
					for (int i = 1; i <= columnCount; i++) {
						String columnName = metaData.getColumnName(i);
						String colData = rs.getString(i);
						System.out.println("columnName, colData "+columnName+" "+colData);
			            obj.put(columnName, colData);
					}	
		            list.add(obj);
		        } 
				/*for (int i = 1; i <= columnCount; i++) {
					String columnName = metaData.getColumnName(i);
	            	columnNames.add(columnName);
				}
				setColumnName(columnNames);*/
				
			} catch (Exception e) {
				System.out.println(e);
			} 
			System.out.println("list >> "+list);
			
			JSONObject obj1 = new JSONObject();
			obj1.put("data", list);
			return list;
		}
	//End

	@SuppressWarnings("unchecked")
	private List<JSONArray> jsonCreator(String query2, String chartType) {
		List<JSONArray> list = new ArrayList<>();
		
		HashSet<String> distinctCol = new HashSet<>(); 
		//List<String> distinctVal = new ArrayList<>();
		ResultSet rs = null;
		try {
			Connection con = selfService.createConnection();
			Statement stmt = selfService.createStatement(con);
			rs = stmt.executeQuery(query2);
			
			int size = rs.getFetchSize();
			while (rs.next())
			{
				String distinct = rs.getString(1);
				distinctCol.add(distinct);
				//distinctVal.add(distinct);
			}
			System.out.println("distinctCol >> "+distinctCol);
			System.out.println("rs >> "+rs);
			int i1 =0;
			JSONArray mainarray = new JSONArray();
			List list1 = new ArrayList(distinctCol);
			int objSize = distinctCol.size();
			for (int i = 0; i < objSize; i++) {
				JSONObject obj = new JSONObject();
				obj.put("type",chartType);
				obj.put("showInLegend",true);
				obj.put("name", list1.get(i) );
				JSONArray arr = new JSONArray();
				obj.put("dataPoints", arr);
				mainarray.add(obj);
			}
			System.out.println("mainarray >> "+mainarray);
			
			//for (String string : distinctCol) {
			rs = stmt.executeQuery(query2);
			int ii=0;
				while (rs.next()) {
					
					JSONObject object =(JSONObject) mainarray.get(list1.indexOf(rs.getString(1)));
					System.out.println("list1.indexOf(rs.getString(1)) >>"+list1.indexOf(rs.getString(1)));
					JSONArray object2 = (JSONArray) object.get("dataPoints");
					JSONObject tmp = new JSONObject();
					if (rs.getMetaData().getColumnCount() > 2) {
						tmp.put("label", rs.getString(3));
						tmp.put("y", Integer.parseInt(rs.getString(2)));
					} else {
						tmp.put("label", rs.getString(2));
						tmp.put("y",Integer.parseInt(rs.getString(1)));
					}
					object2.add(tmp);
					System.out.println("tmp >> "+tmp);
					System.out.println("object2 >> "+object2);
					
				}
			list.add(mainarray);
			System.out.println("mainarray >> "+mainarray);
			
		} catch (Exception e) {
			System.out.println(e);
		} 
		
		System.out.println("list >> "+list);
		JSONObject obj1 = new JSONObject();
		obj1.put("ResultSet", list);
		return list;
	}
	
	private String getSqlQuery(GetSqlQuery sqlString) {
		
		System.out.println("##### sqlString ##### "+sqlString);
		String sqlTxt = sqlString.getQueryString();

		Connection con;
		Statement stmt;
		List<DatabaseDetails> databaseDetailsStmt = null;
		try {
			con = selfService.createConnection();
			stmt = selfService.createStatement(con);
			databaseDetailsStmt = selfService.getSchemaObjectDetails(stmt);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		DatabaseDetails databaseDetail = null;
		ArrayList<String> tableList = new ArrayList<String>();
		for (int i = 0; i <databaseDetailsStmt.size();i++) {
			databaseDetail = databaseDetailsStmt.get(i);
			String tableName = databaseDetail.getTableName();
			tableList.add(tableName);
		}

		ArrayList<String> txtAreaString = new ArrayList<String>();
		for (String retval: sqlTxt.split(",")) {
			txtAreaString.add(retval.replace(" ", ""));
		}
		String tabName = null;
		int flag = 0;
		for (String tab : tableList) {
			System.out.println("tab "+tab);
			for (String str : txtAreaString) {
				System.out.println("str "+str);
				if (str.equals(tab)) {
					flag = 1;
					tabName = tab;
					break;
				}
			}
		}
		if (flag != 1) {
			//List<DatabaseDetails> databaseDetails6 = getDatabaseDetails();
			//int size = databaseDetails6.size();
			for (int i = 0; i < databaseDetailsStmt.size(); i++) {
				DatabaseDetails tableName1 = databaseDetailsStmt.get(i);
				String tableName = tableName1.getTableName();
				List<SqlQueryColumnDetails> colDetail = tableName1.getColDetail();				

				for (String str : txtAreaString) {
					for (int j = 0; j< colDetail.size() ; j++) {
						if (str.equals(colDetail.get(j).getColName())) {
							flag = 0;
							tabName = tableName;
						}
					}
					break;
				}
			}
		}

		DbSpec spec = new DbSpec();
		DbSchema schema = spec.addSchema(selfService.getSchemaName());
		//System.out.println("getSchemaName() "+selfService.getSchemaName());
		DbTable customerTable = null;
		DbColumn[] colListDB = null;
		List<DatabaseDetails> databaseDetails5 = databaseDetailsStmt;
		for (DatabaseDetails databaseDetails : databaseDetails5) {
			if (databaseDetails.getTableName().equals(tabName)) {
				List<SqlQueryColumnDetails> colDetail = databaseDetails.getColDetail();
				int size = colDetail.size();
				colListDB = new DbColumn[size];
				int i = 0;
				customerTable = schema.addTable(tabName);
				for (SqlQueryColumnDetails sqlQueryColumnDetails : colDetail) {
					String colName = sqlQueryColumnDetails.getColName();
					DbColumn cols = customerTable.addColumn(colName);
					colListDB[i]=cols;
					System.out.println("colListDB "+colListDB[i]);					
					i++;
				}
			}
		}
		
		setTableName(tabName);
		
		String query1 = createSqlQuery(txtAreaString, tabName, flag, schema, colListDB);
		
		return query1;
	}
	private String createSqlQuery(ArrayList<String> txtAreaString, String tabName, int flag, DbSchema schema,
			DbColumn[] colListDB) {
		DbTable customerTable;
		String query1 = null;
		DbColumn[] colList2 = colListDB;
		if (flag == 1) {
			System.out.println("flag 1");
			query1 =  new SelectQuery()
					.addColumns(colList2)
					.validate().toString();
		} else {
			System.out.println("flag 0");
			//ArrayList<String> newString1 = new ArrayList<String>();
			colListDB = new DbColumn[txtAreaString.size()];
			int i = 0;
			customerTable = schema.addTable(tabName);
			System.out.println("customerTable >> "+customerTable);
			List<String> sortedList = getSortedList(txtAreaString);
			for (String cols : sortedList) {
				DbColumn cols1 = customerTable.addColumn(cols);
				colListDB[i]=cols1;
				i++;
			}
			query1 = new SelectQuery()
					.addColumns(colListDB)
					.validate().toString();
		}
		setSqlQuery(query1);
		return query1;
	}

	private List<String> getSortedList(ArrayList<String> newString) {
		List<String> list = newString;
		for(int i=0;i<list.size();i++){

			for(int j=i+1;j<list.size();j++){
				if(list.get(i).equals(list.get(j))){
					list.remove(j);
					j--;
				}
			}

		}
		System.out.println(list.toString());
		return list;
	}

	public String getSqlQuery() {
		return sqlQuery;
	}

	public void setSqlQuery(String sqlQuery) {
		this.sqlQuery = sqlQuery;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public List<String> getColumnName() {
		return columnName;
	}

	public void setColumnName(List<String> columnName) {
		this.columnName = columnName;
	}

	public List<DatabaseDetails> getDatabaseDetails() {
		return databaseDetails;
	}

	public void setDatabaseDetails(List<DatabaseDetails> databaseDetails) {
		this.databaseDetails = databaseDetails;
	}

}