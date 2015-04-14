/*****************************************
 *  所有版权(c) 上海塔齐通讯技术有限公司       *
 *****************************************/
package com.touch.sysif.sms.api.model;

/**
 * 子短信
 * 
 * @version $Revision: 1.0 $ 
 * @author yanxiao
 * @date: Jan 17, 2014
 * @time: 10:18:54 PM
 */
public class SubSmsMessage  implements java.io.Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = -2515421332629355998L;

	private java.lang.String batchId;

    private java.lang.String content;

    private java.lang.String destAddr;

    private java.lang.Short pkNumber;

    private java.lang.Short pkTotal;

    private java.lang.String sourceAddr;

    private int statusCode;

    public SubSmsMessage() {
    }

    public SubSmsMessage(
           java.lang.String batchId,
           java.lang.String content,
           java.lang.String destAddr,
           java.lang.Short pkNumber,
           java.lang.Short pkTotal,
           java.lang.String sourceAddr,
           int statusCode) {
           this.batchId = batchId;
           this.content = content;
           this.destAddr = destAddr;
           this.pkNumber = pkNumber;
           this.pkTotal = pkTotal;
           this.sourceAddr = sourceAddr;
           this.statusCode = statusCode;
    }


    /**
     * Gets the batchId value for this SubSmsMessage.
     * 
     * @return batchId
     */
    public java.lang.String getBatchId() {
        return batchId;
    }


    /**
     * Sets the batchId value for this SubSmsMessage.
     * 
     * @param batchId
     */
    public void setBatchId(java.lang.String batchId) {
        this.batchId = batchId;
    }


    /**
     * Gets the content value for this SubSmsMessage.
     * 
     * @return content
     */
    public java.lang.String getContent() {
        return content;
    }


    /**
     * Sets the content value for this SubSmsMessage.
     * 
     * @param content
     */
    public void setContent(java.lang.String content) {
        this.content = content;
    }


    /**
     * Gets the destAddr value for this SubSmsMessage.
     * 
     * @return destAddr
     */
    public java.lang.String getDestAddr() {
        return destAddr;
    }


    /**
     * Sets the destAddr value for this SubSmsMessage.
     * 
     * @param destAddr
     */
    public void setDestAddr(java.lang.String destAddr) {
        this.destAddr = destAddr;
    }


    /**
     * Gets the pkNumber value for this SubSmsMessage.
     * 
     * @return pkNumber
     */
    public java.lang.Short getPkNumber() {
        return pkNumber;
    }


    /**
     * Sets the pkNumber value for this SubSmsMessage.
     * 
     * @param pkNumber
     */
    public void setPkNumber(java.lang.Short pkNumber) {
        this.pkNumber = pkNumber;
    }


    /**
     * Gets the pkTotal value for this SubSmsMessage.
     * 
     * @return pkTotal
     */
    public java.lang.Short getPkTotal() {
        return pkTotal;
    }


    /**
     * Sets the pkTotal value for this SubSmsMessage.
     * 
     * @param pkTotal
     */
    public void setPkTotal(java.lang.Short pkTotal) {
        this.pkTotal = pkTotal;
    }


    /**
     * Gets the sourceAddr value for this SubSmsMessage.
     * 
     * @return sourceAddr
     */
    public java.lang.String getSourceAddr() {
        return sourceAddr;
    }


    /**
     * Sets the sourceAddr value for this SubSmsMessage.
     * 
     * @param sourceAddr
     */
    public void setSourceAddr(java.lang.String sourceAddr) {
        this.sourceAddr = sourceAddr;
    }


    /**
     * Gets the statusCode value for this SubSmsMessage.
     * 
     * @return statusCode
     */
    public int getStatusCode() {
        return statusCode;
    }


    /**
     * Sets the statusCode value for this SubSmsMessage.
     * 
     * @param statusCode
     */
    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    @Override
	public String toString() {
		return "SubSmsMessage [batchId=" + batchId + ", content=" + content
				+ ", destAddr=" + destAddr + ", pkNumber=" + pkNumber
				+ ", pkTotal=" + pkTotal + ", sourceAddr=" + sourceAddr
				+ ", statusCode=" + statusCode + "]";
	}

}
