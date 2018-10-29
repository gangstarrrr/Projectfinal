package com.java.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ServiceAnalysisInterface {

	public void analysis(HttpServletRequest request,HttpServletResponse response) throws Exception;
	
	public void readfile(HttpServletRequest request,HttpServletResponse response) throws Exception;
	
}
