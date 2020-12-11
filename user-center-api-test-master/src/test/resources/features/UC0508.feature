Feature: UC0508-客户端版本UK检查
  客户端版本UK检查


  Scenario Outline:  客户端版本UK检查
    # 提供已存在的手机号校验
    Given API "/api/uc/cltver/uk/check"
    And Param
    """
    clttypeCode: YOULU_APP_MAIN
    clttypeTerminal: IOS
    cltverCode: 1
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |