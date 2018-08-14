package com.java.web;


import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;



@Controller
public class AnalysisController {
	
	@Resource(name="hdConf")
	Configuration conf;
	String inputFile = "/csv";
	
	
	@RequestMapping(value="/analysis", method=RequestMethod.POST)
	public void analysis(HttpServletRequest request,HttpServletResponse response) throws Exception{		
		String type="";
		String month = request.getParameter("month");
		String btn = request.getParameter("btn");
		String path="";

		if(btn.equals("1")) {
			type="1";
			path="/csv/2015"+month+"/1-2-1-2_2015"+month+".csv";
		}else if(btn.equals("2")) {
			type="2";
			path="/csv/2015"+month+"/1-2-1-2_2015"+month+".csv";
		}else {
			type="3";
			path="/csv/"+month;
		}
		System.out.println(path);
		
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyymmdd_hhmmss");
		String str = dayTime.format(new Date(time));

		Job job = Job.getInstance(conf,"test");
		URI inputUri = URI.create(path);
		URI outputUri = URI.create("/result/"+str);
		
		FileInputFormat.addInputPath(job, new Path(inputUri));
		job.setInputFormatClass(TextInputFormat.class);
		FileOutputFormat.setOutputPath(job, new Path(outputUri));
		job.setOutputFormatClass(TextOutputFormat.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(DoubleWritable.class);
		job.setJarByClass(this.getClass());
		if(type.equals("1")) {
			System.out.println("1번");
			job.setMapperClass(Mapper_reg.class);
		}else if (type.equals("2")) {
			System.out.println("2번");
			job.setMapperClass(Mapper_time.class);
		}else {
			System.out.println("엘스");
			job.setMapperClass(Mapper_month.class);
		}
		job.setReducerClass(Reducer.class);
		job.waitForCompletion(true);
		
		System.out.println("끝");
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String name="/result/"+str+"/part-r-00000";
		resultMap.put("name", name);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/json;charset=utf-8");
		JSONObject json = JSONObject.fromObject(JSONSerializer.toJSON(resultMap));
		response.getWriter().write(json.toString());
	}
	@RequestMapping(value="/readfile", method=RequestMethod.POST)
	public void readfile(HttpServletRequest request,HttpServletResponse response) throws Exception{		
		String name = request.getParameter("name");
		URI uri = URI.create(name);
		Path path = new Path(uri);
		FileSystem file = FileSystem.get(uri, conf);
		FSDataInputStream fsis = file.open(path);
		byte[] buffer = new byte[12345];
		int byteRead = 0;
		String result = "";
		while((byteRead = fsis.read(buffer)) > 0) { 
			result = new String(buffer, 0, byteRead);
		}
		String[] rows = result.split("\n");
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		for(int j = 0; j < rows.length; j++) {
			String row = rows[j];
			String[] cols = row.split("\t");
			HashMap<String, Object> map = new HashMap<String, Object>();
			for(int c = 0; c < cols.length; c++) {
				map.put(c + "", cols[c]);
			}
			list.add(map);
		}
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", list);
		JSONObject json = JSONObject.fromObject(JSONSerializer.toJSON(resultMap));
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/json;charset=utf-8");
		response.getWriter().write(json.toString());
		
	}
}
