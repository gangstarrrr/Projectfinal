package com.java.web;

import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.io.Text;

public class AirBean {
	
	String date;
	String city;
	List<Double> time;

	
	
	public AirBean(Text value) {
		
		try {
			String[] colm = value.toString().split(",");
			String cityy[] = colm[2].split(" ");
			String temp="";
			for(int i=0;i<3;i++) {
				if(i==2) {
					temp+=cityy[i];
				}else {
					temp+=cityy[i]+" ";
				}
			}
			List<Double> temp_time=new ArrayList<Double>();
			for(int i=0;i<24;i++) {		
				temp_time.add(Double.parseDouble(colm[i+3]));			
			}
			setTime(temp_time);
			setCity(temp);
			setDate(colm[0]);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	public List<Double> getTime() {
		return time;
	}


	public void setTime(List<Double> time) {
		this.time = time;
	}

	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getCity() {
		return city;
	}


	public void setCity(String city) {
		this.city = city;
	}
	
}
