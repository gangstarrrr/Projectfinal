package com.java.web.mapreducer;

import org.apache.hadoop.io.Text;

public class AirBean_mon {
	
	String month;
	double  num;

	
	
	public AirBean_mon(Text value) {
		
		try {
			String[] colm = value.toString().split(",");
			String month = colm[0];
			num=Double.parseDouble(colm[1]);
			
			setMonth(month);
			setNum(num);

			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}



	public String getMonth() {
		return month;
	}



	public void setMonth(String month) {
		this.month = month;
	}



	public double getNum() {
		return num;
	}



	public void setNum(double num) {
		this.num = num;
	}

	
	
}
