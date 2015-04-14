package com.saitu.dao.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.saitu.dao.RecordDao;
import com.saitu.model.Record;
import com.saitu.model.Route;
import com.saitu.util.GetNewDate;
import com.saitu.util.PageModel;

@Component("recordDao")
public class RecordDaoImpl extends BaseDaoImpl<Record> implements RecordDao {
	/**
	 * 查询所有记录
	 */
	@Override
	public PageModel getBy1(int p, String where, Object[] queryParams) {
		return getPageModel(p, where, queryParams);
	}

	@Override
	public PageModel getByID(int p, int id) {
		String where="select r from Record r inner join  r.routes o where o.id= ?";
		String hql="select count(*) from Record r inner join  r.routes o where o.id= ?";
		return getPageModels(p, where,hql, new Object[]{id});
	}
/*
	/**
	 * 查询所有公告
	 */
	@Override
	public PageModel getAll(int p) {
		String where = " r order by r.updateDate ";
		return getPageModel(p, where, null);
	}

	/**
	 * 公告
	 */
	@Override
	public PageModel getBy0(int p, String where, Object[] queryParams) {
		return getPageModel(p, where, queryParams);
	}


	// 得到最近的更新记录
	@Override
	public Record getNewReoced(int id) {
		List l = getList("select r from Record r inner join r.routes o  where o.id = ? order by r.id desc",
				new Object[] { id });
		if (l.size() > 0) {
			return (Record) l.get(0);
		}
		System.out.println("null");
		return null;
	}

	// 今日任务，周末显示到周五
	@Override
	public PageModel getToday(int p) {
		String where = "r where (r.b=0 or r.comment != '') and r.updateDate <= ?";
		return getPageModel(p, where,
				new Object[] { GetNewDate.getYMDtoFriday()});
	}

	// 自动更新到期绕道的路线记录为公告
	@Override
	public void updateRecord() {
		getHibernateTemplate().execute(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query;
				query = session
						.createQuery("from Route r where r.overDate <= ?");
				query.setParameter(0, GetNewDate.getYMD(new Date()));
				List<Route> l = query.list();
				System.out.println("---------查询完list------------");
				for (Route r : l) {
					System.out.println(r.getName() + "id" + r.getId());
					System.out.println("---------得到ID------------");
					Record re = getNewReoced(r.getId());
					if(re!=null){
						re.setComment("临时绕道结束:" + r.getOverDate());
						r.setOverDate(null);
						System.out.println("---------临时绕道结束------------");
						update(re);
					}
				}
				return null;
			}
		});
	}

	@Override
	public PageModel getByDate(int p, String where, Object[] queryParams) {
		return getPageModel(p, where, queryParams);
	}
}
