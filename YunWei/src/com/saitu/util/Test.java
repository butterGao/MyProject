package com.saitu.util;

public class Test {
	public static void main(String[] args) {
		 JpegTool j = new JpegTool();  
		      try {  
		          j.SetScale(0.1);  
		        
		          j.doFinal("c:/11.jpg","c:/22.jpg");  
		      } catch (JpegToolException e) {  
		          // TODO Auto-generated catch block  
		          e.printStackTrace();  
		      }  
		  }  
		
	}
