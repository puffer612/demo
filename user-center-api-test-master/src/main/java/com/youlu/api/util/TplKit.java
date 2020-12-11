package com.youlu.api.util;

import org.yaml.snakeyaml.Yaml;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TplKit {

    private static final Pattern p = Pattern.compile("\\$\\{(.+?)\\}");

    public static String parse(String content, Map<String,Object> kvs){
        Matcher m = p.matcher(content);
        StringBuffer sr = new StringBuffer();
        while(m.find()){
            String group = m.group();
            group = group.replaceAll("\\$", "").replaceAll("\\{", "").replaceAll("\\}", "");
            Object o = kvs.get(group);
            if(o != null) {
                if (o instanceof String || o instanceof Long) {
                    m.appendReplacement(sr, "\"" + kvs.get(group).toString() + "\"");
                } else {
                    // YAML 处理
                    Yaml yaml = new Yaml();
                    String dumpData = yaml.dump(kvs.get(group));
                    m.appendReplacement(sr, dumpData);
                }
            }
        }
        m.appendTail(sr);
        return sr.toString();
    }
}
