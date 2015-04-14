package com.saitu.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.apache.struts2.ServletActionContext;

public class FileUpload {
	public static Random random = new Random();

	/**
	 * 获取当前时间字符串
	 */
	public static String getStringTime() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		return sdf.format(date);//
	}

	public static String upLoad(File file, String name) throws Exception {
		if (file != null) {
			String path = ServletActionContext.getServletContext().getRealPath(
					"/upload");
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdir();
			}
			FileInputStream fis = null;
			FileOutputStream fos = null;
			try {
				fis = new FileInputStream(file);
				fos = new FileOutputStream(new File(dir, name));
				byte[] bs = new byte[1024 * 4];
				int len = -1;
				while ((len = fis.read(bs)) != -1) {
					fos.write(bs, 0, len);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				fos.flush();
				fos.close();
				fis.close();
			}
		}
		return name;
	}

	/**
	 * 上传文件
	 * 
	 * @return
	 */
	public static String upLoad(File file) throws Exception {
		System.out.println(file.getPath());
		String fileName = getStringTime() + ".jpg";
		if (file != null) {

			String path = ServletActionContext.getServletContext().getRealPath(
					"/upload");
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdir();
			}
			FileInputStream fis = null;
			FileOutputStream fos = null;
			try {
				fis = new FileInputStream(file);
				fos = new FileOutputStream(new File(dir, fileName));
				byte[] bs = new byte[1024 * 4];
				int len = -1;
				while ((len = fis.read(bs)) != -1) {
					fos.write(bs, 0, len);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				fos.flush();
				fos.close();
				fis.close();
			}
		}
		return fileName;
	}

}
