package com.sitemap.system;
/**
 *权限控制
 */
public class Power {
	
	/**
	 * 任务模块
	 */
	private boolean task;
	/**
	 * 考核模块
	 */
	private boolean kaohe;
	/**
	 * 目标
	 */
	private boolean mubiao;
	/**
	 * 总结
	 */
	private boolean zongjie;
	
	private boolean queryScore;
	/**
	 * 0是领导,1是员工
	 */
	private int type;
	
	public Power() {
		type=1;
	}
	
	
	public boolean isTask() {
		return task;
	}
	public void setTask(boolean task) {
		this.task = task;
	}
	public boolean isKaohe() {
		return kaohe;
	}
	public void setKaohe(boolean kaohe) {
		this.kaohe = kaohe;
	}
	public boolean isMubiao() {
		return mubiao;
	}
	public void setMubiao(boolean mubiao) {
		this.mubiao = mubiao;
	}
	public boolean isZongjie() {
		return zongjie;
	}
	public void setZongjie(boolean zongjie) {
		this.zongjie = zongjie;
	}
	@Override
	public String toString() {
		return "Power [task=" + task + ", kaohe=" + kaohe + ", mubiao=" + mubiao + ", zongjie=" + zongjie + "]";
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}


	public boolean isQueryScore() {
		return queryScore;
	}


	public void setQueryScore(boolean queryScore) {
		this.queryScore = queryScore;
	}
}
