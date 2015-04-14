package com.mifTest;

public class MathPoint {
	public static double pd=4.8564287290505043E-4;
	
	public static double sum(double a, double b,double x,double y){
		double d;
		d= Math.sqrt((x-a)*(x-a) +(y-b)*(y-b));
		return d;
	}
	public static void main(String[] args) {
		String s="121.540048 31.143012";
		System.out.println(jude("121.539928 31.142934","121.540048 31.143012"));
		//judgeRange("121.466118 31.234503","121.468092 31.235308","121.468047 31.235391");
	}
	
	/**
	 * @param a1 要判断的点
	 * @param y1线段两端点
	 * @param x1
	 * @return 小于50米返回TRUE
	 */
	public static boolean judgeRange(String a1,String y1,String x1){
		double a=Double.parseDouble(a1.split(" ", 2)[0]);
		double b=Double.parseDouble(a1.split(" ", 2)[1]);
		double x0=Double.parseDouble(y1.split(" ", 2)[0]);
		double y0=Double.parseDouble(y1.split(" ", 2)[1]);
		double xm=Double.parseDouble(x1.split(" ", 2)[0]);
		double ym=Double.parseDouble(x1.split(" ", 2)[1]);
		double d=Math.abs((a-x0)*(y0-ym)-(b-y0)*(x0-xm))/Math.sqrt(Math.pow(y0-ym, 2)+Math.pow(x0-xm,2));
		return d<pd;
	}
	
	public static double sumRange(String s,String s2){
		double a=Double.parseDouble(s.split(" ", 2)[0]);
		double b=Double.parseDouble(s.split(" ", 2)[1]);
		double x=Double.parseDouble(s2.split(" ", 2)[0]);
		double y=Double.parseDouble(s2.split(" ", 2)[1]);
		return Math.sqrt((x-a)*(x-a) +(y-b)*(y-b));
	}
	
	/**
	 * @return 小于50米返回true
	 */
	public static boolean jude(String s,String s2){
		if(s.equals(s2)){
			return false;
		}
		double a=Double.parseDouble(s.split(" ", 2)[0]);
		double b=Double.parseDouble(s.split(" ", 2)[1]);
		double x=Double.parseDouble(s2.split(" ", 2)[0]);
		double y=Double.parseDouble(s2.split(" ", 2)[1]);
		if(sum(a, b, x, y)<pd){
			return true;
		}
		return false;
	}
}
