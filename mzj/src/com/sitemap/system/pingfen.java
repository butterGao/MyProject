package com.sitemap.system;

import java.text.DecimalFormat;
/**
 * @author 高家伟
 * 评分模型model
 */
public class pingfen {
	/**
	 * 评分人或处室ID
	 */
	private String id;
	
	private String typename;
	/**
	 * 评分权重
	 */
	private String code;
	/**
	 * 评分者名称
	 */
	private String name;
	
	private String msg;
	/**
	 * 评分类型
	 */
	private int type;
	
	private Double score;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "pingfen [id=" + id + ", typename=" + typename + ", code=" + code + ", name=" + name + ", msg=" + msg
				+ ", type=" + type + ", score=" + score + "]";
	}
	public pingfen(String id,int type,String code,String name){
		this.id=id;
		this.type=type;
		this.code=code;
		this.name=name;
	}
	public pingfen(){
		
	}
	
	public pingfen(String a){
		this.name = a.split(",")[0];
		this.id=a.split(",")[1];
		this.code = a.split(",")[2];
		this.typename = a.split(",")[3];
		switch (typename) {
			case "1":
				if(id.equals("001")||id.equals("002")){
					typename="平均分,未评分计满分";
				}else{
					typename="未评分计满分";
				}
				this.type=1;
				break;
			case "2":
				if(id.equals("001")||id.equals("002")){
					typename="平均分,未评分计0分";
				}else{
					typename="未评分计0分";
				}
				this.type=2;
				break;
			case "3":
				typename="最高分";
				this.type=3;
				break;
			case "4":
				typename="最低分";
				this.type=4;
			default:
				typename="计个人分";
				this.type=0;
				break;
		}
		
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getType() {
		return type;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		 DecimalFormat df=new DecimalFormat("0.00");  
		this.score =new Double(df.format(score).toString());  
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	
}
