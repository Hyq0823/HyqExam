import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Date;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class Test {

	public static void main(String[] args) throws Exception {
		String weixin_userInfo = "{\"openid\":\" OPENID\",\" nickname\":\"NICKNAME\",\"sex\":\"1\",\"province\":\"PROVINCE\",\"city\":\"CITY\",\"country\":\"COUNTRY\",\"headimgurl\":\"ddd\",\"privilege\":[\"PRIVILEGE1\",\"PRIVILEGE2\"],\"unionid\":\"o6_bmasdasdsad6_2sgVt7hMZOPfL\"}";
		JSONObject data = JSONObject.fromObject(weixin_userInfo);
		
		JSONObject d = new JSONObject();
		d.put("name", "hyq");
		d.put("age", 23);
		d.put("Marryed", true);
		d.put("birth", "1994-08-23 17:20:33");
		  JSONObject info = new JSONObject();
		  info.put("info1", "info1");
		  info.put("info2", "info2");
		  	JSONObject family = new JSONObject();
		  	family.put("part1", "part1");
		  	family.put("part2", "part2");
		  	info.put("family",family);
		  	
		    JSONObject info2 = new JSONObject();
			  info2.put("info1", "info11");
			  info2.put("info2", "info22");
			  	JSONObject family2 = new JSONObject();
			  	family2.put("part1", "part11");
			  	family2.put("part2", "part22");
			  	info2.put("family",family2);
		  	
		  	JSONArray array = new JSONArray();
		  	array.add(info);
		  	array.add(info2);
		  	
		d.put("list", array);
		d.put("name", "hyq");
		
//		System.out.println(d);
//		User u =JsonUtils.json2Bean(d,User.class);
		User u = (User) JSONObject.toBean(d, User.class);
		System.out.println(u.toString());
		
//		System.out.println(d);
	}
	

	

	

}
