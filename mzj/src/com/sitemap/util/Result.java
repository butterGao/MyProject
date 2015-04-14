package com.sitemap.util;

public class Result {
	private String msg;//返回信息
	private int type;
	private String idVal;
	private boolean judge;//判断是否成功
	private Object content;//返回具体参数
	public Result(){
		judge=false;
	}
	public Result(boolean judge){
		this.judge=judge;
	}
	public Result(String msg){
		this.judge=false;
		this.msg=msg;
	}
	public Result(int type,String msg){
		this.type=type;
		this.judge=false;
		this.msg=msg;
	}
	
	public Result(boolean judge,String msg){
		this.judge=judge;
		this.msg=msg;
	}
	
	public Result(String msg, boolean judge, Object content) {
		this.msg = msg;
		this.judge = judge;
		this.content = content;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public boolean isJudge() {
		return judge;
	}
	public void setJudge(boolean judge) {
		this.judge = judge;
	}
	public Object getContent() {
		return content;
	}
	public void setContent(Object content) {
		this.content = content;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getIdVal() {
		return idVal;
	}
	public void setIdVal(String idVal) {
		this.idVal = idVal;
	}
}
