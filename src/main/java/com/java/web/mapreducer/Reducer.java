package com.java.web.mapreducer;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;


public class Reducer extends org.apache.hadoop.mapreduce.Reducer<Text, DoubleWritable, Text, DoubleWritable>{
	
	@Override
	protected void reduce(Text key, Iterable<DoubleWritable> value,Context context) throws IOException, InterruptedException {
		double sum =0;
		for(DoubleWritable v : value) {
			sum+=v.get();
		}
		System.out.println(key+","+sum);
		DoubleWritable result= new DoubleWritable();
		result.set(sum);
		context.write(key, result);
	}
}
