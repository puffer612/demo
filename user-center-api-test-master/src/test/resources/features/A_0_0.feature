Feature: 初始化数据
  初始化手机号

  Scenario:  初始化变量数据
    Given INI_VAR_DATA
    """
    CTX_PHONE: "15936934997"
    """
    And INIT_MYSQL_DATA
    """
    dbName: "usercenter"
    tables:
    - name: "UcUser"
    - name: "UcMenu"
    """
