package com.java.web.mapreducer;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;

public class Mapper_month extends org.apache.hadoop.mapreduce.Mapper<LongWritable, Text, Text, DoubleWritable>{
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		AirBean_mon ab = new AirBean_mon(value);
		Text outputKey = new Text();
		outputKey.set(ab.getMonth()+"월");	
		
		DoubleWritable outputValue = new DoubleWritable(ab.getNum());
		context.write(outputKey, outputValue);
		
	}
}