package com.saitu.dao.impl;

import org.springframework.stereotype.Component;
import com.saitu.dao.LogincountDao;
import com.saitu.model.LoginCount;

@Component("logincountDao")
public class LogincountDaoImpl extends BaseDaoImpl<LoginCount> implements LogincountDao{
}
