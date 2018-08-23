package com.java.web.mapreducer;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;

public class Mapper_time extends org.apache.hadoop.mapreduce.Mapper<LongWritable, Text, Text, DoubleWritable>{
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		AirBean ab = new AirBean(value);
		Text outputKey = new Text();
		for(int i=0;i<24;i++) {
			outputKey.set(String.format("%02d", i)+"시");
			DoubleWritable outputValue = new DoubleWritable(ab.getTime().get(i));
			context.write(outputKey, outputValue);
			
		}
		
	}
}