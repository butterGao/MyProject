package com.saitu.action;

import com.opensymphony.xwork2.ActionSupport;

public class ImageAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private String image;
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String show(){
		System.out.println(image);
		return SUCCESS;
	}
}
