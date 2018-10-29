package com.java.web.controller;


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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.java.web.mapreducer.Mapper_month;
import com.java.web.mapreducer.Mapper_reg;
import com.java.web.mapreducer.Mapper_time;
import com.java.web.mapreducer.Reducer;
import com.java.web.service.ServiceAnalysisInterface;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;



@Controller
public class AnalysisController {
	
	
	@Autowired
	ServiceAnalysisInterface sai;
	
	@RequestMapping(value="/analysis", method=RequestMethod.POST)
	public void analysis(HttpServletRequest request,HttpServletResponse response) throws Exception{		
		sai.analysis(request, response);
	}
	@RequestMapping(value="/readfile", method=RequestMethod.POST)
	public void readfile(HttpServletRequest request,HttpServletResponse response) throws Exception{		
		sai.readfile(request, response);
	}
}
