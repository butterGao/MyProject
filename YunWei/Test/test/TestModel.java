package test;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.tool.hbm2ddl.SchemaExport;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import sun.awt.windows.WDataTransferer;
import com.saitu.action.CpolicyAction;
import com.saitu.action.IndexAction;
import com.saitu.dao.BaseDao;
import com.saitu.dao.CategoryDao;
import com.saitu.dao.CpolicyDao;
import com.saitu.dao.DisplayDao;
import com.saitu.dao.EntryDao;
import com.saitu.dao.IndexsDao;
import com.saitu.dao.LinkDao;
import com.saitu.dao.UsersDao;
import com.saitu.dao.WorkingDao;
import com.saitu.dao.impl.IndexsDaoImpl;
import com.saitu.model.Display;
import com.saitu.model.Entry;
import com.saitu.model.Link;
import com.saitu.model.Working;
import com.saitu.util.PageModel;

public class TestModel {
	static ClassPathXmlApplicationContext c = new ClassPathXmlApplicationContext(
			"beans.xml");
	static HibernateTemplate h = (HibernateTemplate) c
			.getBean("hibernateTemplate");
	static WorkingDao wd = (WorkingDao) c.getBean("workingDao");
	static IndexAction i = (IndexAction) c.getBean("indexAction");
	static DisplayDao d = (DisplayDao) c.getBean("displayDao");
	static EntryDao ee = (EntryDao) c.getBean("entryDao");
	static IndexsDao indexsDao = (IndexsDao) c.getBean("indexsDao");
	static UsersDao usersDao = (UsersDao) c.getBean("UsersDao");

	@Test
	public void ss() {
		System.out.println(2 * 1024 * 1024 * 10);
	}

	@Test
	public void testNow() {
		IndexAction i = new IndexAction();
		i.init();

	}

	@Test
	public void addEntry() {
		for (int i = 51; i <= 54; i++) {
			Entry s = new Entry();
			s.setTitle("意见反馈");
			s.setCategoryid(i);
			s.setContent("展望虹口教育新一轮的运维服务工作，我们将努力探索后勤化管理社会化的新模式，创新学校设备运维服务管理的新理念，提升运维服务信息化管理平台的新功能，引进专业技术能力更强、服务更高效的优秀专业技术团队，更好地、更快速地、更有效地提供设备专业技术保障，成为虹口教育特色发展和学校教育教学改革发展的坚强后盾。  ");
			s.setCreatTime(new Date());
			s.setPath("/YunWei/upload/image/20131230//20131230095416_729.jpg");
		}
	}

	public static void main(String[] args) {
		usersDao.uniqueResult("from Users u where u.user=? and u.pass=?", new Object[]{1,2});
	}
}
