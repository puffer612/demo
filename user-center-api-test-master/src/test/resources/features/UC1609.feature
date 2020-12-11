Feature: UC1609-获取用户配置
  获取用户配置

  Scenario Outline: 获取用户配置
    # 提供已存在的手机号校验
    Given API "/api/uc/config/find"
    And Param
    """
    configType: M
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |