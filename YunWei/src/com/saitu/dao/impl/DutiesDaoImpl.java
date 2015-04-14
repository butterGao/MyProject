package com.saitu.dao.impl;

import org.springframework.stereotype.Component;

import com.saitu.dao.DutiesDao;
import com.saitu.model.Duties;

@Component("dutiesDao")
public class DutiesDaoImpl extends BaseDaoImpl<Duties> implements DutiesDao{
}
