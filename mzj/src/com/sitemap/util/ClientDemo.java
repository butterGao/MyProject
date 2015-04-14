/*****************************************
 *  所有版权(c) 上海塔齐通讯技术有限公司       *
 *****************************************/
package com.sitemap.util;

import java.util.Arrays;
import java.util.Date;

import com.touch.sysif.sms.api.SmsClient;
import com.touch.sysif.sms.api.model.SmsMessage;

/**
 * 
 * @version $Revision: 1.0 $ 
 * @author yanxiao
 * @date: Jan 21, 2014
 * @time: 2:00:24 AM
 */
public class ClientDemo {
	
	public static void main(String[] args) {
		/**
		 * 数据库接口实现
		 * 
		 */
		//SmsClient client = new com.touch.sysif.sms.api.client.DbSmsClient();
		/**
		 * WebService接口实现
		 * 
		 */
		//SmsClient client = new com.touch.sysif.sms.api.client.WsSmsClient();
		/**
		 * Http接口实现
		 * 
		 */
		SmsClient client = new com.touch.sysif.sms.api.client.HttpSmsClient();
		
		System.out.println(client);
		//初始化API，帐号信息必填，根据 SmsClient 实现选填对应参数
		client.init("config/api.properties");
		//设置发送消息属性
		SmsMessage message = new SmsMessage();
		//短信接收号码必填多个号号码用‘；’或者','隔开，群发时建议不超过100个号码
		message.setDestAddr("13800138000");
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
		//本示例中休眠5秒后获取状态和上行，实际使用时建议采用多线程方式轮询获取。
		try {
			Thread.sleep(5000);
		} catch (Exception e) {
		}
		//获取状态报告，参数为批次号和手机号码，都是可选参数，最多一次返回10条状态
		System.out.println("状态报告："+Arrays.toString(client.getSmsReports(null, null)));
		//获取上行短信
		System.out.println("上行短信："+Arrays.toString(client.getSmsMessage()));
		//退出
		client.shutdown();
	}
	
	
}
