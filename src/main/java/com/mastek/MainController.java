package com.mastek;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mastek.model.Plugin;
import com.mastek.model.Views;

@Controller
public class MainController {

	private List<Views> views = new ArrayList<Views>();
	
	public List<Views> getViews() {
		return views;
	}

	public void setViews(List<Views> views) {
		this.views = views;
	}

	@RequestMapping(value = "/spring-boot-web-jsp", method = RequestMethod.GET)
	public ModelAndView getdata() throws HttpException, JSONException, IOException  {

		List<Views> list = getList();
		/*List<Views> views = new ArrayList<Views>();
		Views view =new Views();
		view.setName("hbase");
		views.add(view);
		Views view1 =new Views();
		view1.setName("hive");
		views.add(view1);
		Views view2 =new Views();
		view2.setName("kudus");
		views.add(view2);
		Views view3 =new Views();
		view3.setName("s3");
		views.add(view3);*/
		//return back to index.jsp
		ModelAndView model = new ModelAndView("index");
		model.addObject("lists", list);
		model.addObject("lo", getViews());

		return model;

	}
	
	@RequestMapping("/create")
	public String boottest(Model model,@ModelAttribute("createPlugin") Plugin plugin) {
		System.out.println(plugin.getStorageName());
		model.addAttribute("name", plugin.getStorageName());
		return "createStoragePlugin";
	}
	
	@RequestMapping("/update")
	public String updatePlugin(Model model,@ModelAttribute("updatePlugin") Plugin plugin,@RequestParam(value = "name", required = true) String name) throws HttpException, IOException, JSONException {
		System.out.println(plugin.getStorageName());
		System.out.println(name);
		String url = "http://localhost:8047/storage/"+name+".json";
		
		 GetMethod get = new GetMethod(url);
	      new HttpClient().executeMethod(get);
	      ByteArrayOutputStream outputStream = new ByteArrayOutputStream() ;
	      byte[] byteArray = new byte[1024];
	      int count = 0 ;
	      while((count = get.getResponseBodyAsStream().read(byteArray, 0, byteArray.length)) > 0)
	      {
	         outputStream.write(byteArray, 0, count) ;
	      }
	      System.out.println(new String(outputStream.toByteArray(), "UTF-8"));
	      String jsonString = new String(outputStream.toByteArray());
	      JSONArray inputArray = new JSONArray("["+jsonString+"]");
	      //System.out.println(inputArray);
	      int length = inputArray.length();
	      //System.out.println(length);
	      String pluginDetail = null;
	      JSONObject object = null;
	      for (int i = 0; i < length; i++) {
	    	  JSONObject jsonObject = inputArray.getJSONObject(i);
	    	  object = (JSONObject) jsonObject.get("config");
	    	  pluginDetail = object.toString();
	      }
	      JsonParser parser = new JsonParser();
	      JsonObject json = parser.parse(pluginDetail).getAsJsonObject();

	      Gson gson = new GsonBuilder().setPrettyPrinting().create();
	      String prettyJson = gson.toJson(json);
	      System.out.println("pluginDetail "+prettyJson);
		model.addAttribute("pluginDetails", prettyJson);
		model.addAttribute("name", name);
		return "updateStoragePlugin";
	}

	@RequestMapping("/disable")
	public ModelAndView disablePlugin(@RequestParam(value = "name", required = true) String name) throws HttpException, JSONException, IOException {
		System.out.println(name);
		String url = "http://localhost:8047/storage/"+name+"/enable/false";
		
		 GetMethod get = new GetMethod(url);
	      new HttpClient().executeMethod(get);
	      ByteArrayOutputStream outputStream = new ByteArrayOutputStream() ;
	      byte[] byteArray = new byte[1024];
	      int count = 0 ;
	      while((count = get.getResponseBodyAsStream().read(byteArray, 0, byteArray.length)) > 0)
	      {
	         outputStream.write(byteArray, 0, count) ;
	      }
	      System.out.println(new String(outputStream.toByteArray(), "UTF-8"));
	      
	      List<Views> list = getList();
		//return back to index.jsp
		ModelAndView model = new ModelAndView("index");
		model.addObject("lists", list);
		model.addObject("lo", getViews());
		return model;
	}
	
	@RequestMapping("/enable")
	public ModelAndView enablePlugin(@RequestParam(value = "name", required = true) String name) throws HttpException, JSONException, IOException {
		System.out.println(name);
		String url = "http://localhost:8047/storage/"+name+"/enable/true";
		
		 GetMethod get = new GetMethod(url);
	      new HttpClient().executeMethod(get);
	      ByteArrayOutputStream outputStream = new ByteArrayOutputStream() ;
	      byte[] byteArray = new byte[1024];
	      int count = 0 ;
	      while((count = get.getResponseBodyAsStream().read(byteArray, 0, byteArray.length)) > 0)
	      {
	         outputStream.write(byteArray, 0, count) ;
	      }
	      System.out.println(new String(outputStream.toByteArray(), "UTF-8"));
	      
	      List<Views> list = getList();
		//return back to index.jsp
		ModelAndView model = new ModelAndView("index");
		model.addObject("lists", list);
		model.addObject("lo", getViews());
		return model;
	}
	
	@RequestMapping("/updateStorage")
	public String updateStoragePlugin(Model model,@ModelAttribute("updateStoragePlugin") Plugin plugin) throws JSONException {
		System.out.println(plugin.getStorageName());
		String restUrl="http://localhost:8047/storage/"+plugin.getStorageName()+".json";
        JSONObject user=new JSONObject();
        user.put("name", plugin.getStorageName());
        JSONObject user1=new JSONObject(plugin.getJsonString());
        //user1.put("type", plugin.getJsonString());
        user.put("config", user1);
        
        String jsonData=user.toString();
        System.out.println("user.toString() "+user.toString());
        //HttpPostReq httpPostReq=new HttpPostReq();
        HttpPost httpPost=createConnectivity(restUrl, null, null);
        String executeReq = executeReq( jsonData, httpPost);
		model.addAttribute("jsonData", plugin.getJsonString());
		model.addAttribute("message", executeReq);
		return "updateStoragePlugin";
	} 
	
	@RequestMapping("/delete")
	public String deletePlugin(Model model,@RequestParam(value = "name", required = true) String name) throws JSONException {
		System.out.println(name);
		String restUrl="http://localhost:8047/storage/"+name+".json";
       /* JSONObject user=new JSONObject();
        user.put("name", name);
        JSONObject user1=new JSONObject(plugin.getJsonString());
        //user1.put("type", plugin.getJsonString());
        user.put("config", user1);
        
        String jsonData=user.toString();
        System.out.println("user.toString() "+user.toString());*/
        //HttpPostReq httpPostReq=new HttpPostReq();
        HttpDelete httpPost=createConnectivityDel(restUrl, null, null);
        String executeReq = executeReq( null, httpPost);
		model.addAttribute("name", name);
		model.addAttribute("message", executeReq);
		return "updateStoragePlugin";
	} 
	
	private String executeReq(Object jsonData, HttpDelete httpPost) {
		String executeHttpRequest = null;
        try{
        	executeHttpRequest = executeHttpRequest(jsonData, httpPost);
        }
        catch(Exception e){
            System.out.println("exception occured while sending http request : "+e);
        }
        finally{
            httpPost.releaseConnection();
        }
		return executeHttpRequest;
	}

	private String executeHttpRequest(Object jsonData, HttpDelete httpPost) throws ClientProtocolException, IOException {
		HttpResponse response=null;
        String line = "";
        StringBuffer result = new StringBuffer();
        //httpPost.setEntity(new StringEntity(jsonData));
        org.apache.http.client.HttpClient httpClient = HttpClientBuilder.create().build();
        response = httpClient.execute(httpPost);
        System.out.println("Post parameters : " + jsonData );
        System.out.println("Response Code : " +response.getStatusLine().getStatusCode());
        BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
        while ((line = reader.readLine()) != null){ result.append(line); }
        System.out.println(result.toString());
		return result.toString();
	}

	@RequestMapping("/updateStoragePluginDisable")
	public String updateStoragePluginDisable(Model model,@RequestParam(value = "name", required = true) String name) throws HttpException, IOException, JSONException {
		System.out.println(name);
		String url = "http://localhost:8047/storage/"+name+".json";
		
		 GetMethod get = new GetMethod(url);
	      new HttpClient().executeMethod(get);
	      ByteArrayOutputStream outputStream = new ByteArrayOutputStream() ;
	      byte[] byteArray = new byte[1024];
	      int count = 0 ;
	      while((count = get.getResponseBodyAsStream().read(byteArray, 0, byteArray.length)) > 0)
	      {
	         outputStream.write(byteArray, 0, count) ;
	      }
	      System.out.println(new String(outputStream.toByteArray(), "UTF-8"));
	      String jsonString = new String(outputStream.toByteArray());
	      JSONArray inputArray = new JSONArray("["+jsonString+"]");
	      //System.out.println(inputArray);
	      int length = inputArray.length();
	      //System.out.println(length);
	      String pluginDetail = null;
	      JSONObject object = null;
	      for (int i = 0; i < length; i++) {
	    	  JSONObject jsonObject = inputArray.getJSONObject(i);
	    	  object = (JSONObject) jsonObject.get("config");
	    	  pluginDetail = object.toString();
	      }
	      JsonParser parser = new JsonParser();
	      JsonObject json = parser.parse(pluginDetail).getAsJsonObject();

	      Gson gson = new GsonBuilder().setPrettyPrinting().create();
	      String prettyJson = gson.toJson(json);
	      System.out.println("pluginDetail "+prettyJson);
		model.addAttribute("pluginDetails", prettyJson);
		model.addAttribute("name", name);
		return "updateStoragePluginDisable";
	}
	@RequestMapping("/createStorage")
	public String createStorage(Model model,@ModelAttribute("createStoragePlugin") Plugin plugin) throws JSONException {
		System.out.println(plugin.getStorageName());
		String restUrl="http://localhost:8047/storage/"+plugin.getStorageName()+".json";
        JSONObject user=new JSONObject();
        user.put("name", plugin.getStorageName());
        JSONObject user1=new JSONObject(plugin.getJsonString());
        //user1.put("type", plugin.getJsonString());
        user.put("config", user1);
        
        String jsonData=user.toString();
        System.out.println("user.toString() "+user.toString());
        //HttpPostReq httpPostReq=new HttpPostReq();
        HttpPost httpPost=createConnectivity(restUrl, null, null);
        String executeReq = executeReq( jsonData, httpPost);
		model.addAttribute("jsonData", plugin.getJsonString());
		model.addAttribute("message", executeReq);
		return "createStoragePlugin";
	}
	private List<Views> getList() throws JSONException, HttpException, IOException  {
		/*List<String> list = new ArrayList<String>();
		list.add("List A");
		list.add("List B");
		list.add("List C");
		list.add("List D");
		list.add("List 1");
		list.add("List 2");
		list.add("List 3");

		return list;*/
		String url = "http://localhost:8047/storage.json";
		GetMethod get = new GetMethod(url);
	      new HttpClient().executeMethod(get);
	      ByteArrayOutputStream outputStream = new ByteArrayOutputStream() ;
	      byte[] byteArray = new byte[1024];
	      int count = 0 ;
	      while((count = get.getResponseBodyAsStream().read(byteArray, 0, byteArray.length)) > 0)
	      {
	         outputStream.write(byteArray, 0, count) ;
	      }
	      byte[] byteArray2 = outputStream.toByteArray();
	      ByteArrayInputStream bais = new ByteArrayInputStream(byteArray2);
	      /*JsonReader reader = Json.createReader(bais);
	      JsonObject readObject = reader.readObject();
	      System.out.println(readObject.toString());
	      
	      
	      JSONArray inputArray = new JSONArray(new String(outputStream.toByteArray(), "UTF-8"));
	      JSONObject jo = inputArray.getJSONObject(1);*/
	      
	      List<Views> views = new ArrayList<Views>();
	      List<Views> views1 = new ArrayList<Views>();
	      String jsonString = new String(outputStream.toByteArray());
	      JSONArray inputArray = new JSONArray(jsonString);
	      int length = inputArray.length();
	      for (int i = 0; i < length; i++) {
	    	  JSONObject jsonObject = inputArray.getJSONObject(i);
	    	  JSONObject object = (JSONObject) jsonObject.get("config");
	    	  //System.out.println(object.get("enabled"));
	    	  
	    	  if (object.get("enabled").equals(true)) {
	    		  Views view =new Views();
	    		  Object object1 = jsonObject.get("name");
	    		  //System.out.println(object1);
	    		  view.setName(object1.toString());
	    		  views.add(view);
			} else {
				 Views view =new Views();
	   		  Object object1 = jsonObject.get("name");
	   		  //System.out.println(object1);
	   		  view.setName(object1.toString());
	   		  views1.add(view);
			}
	    	  
		}
	      /*JSONObject jo = inputArray.getJSONObject(1);
	      System.out.println(jo.get("enabled"));*/
	      System.out.println(views);
	      System.out.println(views1);
	      setViews(views1);
		/*List<Views> views11 = new ArrayList<Views>();
		Views view =new Views();
		view.setName("cp");
		views11.add(view);
		Views view1 =new Views();
		view1.setName("dfs");
		views11.add(view1);
		Views view2 =new Views();
		view2.setName("mysql");
		views11.add(view2);
		Views view3 =new Views();
		view3.setName("mongo");
		views11.add(view3);*/
		return views;
	}

	HttpPost createConnectivity(String restUrl, String username, String password)
    {
        HttpPost post = new HttpPost(restUrl);
        //String auth=new StringBuffer(username).append(":").append(password).toString();
       // byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("US-ASCII")));
        //String authHeader = "Basic " + new String(encodedAuth);
        //post.setHeader("AUTHORIZATION", authHeader);
        post.setHeader("Content-Type", "application/json");
            post.setHeader("Accept", "application/json");
            post.setHeader("X-Stream" , "true");
        return post;
    }
	
	HttpDelete createConnectivityDel(String restUrl, String username, String password)
    {
        HttpDelete post = new HttpDelete(restUrl);
        //String auth=new StringBuffer(username).append(":").append(password).toString();
       // byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("US-ASCII")));
        //String authHeader = "Basic " + new String(encodedAuth);
        //post.setHeader("AUTHORIZATION", authHeader);
        post.setHeader("Content-Type", "application/json");
            post.setHeader("Accept", "application/json");
            post.setHeader("X-Stream" , "true");
        return post;
    }
     
    String executeReq(String jsonData, HttpPost httpPost)
    {
    	String executeHttpRequest = null;
        try{
        	executeHttpRequest = executeHttpRequest(jsonData, httpPost);
        }
        catch (UnsupportedEncodingException e){
            System.out.println("error while encoding api url : "+e);
        }
        catch (IOException e){
            System.out.println("ioException occured while sending http request : "+e);
        }
        catch(Exception e){
            System.out.println("exception occured while sending http request : "+e);
        }
        finally{
            httpPost.releaseConnection();
        }
		return executeHttpRequest;
    }
     
    String executeHttpRequest(String jsonData,  HttpPost httpPost)  throws UnsupportedEncodingException, IOException
    {
        HttpResponse response=null;
        String line = "";
        StringBuffer result = new StringBuffer();
        httpPost.setEntity(new StringEntity(jsonData));
        org.apache.http.client.HttpClient httpClient = HttpClientBuilder.create().build();
        response = httpClient.execute(httpPost);
        System.out.println("Post parameters : " + jsonData );
        System.out.println("Response Code : " +response.getStatusLine().getStatusCode());
        BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
        while ((line = reader.readLine()) != null){ result.append(line); }
        System.out.println(result.toString());
		return result.toString();
    }
}