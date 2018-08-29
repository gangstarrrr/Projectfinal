package com.java.web.mapreducer;

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
			temp=temp.replace("화북이동", "화북동");
			temp=temp.replace("화북일동", "화북동");
			temp=temp.replace("삼양일동", "삼양동");
			temp=temp.replace("삼양이동", "삼양동");
			temp=temp.replace("삼양삼동", "삼양동");
			temp=temp.replace("아라일동", "아라동");
			temp=temp.replace("아라이동", "아라동");
			temp=temp.replace("오라일동", "오라동");
			temp=temp.replace("오라이동", "오라동");
			temp=temp.replace("오라삼동", "오라동");
			temp=temp.replace("외도일동", "외도동");
			temp=temp.replace("외도이동", "외도동");
			temp=temp.replace("이호일동", "이호동");
			temp=temp.replace("이호이동", "이호동");
			temp=temp.replace("도두일동", "도두동");
			temp=temp.replace("도두이동", "도두동");
			temp=temp.replace("강정동", "대천동");
			temp=temp.replace("대포동", "대천동");
			temp=temp.replace("도순동", "대천동");
			temp=temp.replace("영남동", "대천동");
			temp=temp.replace("월평동", "대천동");
			temp=temp.replace("하원동", "대천동");
			temp=temp.replace("법환동", "대륜동");
			temp=temp.replace("서호동", "대륜동");
			temp=temp.replace("호근동", "대륜동");
			temp=temp.replace("보목동", "송산동");
			temp=temp.replace("서귀동", "송산동");
			temp=temp.replace("상예동", "중문동");
			temp=temp.replace("색달동", "중문동");
			temp=temp.replace("회수동", "중문동");
			temp=temp.replace("상효동", "영천동");
			temp=temp.replace("신효동", "영천동");
			temp=temp.replace("토평동", "영천동");
			temp=temp.replace("하예동", "예래동");
			temp=temp.replace("하효동", "효돈동");
			temp=temp.replace("내도동", "외도동");
			temp=temp.replace("도평동", "외도동");
			temp=temp.replace("도남동", "이도이동");
			temp=temp.replace("도련일동", "삼양동");
			temp=temp.replace("도련이동", "삼양동");
			temp=temp.replace("영평동", "아라동");
			temp=temp.replace("월평동", "아라동");
			temp=temp.replace("오등동", "오라동");
			temp=temp.replace("용강동", "봉개동");
			temp=temp.replace("회천동", "봉개동");
			temp=temp.replace("용담삼동", "용담이동");
			temp=temp.replace("해안동", "노형동");
			
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
