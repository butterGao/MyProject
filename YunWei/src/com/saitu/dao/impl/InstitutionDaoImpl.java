package com.saitu.dao.impl;

import org.springframework.stereotype.Component;

import com.saitu.dao.InstitutionDao;
import com.saitu.model.Institution;

@Component("institutionDao")
public class InstitutionDaoImpl extends BaseDaoImpl<Institution> implements InstitutionDao{
}
