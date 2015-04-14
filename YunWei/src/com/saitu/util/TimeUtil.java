package com.saitu.util;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class TimeUtil {
	/**
	 * 获取唯一标示
	 */
	public static String getStringTime() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		return sdf.format(date)+UUID.randomUUID().toString().substring(0,4);//
	}
	
	public static String getDate(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(new Date());
	}
	public static Timestamp getTimestamp(String time,String format){
		DateFormat d = new SimpleDateFormat(format);
		try {
			return new Timestamp(d.parse(time).getTime());
		} catch (ParseException e) {
		}
		return null;
	}
	public static Timestamp getNewDate(){
		return new Timestamp(System.currentTimeMillis());
	}
	public static String getTime(){
		SimpleDateFormat df = new SimpleDateFormat("hh:mm:ss");
		return df.format(new Date());
	}

	public static String getFormatDate(String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		return df.format(new Date());
	}

	public static String getFormatDate(Date d, String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		return df.format(d);
	}

	public static Date formatDate(String s, String format) throws Exception {
		DateFormat df = new SimpleDateFormat(format);
		return df.parse(s);
	}
	
	public static void main(String[] args) {
		System.out.println(TimeUtil.getTimestamp("2014-12-12", "yyyy-MM-dd"));
	}
}
