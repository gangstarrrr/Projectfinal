package com.java.web.mapreducer;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;

public class Mapper_reg extends org.apache.hadoop.mapreduce.Mapper<LongWritable, Text, Text, DoubleWritable>{
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		AirBean ab = new AirBean(value);
		Text outputKey = new Text();
		outputKey.set(ab.getCity());
		double temp=0;
		for(int i=0;i<24;i++) {
			
			temp+=ab.getTime().get(i);
		}
		
		DoubleWritable outputValue = new DoubleWritable(temp);
		context.write(outputKey, outputValue);
		
	}
}