package com.mifTest;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.saitu.model.Stt;

/**
 * 调整路线方向
 */
public class MifMeoth {
	static ClassPathXmlApplicationContext c = new ClassPathXmlApplicationContext(
			"beans.xml");
	static HibernateTemplate h = (HibernateTemplate) c
			.getBean("hibernateTemplate");
	StringBuffer sb = new StringBuffer();// 储存排序的坐标点
	StringBuffer error = new StringBuffer();// 站点50米附近没有路线的错误信息
	static String tr = "\r\n";
	private BufferedReader mif;
	private BufferedReader mid;
	private BufferedWriter bw;
	int index = 0;
	static String pline = "Pline ";
	static String pen = "    Pen (40,2,255) ";
	int count = 0;

	/**
	 * 主要方法 读取路线MIF,MID，把排序后的MIF写入mifPath
	 */
	public void redLineAndPoint(String mifs, String mids, String mifPath)
			throws Exception {
		mif = new BufferedReader(new InputStreamReader(
				new FileInputStream(mifs)));
		mid = new BufferedReader(new InputStreamReader(
				new FileInputStream(mids)));
		bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(
				new File(mifPath))));
		String id = "";
		String poi = "";
		String line = "";
		String sttp = "";// 站点坐标
		boolean b = false;
		StringBuffer sbp = new StringBuffer();// 临时存放所有的坐标点
		List<String> pois = new ArrayList<String>();
		List<Stt> stts;
		// 开始读取mid
		while (true) {
			count++;
			if(count%100==0)System.out.println(count);
			line = mid.readLine();
			if (line == null) {
				break;
			}
			id = line.split(",", 3)[0].replaceAll("\"", "");
			// -----------------坐标点循环，MIF存在片段SBP中-----
			while (true) {
				poi = mif.readLine();
				if (poi == null) {
					break;
				}
				if ((poi.trim().substring(0, 5)).equals("Pline")) {
					sbp.append("a");
					continue;
				}
				if ((poi.trim().subSequence(0, 3)).equals("Pen")) {
					break;
				}
				sbp.append(poi).append(tr);
				pois.add(poi);
			}// ----------------坐标点循环结束------------------
			if (judge(pois)) {// 非环线方法
				// System.out.print(id + " 非环线");
				// System.out.println(line);
				try {
					sttp = (String) findPoi(id).get(0);
				} catch (Exception e) {
					System.out.println(line);
					e.printStackTrace();
				}
				if (MathPoint.sumRange(pois.get(0), sttp) < MathPoint.sumRange(
						pois.get(pois.size() - 1), sttp)) {// 顺序正确
					// System.out.println("   顺序正确");
					sbp.replace(0, 1, "Pline " + pois.size() + tr);
					sb.append(sbp).append(pen).append(tr);
					sbp.setLength(0);
				} else {// 顺序错误
					// System.out.println("   顺序错误");
					sort(pois);// 排序并储存sb
					sbp.setLength(0);
				}
			} else {// 环线方法
				 System.out.println(id);
				sttp = (String) findPoi(id).get(1);
				if (hxRight(pois, sttp)) {// 方向正确
					//System.out.println("dui");
					sbp.replace(0, 1, "Pline " + pois.size() + tr);
					sb.append(sbp).append(pen).append(tr);
					sbp.setLength(0);
				} else {// 方向反
					//System.out.println("错");
					sort(pois);
					//System.out.println(sb);
					sbp.setLength(0);
				}
			}
			bw.write(sb.toString());
			sb.setLength(0);
			pois.clear();
		}// ---------循环结束--------------
		bw.flush();
	}

	public boolean hxRight(List<String> l, String s) {
		index = l.size();
		int max = 0;
		for (int i = 1; i < index; i++) {
			if (MathPoint.sumRange(l.get(i), s) < MathPoint.sumRange(
					l.get(max), s)) {
				max = i;
			}
		}
		if (max < index / 4) {
			return true;
		}
		return false;
	}

	// 判断是否为环线,是环线返回false
	public boolean judge(List<String> l) {
		if (MathPoint.jude(l.get(0), l.get(l.size() - 1))) {
			return false;
		}
		return true;
	}

	// 倒序并存在sb中
	public void sort(List<String> l) {
		index = l.size();
		sb.append(pline).append(index).append(tr);
		for (int i = index - 1; i >= 0; i--) {
			sb.append(l.get(i)).append(tr);
		}
		sb.append(pen).append(tr);
	}

	public List findPoi(final String id) {
		return (List) h.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query q = session
						.createQuery("select s.poi from Stt s where s.line = ? order by s.order");
				q.setParameter(0, id);
				q.setMaxResults(2);
				q.setFirstResult(0);
				return q.list();
			}
		});
	}
	
//	public List hql(final String s, final String w) {
//		return (List) h.execute(new HibernateCallback() {
//			@Override
//			public Object doInHibernate(Session session)
//					throws HibernateException, SQLException {
//				Query q = session.createQuery(s);
//				q.setParameter(0, w);
//				return q.list();
//			}
//		});
//	}

}
