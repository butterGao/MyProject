package net.loyin.jFinal.plugin.sqlXml;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlValue;

@XmlRootElement
class SqlItem {
	@XmlAttribute
	String id;
	@XmlValue
	String value;
}