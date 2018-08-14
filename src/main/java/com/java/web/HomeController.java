package com.java.web;

import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;


@Controller
public class HomeController {
	
	@Resource(name="hdConf")
	Configuration conf;
	HashMap<String, Object> resultMap;
	List<HashMap<String, Object>> resultList;
	String inputFile = "/csv";
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "home";
	}

	@RequestMapping(value = "/see_something", method = RequestMethod.GET)
	public String see_something(Locale locale, Model model) {
		return "see_something";
	}
	
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public String chart(Locale locale, Model model) {
		return "chart";
	}
	
	@RequestMapping(value = "/month_chart", method = RequestMethod.GET)
	public String month_chart(Locale locale, Model model,HttpServletRequest request,HttpServletResponse response) throws IOException{
		return "month_chart";
	}
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Locale locale, Model model) {
		return "test";
	}
	@RequestMapping(value = "/dir", method = RequestMethod.POST)
	public void dir(HttpServletResponse response) throws IOException {
		resultList=new ArrayList<HashMap<String, Object>>();
		getDir(inputFile);
		HashMap<String, Object> result=new HashMap<String, Object>();
		result.put("result", resultList);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/json;charset=utf-8");
		JSONObject json = JSONObject.fromObject(JSONSerializer.toJSON(result));
		response.getWriter().write(json.toString());
	}
	
	@RequestMapping(value = "/month", method = RequestMethod.GET)
	public void month(HttpServletRequest request) {
		String month=request.getParameter("month");
		System.out.println(month);
		HashMap<String, Object> map = new HashMap<String, Object>();
	}
	
   public FileStatus[] getStatus(String newPath) throws IOException {  
	   URI uri = URI.create(newPath);
	   Path path = new Path(uri);
	   FileSystem file = FileSystem.get(uri, conf);
	   return file.listStatus(path);
	   }
	   
   public void getDir(String newPath) throws IOException {
	   FileStatus[] dirList = getStatus(newPath);
      for(int i = 0; i < dirList.length; i ++) {
    	  	String name = dirList[i].getPath().getName();
    	  	if(name.contains(".csv")) {
    	  		continue;
    	  	}else {
    	  		resultMap = new HashMap<String, Object>();
    	    	resultMap.put(name, newPath + "/" + name);
    	    	resultList.add(resultMap);
    	  	}
			
         
      }
		      
	}
}
