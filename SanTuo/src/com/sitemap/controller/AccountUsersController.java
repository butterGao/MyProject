package com.sitemap.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import net.loyin.jFinal.anatation.RouteBind;
import org.apache.commons.lang.StringUtils;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.model.Result;
import com.sitemap.util.TimeUtil;
/**
*用户管理
*/
@RouteBind(path="/au")
@Before(LoginInterceptor.class)
public class AccountUsersController extends BaseController {
	public AccountUsersController(){
		this.tableName=st_userInfor;
	}
	/**
	 *初始化角色，项目
	 */
	public void index(){
		if(getCid()==0){
			setAttr("project",Db.find("select * from st_project "));
			setAttr("role",Db.find("select * from st_role "));
		}else {
			setAttr("project",Db.find("select * from st_project where cid=?",getCid()));
			setAttr("role",Db.find("select * from st_role where cid=? and type ! =4",getCid()));
		}
		render("/account_manager.jsp");
	}
	
	
	public void show() {
		Page<Record>p;
		if(getCid()==0){
			p=Db.paginate(getParaToInt("page"), getParaToInt("rows"), "select *", "from " + tableName+" where id != 1 order by id desc");

		}else{
			p=Db.paginate(getParaToInt("page"), getParaToInt("rows"), "select *", "from " + tableName+" where pid in(select id from st_project where cid =?) order by id desc",getCid());

		}
		for(Record r:p.getList()){
			try {
				r.set("CREATETIME",r.get("CREATETIME").toString().substring(0,19));
			} catch (Exception e) {
			}
			try {
				r.set("STARTTIME",r.get("STARTTIME").toString().substring(0,19));
				r.set("ENDTIME",r.get("ENDTIME").toString().substring(0,19));
			} catch (Exception e) {
			}
		}
		renderJson(p);
	}
	
	/**
	 *随机添加小蜜蜂
	 */
	public void addAccount(){
		try {
			Integer xmf=Db.queryBigDecimal("select xmfnumber from st_company where id =? ",getCid()).intValue();
			Integer count=Db.queryBigDecimal("select count(1) from st_userinfor where rid in(select id from st_role where cid=?) ",getCid()).intValue();
			System.out.println(xmf);
			System.out.println(count);
			System.out.println(getParaToInt("number"));
			if(xmf-count<getParaToInt("number")){
				renderJson(new Result("超过可创建账号上限"));
			}else{
				for(int i=0;i<getParaToInt("number");i++){
					Integer id=Db.findFirst("select userSequ.nextval as id from DUAL").getBigDecimal("id").intValue();
					Integer rid=Db.queryBigDecimal("select id from st_role where cid=? and type=1",getCid()).intValue();
					Db.save(tableName, new Record().set("id", id).set("lname", "100"+id).set("pwd","100"+id)
							.set("uname", "小蜜蜂0"+id)
							.set("createtime", TimeUtil.getNewDate())
							.set("rid",rid).set("gid", getPara("gid")).set("pid", getPara("pid")));
					renderJson(new Result(true));
				}
			}
		} catch (Exception e) {
			renderJson(new Result("出现异常"));
			e.printStackTrace();
		}
	}
	/**
	 *更新管理员账号
	 */
	public void updateManger(){
				renderJson(Db.update(st_userInfor, Db.findFirst("select * from st_userinfor where rid in"
						+ "(select id from st_role where cid=? and type = 4)",getCid()).set("pwd", getPara("pwd"))));

	}
	/**
	 *添加管理员
	 */
	public void addManger(){
		Integer rid=Db.queryBigDecimal("select id from st_role where cid=? and type = 4",getPara("cid")).intValue();
		Record u=getRecord().remove("cid").set("createtime",TimeUtil.getNewDate())
										.set("id", "userSequ.nextval").set("rid", rid);
		//查询公司管理员是否存在
		if(Db.queryBigDecimal("select count(1) from st_userinfor where rid in"
				+ "(select id from st_role where cid=? and type=4)",getPara("cid")).intValue()>0){
			renderJson(false);
		}else{
			renderJson(Db.save(tableName, u));
		}

	}
   
	/**
	 *判断账号是否存在
	 */
	public void isExist(){
			if(Db.queryBigDecimal("select count(1) from st_userinfor where lname =? ",getPara("lname")).intValue()>0){
				renderJson(true);
			}else{
				renderJson(false);
			}
	}
	//用户名重复
	public void isExistU(){
		if(Db.queryBigDecimal("select count(1) from st_userinfor where uname =? ",getPara("uname")).intValue()>0){
			renderJson(true);
		}else{
			renderJson(false);
		}
}
	//是否超过可创建账号数量
	public void isSurPassAccount()
	{
		Integer xmf=Db.queryBigDecimal("select xmfnumber from st_company where id =? ",getCid()).intValue();
		Integer count=Db.queryBigDecimal("select count(1) from st_userinfor where rid in(select id from st_role where cid=?) ",getCid()).intValue();
		System.out.println("Running  -------------- isSurPassAccount(): "+xmf+","+count);
		if(xmf>=count){
			renderJson(true);
		}else{
			renderJson(false);
		}
	}	
	/**
	 * 查询组
	 */
	public void zhu() {
		if(StringUtils.isEmpty(getPara("pid"))){
			renderJson(Db.find("select * from " + st_group));
		}else{
			renderJson(Db.find("select * from st_group where pid= ?",getPara("pid")));
		}
		
	}

	/**
	 * 角色
	 */
	public void juese() {
		if(getCid()==0){
			renderJson(Db.find("select * from st_role"));
		}else{
			renderJson(Db.find("select * from st_role where cid= ? and type ! =4",getCid()));
		}
	}
	/**
	 * 添加组
	 */
	public void addGroup(){
		Integer id=Db.queryBigDecimal("select groupSequ.nextval from dual").intValue();
		Db.save(st_group,getRecord().set("id",id));
		renderJson(id);
	}
	public void delGroup(){
		Db.deleteById(st_group,getPara("gid"));
		Db.deleteById(st_userInfor, "gid", getPara("gid"));
		renderJson(true);
	}
	
	/**
	 * 查询公司
	 */
	public void queryCompany(){
		renderJson(Db.find("select id,name from st_company"));
	}
	/**
	 * 查询公司下的项目
	 */
	public void queryProject(){
		if(StringUtils.isNotEmpty(getPara("cid"))){
			renderJson(Db.find("select id,name from st_project where cid = ?",getPara("cid")));
		}else{
			if(getCid()==0){
				renderJson(Db.find("select id,name from st_project"));
			}else{
				renderJson(Db.find("select id,name from st_project where cid = ?",getCid()));
			}
		}
		
	}
	/**
	 * 查询项目下的组
	 */
	public void queryGroup(){
		renderJson(Db.find("select id,name from st_group where pid=?",getPara("pid")));
	}
	public void queryUserForGroup(){
		List<Map<String, Object>> rs=new ArrayList<Map<String, Object>>();
		List<Record> groups=Db.find("select id,name from st_group where pid =? ",getPara("pid"));
		for(Record g:groups){
			Map<String, Object> gm = new HashMap<String, Object>();
			gm.put("group", g.getStr("name"));
			gm.put("user", Db.find("select * from st_userinfor where gid =?",g.get("id")));
			rs.add(gm);
		}
		renderJson(rs);
	}
	public void queryUserForTree(){
			renderJson(queryUserForProjectAndTree(getCid()));
	}
	
	/**
	 *根据项目查询用户 返回tree格式
	 */
	public List<Record> queryUserForProjectAndTree(Object id){
		List<Record> data=new LinkedList<Record>();
		List<Record> ps=Db.find("select id,name from st_project where cid = ?",id);
		for(Record p:ps){//遍历查询组
			List<Record> gs=Db.find("select id,name from st_group where pid=?",p.get("id"));
			p.set("id", p.get("id")+"pp").set("pid",0);
				for(Record g:gs){//遍历查询用户
					List<Record> us=Db.find("select id,uname as name from st_userinfor where gid=?",g.get("id"));
					g.set("id", g.get("id")+"gg").set("pid", p.get("id"));
					for(Record u:us){
						u.set("pid", g.get("id"));
					}
					data.addAll(us);
				}
				data.addAll(gs);
		}
		data.addAll(ps);
		return data;
	}
}
