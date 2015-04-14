package com.sitemap.manager;
import java.util.Date;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.model.Task;
import com.sitemap.util.TimeUtil;
import com.touch.sysif.sms.api.SmsClient;
import com.touch.sysif.sms.api.model.SmsMessage;

/**
 * 
 *邮件管理
 */
public class SMSManager {
	public static SmsClient client = null;
	public SMSManager(){
		if(client==null){
			client=new com.touch.sysif.sms.api.client.HttpSmsClient();
			client.init("config/api.properties");
		}
	}
	
	/**
	 * 得到需要提醒的目标的号码
	 */
	public void getMubiao() {
		// 得到需要提醒的任务
		List<Record> taks = Task.dao.queryTaskWhere("and open=1 and ? between mbStart and mbEnd", TimeUtil.getNewDate(),
				TimeUtil.getNewDate());
		for (Record t : taks) {
			// 得到所有没有填写目标的处室ID
			List<Record> orgs=Db.find("select o_id from task_organization t LEFT JOIN mubiao m on (m.t_id=t.t_id and m.o_id=t.o_id) where m.id is not null and t.t_id=?",
					t.getStr("id"));
			SmsMessage message = new SmsMessage();
			message.setDestAddr("15000117167");
			//短信内容必填
			message.setContent("测试abc123456");
			//是否需要状态报告可选，默认需要状态报告
			message.setReqReport(true);
			//扩展码可选，默认为空，范围： 基本接入号+接口+sourceAddr 长度不超过21位
			//如果在接口配置中未启用支持扩展， 本字段无效
			message.setSourceAddr("001");
			//定时发送时间可选，默认立即发送
			message.setSendTime(new Date());
			
			//执行发送短信，返回批次号
			System.out.println("发送结果："+client.send(message ));
		}
	}

	/**
	 * 得到需要提醒的总结的号码
	 */
	public void getZongjie() {
		List<Record> taks = Task.dao.queryTaskWhere("and open=1 and ? tween zjStart and zjEnd", TimeUtil.getNewDate(),
				TimeUtil.getNewDate());
		for (Record t : taks) {
			// 得到所有没有填写总结的处室ID
			Db.find("select o_id from task_organization t LEFT JOIN zongjie m on (m.t_id=t.t_id and m.o_id=t.o_id) where m.id is not null and t.t_id=?",
					t.getStr("id"));
		}
	}

	/**
	 * 得到需要提醒的考核人的号码
	 */
	public void getKaohe() {
		List<Record> taks = Task.dao.queryTaskWhere("and open=1 and ? between khStart and khEnd", TimeUtil.getNewDate(),
				TimeUtil.getNewDate());
		for (Record t : taks) {
		}
	}
}
