package com.saitu.util;

import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class GetNewDate {
	//获取年月日
	public static Date getYMD(Date d){
		 SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd");
			try {
				d = sd.parse(sd.format(d));
				return d;
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return null;
	}
	public static Date getYMDs(String s){
		 SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date d = sd.parse(s);
				return d;
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return null;
	}
	//周末显示到星期五
	public static Date getYMDtoFriday(){
		Date   date=   new   Date();   
		Calendar c=Calendar.getInstance();
		int week = c.get(Calendar.DAY_OF_WEEK); 
		if(week==1){
			date.setDate(c.get(Calendar.DATE)+2);
		}else if(week==2){
		}else{
			date.setDate(c.get(Calendar.DATE)+1);
		}
		return getYMD(date);
	}
}
