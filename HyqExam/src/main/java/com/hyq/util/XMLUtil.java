package com.hyq.util;

import java.io.InputStream;
import java.util.HashSet;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XMLUtil {

	public static Set<String> getPublicUrlNodeList(InputStream in) throws Exception {
		
			Set<String> sets =new HashSet<String>();
			//创建工厂
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				Document doc = builder.parse(in);
				 Element rootElement = doc.getDocumentElement();
				 NodeList nodeList = rootElement.getElementsByTagName("node");
				 for(int i=0;nodeList!=null && i<nodeList.getLength();i++)
				 {
					 Node node = nodeList.item(i);
					 String value = node.getTextContent();
					 sets.add(value);
				 }
				 return sets;
		
	}

}
