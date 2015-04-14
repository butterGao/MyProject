package com.saitu.dao.impl;

import org.springframework.stereotype.Component;

import com.saitu.dao.DisplayDao;
import com.saitu.model.Display;

@Component("displayDao")
public class DisplayDaoImpl extends BaseDaoImpl<Display> implements DisplayDao{
}
