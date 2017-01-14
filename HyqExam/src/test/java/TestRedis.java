import java.util.ArrayList;
import java.util.List;

import com.hyq.domain.Dict;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TestRedis {
    public static void main(String[] args) {
        List<Dict> dicts = new ArrayList<>();
        Dict d1 = new Dict();
        d1.setId("1");
        d1.setName("name1");
        d1.setType("type1");
        d1.setValue("value1");
        
        Dict d2 = new Dict();
        d2.setId("2");
        d2.setName("name2");
        d2.setType("type2");
        d2.setValue("value2");
        dicts.add(d2);
        
//        JSONObject object = JSONObject.fromObject(dicts);
        JSONArray object = JSONArray.fromObject(dicts);
        System.out.println(object);
        
        List<Dict> dds = new ArrayList<>();
//        dds = JSONArray.toList(jsonArray);
    }

}
