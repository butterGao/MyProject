package com.saitu.action;

import com.saitu.dao.DisplayDao;
import com.saitu.model.Display;
import com.saitu.model.Entry;
import com.saitu.util.PageModel;

public class ShowAction extends BaseAction {
	private PageModel one;
	private PageModel two;
	private PageModel three;
	private PageModel four;
	private PageModel five;
	private PageModel six;
	private Entry first;
	private Entry second;
	private Entry third;
	private Entry fourth;
	private Entry fifth;
	private Entry sixth;
	private PageModel chengguo;
	private int p;
	private int id;
	
	public String ss(){
		first=entryDao.get(id);
		return SUCCESS;
	}
	public String showlist(){
		System.out.println(id);
		if(id==14||id==15){
			if(session.get("users")==null){
				p=9999999;
			}else{
				one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{id});
			}
			
		}else{
			one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{id});
		}
		
		
		return SUCCESS;
	}
	public String chenguo(){
		one=entryDao.find(p, " e where e.chenguo = ? ", new Object[]{id});
		return SUCCESS;
	}
	public String display(){
		/*one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{31});
		two=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{32});
		three=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{33});
		four=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{34});
		five=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{35});
		six=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{36});*/
//		first=entryDao.getN(31);
//		second=entryDao.getN(32);
//		third=entryDao.getN(33);
//		fourth=entryDao.getN(34);
//		fifth=entryDao.getN(35);
//		sixth=entryDao.getN(36);
		return SUCCESS;
	}
	public String policy(){
		/*one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{11});
		two=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{12});
		three=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{13});
		four=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{14});
		five=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{15});*/
		first=entryDao.get(3);
//		second=entryDao.getN(12);
//		third=entryDao.getN(13);
//		fourth=entryDao.getN(14);
//		fifth=entryDao.getN(15);
		return SUCCESS;
	}
	public String work(){
		/*one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{21});
		two=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{22});
		three=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{23});
		four=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{24});*/
//		first=entryDao.getN(21);
//		second=entryDao.getN(22);
//		third=entryDao.getN(23);
//		fourth=entryDao.getN(24);
		return SUCCESS;
	}
	public  String opinion(){
//		first=entryDao.getN(41);
//		second=entryDao.getN(42); 
//		third=entryDao.getN(43);
		/*one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{41});
		two=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{42});
		three=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{43});*/
		return SUCCESS;
	}
	public String experience(){
		one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{37});
		return SUCCESS;
	}
	public String repair(){
	/*	one=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{51});
		two=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{52});
		three=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{53});
		four=entryDao.find(p, " e where e.categoryid = ? ", new Object[]{54});*/
		return SUCCESS;
	}
	public PageModel getOne() {
		return one;
	}
	public void setOne(PageModel one) {
		this.one = one;
	}
	public PageModel getTwo() {
		return two;
	}
	public void setTwo(PageModel two) {
		this.two = two;
	}
	public PageModel getThree() {
		return three;
	}
	public void setThree(PageModel three) {
		this.three = three;
	}
	public PageModel getFour() {
		return four;
	}
	public void setFour(PageModel four) {
		this.four = four;
	}
	public PageModel getFive() {
		return five;
	}
	public void setFive(PageModel five) {
		this.five = five;
	}
	public PageModel getSix() {
		return six;
	}
	public void setSix(PageModel six) {
		this.six = six;
	}
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
	}
	public Entry getFirst() {
		return first;
	}
	public void setFirst(Entry first) {
		this.first = first;
	}
	public Entry getSecond() {
		return second;
	}
	public void setSecond(Entry second) {
		this.second = second;
	}
	public Entry getThird() {
		return third;
	}
	public void setThird(Entry third) {
		this.third = third;
	}
	public Entry getFourth() {
		return fourth;
	}
	public void setFourth(Entry fourth) {
		this.fourth = fourth;
	}
	public Entry getFifth() {
		return fifth;
	}
	public void setFifth(Entry fifth) {
		this.fifth = fifth;
	}
	public Entry getSixth() {
		return sixth;
	}
	public void setSixth(Entry sixth) {
		this.sixth = sixth;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public PageModel getChengguo() {
		return chengguo;
	}
	
}
