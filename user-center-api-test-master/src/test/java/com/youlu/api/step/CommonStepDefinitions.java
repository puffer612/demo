package com.youlu.api.step;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.youlu.api.config.EnvParameters;
import com.youlu.api.model.db.InitDb;
import com.youlu.api.model.db.InitTable;
import com.youlu.api.util.ApiKit;
import com.youlu.api.util.DbKit;
import com.youlu.api.util.TplKit;
import com.zaxxer.hikari.HikariDataSource;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.lang3.StringUtils;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class CommonStepDefinitions {

    private String api;
    private Response response;
    private Map<String,Object> params = new HashMap<>();
    private Map<String,Object> cookies = new HashMap<>();
    private Map<String,Object> headers = new HashMap<>();

    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 提供 API
     * @param api
     */
    @Given("^API \"(.*?)\"$")
    public void api(String api){
        this.api = api;
    }

    /**
     * 初始化数据
     */
    @Given("INI_VAR_DATA")
    public void iniVarData(String yamlContent) {
        Yaml yaml = new Yaml();
        Map ret = (Map) yaml.load(yamlContent);
        for (Object key : ret.keySet()) {
            EnvParameters.mongoCache.put(key.toString(),ret.get(key));
        }
    }

    /**
     * 初始化 MYSQL 数据
     */
    @Given("INIT_MYSQL_DATA")
    public void initMysqlData(String yamlContent){
        if(StringUtils.isEmpty(EnvParameters.getEnvCode())) {
            return;
        }
        Yaml yaml = new Yaml(new Constructor(InitDb.class));
        InitDb ret = (InitDb) yaml.load(yamlContent);
        // 链接数据库
        StringBuilder jdbcUrl = new StringBuilder("jdbc:mysql://")
                .append(EnvParameters.getDBEnv())
                .append("/")
                .append(ret.getDbName());
        HikariDataSource dataSource = DbKit.ds(jdbcUrl.toString());
        // checkTableDefine
        for (InitTable table : ret.getTables()) {
            try {
                DbKit.copyTableDefine(dataSource, table.getName(), table.getName() + "_" + EnvParameters.getEnvCode());
            } catch (SQLException exception) {
                exception.printStackTrace();
            }
        }
        // checkTableData
    }

    /**
     * 处理 yaml 格式的参数
     * @param yamlContent
     */
    @Given("Param")
    public void paramsYaml(String yamlContent) {
        // 替换变量
        String parsedYaml = TplKit.parse(yamlContent, EnvParameters.mongoCache);
        Yaml yaml = new Yaml();
        Map ret = (Map) yaml.load(parsedYaml);
        this.params = ret;
    }


    @Given("CookieX")
    public void CookieX(Map<String,Object> paramsTmp) {
        Map<String,Object> tmp = new HashMap<>();
        paramsTmp.forEach((key,value) -> {
            // 验证是否包含函数表达式
            String valueTmp = value.toString();
            if (value.toString().contains("${")){
                String keyVal = valueTmp.substring(2, valueTmp.length() - 1);
                tmp.put(key, EnvParameters.mongoCache.get(keyVal));
            }else {
                tmp.put(key, value);
            }
        });
        this.cookies = tmp;
    }

    /**
     * 发起请求
     */
    @When("GET")
    public void get(){
        this.response = ApiKit.get(api,cookies,headers,params);
    }

    /**
     * 断言状态码
     */
    @Then("^STATUS \"(.*?)\"$")
    public void status(int status){
        assertEquals(this.response.statusCode(),status);
    }

    /**
     * JSON 断言
     * @param jsonPath jsonpath
     * @param value 断言值
     */
    @Then("^JSONPATH_ASSERT \"(.*?)\" equals \"(.*?)\"$")
    public void jsonPathAssert(String jsonPath,String value){
        String apiResp = ApiKit.getJsonPathValue(this.response, jsonPath);
        assertEquals(apiResp,value);
    }

//    /**
//     * DB 断言
//     * @param paramsTmp  key: 表名+列表  value : 列期望值
//     */
//    @Then("DB_ASSERT_X")
//    public void dbAssertX(Map<String,Object> paramsTmp){
//        StringBuilder jdbcUrl = new StringBuilder("jdbc:mysql://")
//                .append(EnvParameters.getDBEnv())
//                .append(ret.getDbName());
//        HikariDataSource dataSource = DbKit.ds(jdbcUrl.toString());
//        for (Map.Entry<String, Object> entry : paramsTmp.entrySet()) {
//            String key = entry.getKey();
//            Object value = entry.getValue();
//
//            int count = assertTableData(key, value);
//            assertTrue("数据库断言 > 0", count > 0);
//        }
//
//    }

//    @Then("DB_ASSERT")
//    public void dbAssert(Map<String,Object> paramsTmp){
//        for (Map.Entry<String, Object> entry : paramsTmp.entrySet()) {
//            String key = entry.getKey();
//            Object value = entry.getValue();
//
//            StringBuffer sql = new StringBuffer("SELECT count(1)")
//                    .append(" FROM ").append(key, 0, key.indexOf("."))
//                    .append(" WHERE ").append(key.substring(key.indexOf(".") + 1)).append("=")
//                    .append("'").append(value).append("'");
//            // 打印 SQL 语句
//            System.out.println(sql.toString());
//            // 执行 DB
//            QueryRunner run = new QueryRunner(DbKit.ds);
//            int count;
//            try {
//                count = run.query(sql.toString(), resultSet -> {
//                    if (resultSet.next()) {
//                        return resultSet.getInt(1);
//                    }
//                    return null;
//                });
//            } catch (SQLException ex) {
//                ex.printStackTrace();
//                count = -1;
//            }
//            assertTrue("数据库断言 > 0", count > 0);
//        }
//
//    }

    /**
     * json 提取 (嵌入式 Mongo)
     */
    @Then("JSONPATH_GET_MONGO")
    public void jsonPathGet(Map<String,Object> paramsTmp){
        paramsTmp.forEach((key,value) -> EnvParameters.mongoCache.put(value.toString(), ApiKit.getJsonPathObj(this.response,key)));
    }
}
