package com.youlu.api.config;

import java.util.HashMap;
import java.util.Map;

public class EnvParameters {
//    public static final String BOSE_HOST = "http://192.168.11.206:8081/apiservice";
    public static String getHostEnv(){
        return System.getenv("API_HOST");
    }

    public static String getDBEnv(){
        return System.getenv("DB_HOST");
    }

    // 缓存 json assert
    public static Map<String,Object> mongoCache = new HashMap<>();

    /**
     * 环境编码
     * @return
     */
    public static String getEnvCode() {
        return System.getenv("ENV_CODE");
    }
}
