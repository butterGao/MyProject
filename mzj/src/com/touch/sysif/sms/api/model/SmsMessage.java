/*****************************************
 *  所有版权(c) 上海塔齐通讯技术有限公司       *
 *****************************************/
package com.touch.sysif.sms.api.model;


/**
 * 短信
 * @version $Revision: 1.0 $ 
 * @author yanxiao
 * @date: Jan 17, 2014
 * @time: 10:16:27 PM
 */
public class SmsMessage  implements java.io.Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = -8031857499587814180L;

	private java.lang.String batchId;

    private java.lang.String content;

    private java.lang.String destAddr;

    private java.lang.Boolean reqReport = true;

    private java.util.Date sendTime;

    private java.lang.String smsParam;

    private java.lang.String sourceAddr = "";

    public SmsMessage() {
    }

    public SmsMessage(
           java.lang.String batchId,
           java.lang.String content,
           java.lang.String destAddr,
           java.lang.Boolean reqReport,
           java.util.Date sendTime,
           java.lang.String smsParam,
           java.lang.String sourceAddr) {
           this.batchId = batchId;
           this.content = content;
           this.destAddr = destAddr;
           this.reqReport = reqReport;
           this.sendTime = sendTime;
           this.smsParam = smsParam;
           this.sourceAddr = sourceAddr;
    }


    /**
     * Gets the batchId value for this SmsMessage.
     * 
     * @return batchId
     */
    public java.lang.String getBatchId() {
        return batchId;
    }


    /**
     * Sets the batchId value for this SmsMessage.
     * 
     * @param batchId
     */
    public void setBatchId(java.lang.String batchId) {
        this.batchId = batchId;
    }


    /**
     * Gets the content value for this SmsMessage.
     * 
     * @return content
     */
    public java.lang.String getContent() {
        return content;
    }


    /**
     * Sets the content value for this SmsMessage.
     * 
     * @param content
     */
    public void setContent(java.lang.String content) {
        this.content = content;
    }


    /**
     * Gets the destAddr value for this SmsMessage.
     * 
     * @return destAddr
     */
    public java.lang.String getDestAddr() {
        return destAddr;
    }


    /**
     * Sets the destAddr value for this SmsMessage.
     * 
     * @param destAddr
     */
    public void setDestAddr(java.lang.String destAddr) {
        this.destAddr = destAddr;
    }


    /**
     * Gets the reqReport value for this SmsMessage.
     * 
     * @return reqReport
     */
    public java.lang.Boolean getReqReport() {
        return reqReport;
    }


    /**
     * Sets the reqReport value for this SmsMessage.
     * 
     * @param reqReport
     */
    public void setReqReport(java.lang.Boolean reqReport) {
        this.reqReport = reqReport;
    }


    /**
     * Gets the sendTime value for this SmsMessage.
     * 
     * @return sendTime
     */
    public java.util.Date getSendTime() {
        return sendTime;
    }


    /**
     * Sets the sendTime value for this SmsMessage.
     * 
     * @param sendTime
     */
    public void setSendTime(java.util.Date sendTime) {
        this.sendTime = sendTime;
    }


    /**
     * Gets the smsParam value for this SmsMessage.
     * 
     * @return smsParam
     */
    public java.lang.String getSmsParam() {
        return smsParam;
    }


    /**
     * Sets the smsParam value for this SmsMessage.
     * 
     * @param smsParam
     */
    public void setSmsParam(java.lang.String smsParam) {
        this.smsParam = smsParam;
    }


    /**
     * Gets the sourceAddr value for this SmsMessage.
     * 
     * @return sourceAddr
     */
    public java.lang.String getSourceAddr() {
        return sourceAddr;
    }


    /**
     * Sets the sourceAddr value for this SmsMessage.
     * 
     * @param sourceAddr
     */
    public void setSourceAddr(java.lang.String sourceAddr) {
        this.sourceAddr = sourceAddr;
    }

    
    @Override
	public String toString() {
		return "SmsMessage [batchId=" + batchId + ", content=" + content
				+ ", destAddr=" + destAddr + ", reqReport=" + reqReport
				+ ", sendTime=" + sendTime + ", smsParam=" + smsParam
				+ ", sourceAddr=" + sourceAddr + "]";
	}


}
