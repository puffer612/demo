package com.youlu.api.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DbKit {

    private DbKit() {}

    public static HikariDataSource ds (String jdbcUrl){
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(jdbcUrl);
        config.setUsername("root");
        config.setPassword("123456");
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
        return new HikariDataSource(config);
    }

    /**
     * 复制表结构
     * @param dataSource
     * @param tableName
     * @return
     */
    public static boolean copyTableDefine(HikariDataSource dataSource,String tableName,String newTableName) throws SQLException {
        // 复制表结构
        StringBuilder sql = new StringBuilder("CREATE TABLE " + newTableName +" like "+ tableName);
        QueryRunner run = new QueryRunner(dataSource);
        run.execute(sql.toString());
        return true;
    }


    // checkTableData

    // assertTableData
    private int assertTableData(HikariDataSource dataSource,String key, Object value) {
        StringBuffer sql = new StringBuffer("SELECT count(1)")
                .append(" FROM ").append(key, 0, key.indexOf("."))
                .append(" WHERE ").append(key.substring(key.indexOf(".") + 1)).append("=")
                .append("'");

        if (value.toString().contains("JsonPath(")){
            String jsonPath = value.toString().substring(9, value.toString().length() - 1);
//            sql.append(this.response.jsonPath().get(jsonPath).toString());
        }else {
            sql.append(value);
        }
        sql.append("'");
        // 打印 SQL 语句
        System.out.println(sql.toString());
        // 执行 DB
        QueryRunner run = new QueryRunner(dataSource);
        int count;
        try {
            count = run.query(sql.toString(), resultSet -> {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
                return null;
            });
        } catch (SQLException ex) {
            ex.printStackTrace();
            count = -1;
        }
        return count;
    }

}
