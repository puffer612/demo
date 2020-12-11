package com.youlu.api.util;

import com.youlu.api.config.EnvParameters;
import io.restassured.response.Response;

import java.util.Map;

import static io.restassured.RestAssured.given;

public class ApiKit {

    public static Response get(String apiPath,
                               Map<String, Object> cookies,
                               Map<String, Object> headers,
                               Map<String, Object> params) {
        //验证 API HOST
        if (!apiPath.startsWith("http") || !apiPath.startsWith("https")) {
            // 通过环境变量注入
            apiPath = EnvParameters.getHostEnv() + apiPath;
        }

        // 验证 环境编码
        if(EnvParameters.getEnvCode() != null) {
            headers.put("env",EnvParameters.getEnvCode());
        }
        Response response = given().contentType("application/json;charset=UTF-8")
                .param("params",params)
                .headers(headers)
                .cookies(cookies)
                .when().log().all().get(apiPath.trim());

        response.getBody().prettyPrint();
        return response;
    }

    /**
     * 获取json中某个key值
     *
     * @param response 接口返回
     * @param jsonPath jsonpath, 例如 a.b.c   a.b[1].c  a
     * @return
     */
    public static String getJsonPathValue(Response response, String jsonPath) {
        Object o = response.jsonPath().get(jsonPath);
        String responseJson = String.valueOf(o);
        return responseJson;
    }

    public static Object getJsonPathObj(Response response, String jsonPath) {
        Object o = response.jsonPath().get(jsonPath);
        return o;
    }


}
