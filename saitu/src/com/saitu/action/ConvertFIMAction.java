package com.saitu.action;

import com.mifTest.MifMeoth;
import com.opensymphony.xwork2.ActionSupport;

public class ConvertFIMAction extends ActionSupport{
	private String mifpath;
	private String midpath;
	private String stationpath;
	private String mifroot;
	private String midroot;
	
	public String excute(){
		try {
			MifMeoth m=new MifMeoth();
			m.redLineAndPoint("c:\\clean\\cleanl.txt","c:\\clean\\l.mid","c:\\clean\\dddd.txt");
			
			return SUCCESS;
		} catch (Exception e) {
			
		}
		return INPUT;
	}
	
	
	public void setMifpath(String mifpath) {
		this.mifpath = mifpath;
	}
	public void setMidpath(String midpath) {
		this.midpath = midpath;
	}
	public void setStationpath(String stationpath) {
		this.stationpath = stationpath;
	}
	public void setMifroot(String mifroot) {
		this.mifroot = mifroot;
	}
	public void setMidroot(String midroot) {
		this.midroot = midroot;
	}
}
