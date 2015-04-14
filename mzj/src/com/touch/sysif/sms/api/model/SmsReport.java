/*****************************************
 *  所有版权(c) 上海塔齐通讯技术有限公司       *
 *****************************************/
package com.touch.sysif.sms.api.model;

import java.util.Arrays;

/**
 * 短信回执
 * 
 * @version $Revision: 1.0 $ 
 * @author yanxiao
 * @date: Jan 17, 2014
 * @time: 10:18:21 PM
 */
public class SmsReport  implements java.io.Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = -8506186940325188388L;

	private java.lang.String batchId;

    private java.lang.String destAddr;

    private com.touch.sysif.sms.api.model.SubSmsMessage[] message;

    private java.util.Date receivedTime;

    private java.lang.String sourceAddr;

    private int statusCode;

    private java.lang.String statusText;

    public SmsReport() {
    }

    public SmsReport(
           java.lang.String batchId,
           java.lang.String destAddr,
           com.touch.sysif.sms.api.model.SubSmsMessage[] message,
           java.util.Date receivedTime,
           java.lang.String sourceAddr,
           int statusCode,
           java.lang.String statusText) {
           this.batchId = batchId;
           this.destAddr = destAddr;
           this.message = message;
           this.receivedTime = receivedTime;
           this.sourceAddr = sourceAddr;
           this.statusCode = statusCode;
           this.statusText = statusText;
    }


    /**
     * Gets the batchId value for this SmsReport.
     * 
     * @return batchId
     */
    public java.lang.String getBatchId() {
        return batchId;
    }


    /**
     * Sets the batchId value for this SmsReport.
     * 
     * @param batchId
     */
    public void setBatchId(java.lang.String batchId) {
        this.batchId = batchId;
    }


    /**
     * Gets the destAddr value for this SmsReport.
     * 
     * @return destAddr
     */
    public java.lang.String getDestAddr() {
        return destAddr;
    }


    /**
     * Sets the destAddr value for this SmsReport.
     * 
     * @param destAddr
     */
    public void setDestAddr(java.lang.String destAddr) {
        this.destAddr = destAddr;
    }


    /**
     * Gets the message value for this SmsReport.
     * 
     * @return message
     */
    public com.touch.sysif.sms.api.model.SubSmsMessage[] getMessage() {
        return message;
    }


    /**
     * Sets the message value for this SmsReport.
     * 
     * @param message
     */
    public void setMessage(com.touch.sysif.sms.api.model.SubSmsMessage[] message) {
        this.message = message;
    }


    /**
     * Gets the receivedTime value for this SmsReport.
     * 
     * @return receivedTime
     */
    public java.util.Date getReceivedTime() {
        return receivedTime;
    }


    /**
     * Sets the receivedTime value for this SmsReport.
     * 
     * @param receivedTime
     */
    public void setReceivedTime(java.util.Date receivedTime) {
        this.receivedTime = receivedTime;
    }


    /**
     * Gets the sourceAddr value for this SmsReport.
     * 
     * @return sourceAddr
     */
    public java.lang.String getSourceAddr() {
        return sourceAddr;
    }


    /**
     * Sets the sourceAddr value for this SmsReport.
     * 
     * @param sourceAddr
     */
    public void setSourceAddr(java.lang.String sourceAddr) {
        this.sourceAddr = sourceAddr;
    }


    /**
     * Gets the statusCode value for this SmsReport.
     * 
     * @return statusCode
     */
    public int getStatusCode() {
        return statusCode;
    }


    /**
     * Sets the statusCode value for this SmsReport.
     * 
     * @param statusCode
     */
    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }


    /**
     * Gets the statusText value for this SmsReport.
     * 
     * @return statusText
     */
    public java.lang.String getStatusText() {
        return statusText;
    }


    /**
     * Sets the statusText value for this SmsReport.
     * 
     * @param statusText
     */
    public void setStatusText(java.lang.String statusText) {
        this.statusText = statusText;
    }

    
    
    @Override
	public String toString() {
		return "SmsReport [batchId=" + batchId + ", destAddr=" + destAddr
				+ ", message=" + Arrays.toString(message) + ", receivedTime="
				+ receivedTime + ", sourceAddr=" + sourceAddr + ", statusCode="
				+ statusCode + ", statusText=" + statusText + "]";
	}


}
