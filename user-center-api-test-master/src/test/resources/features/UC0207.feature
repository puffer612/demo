Feature: UC0207-获取省市区域
  获取省市区域

  Scenario Outline:  正常值
    # 提供已存在的手机号校验
    Given API "/api/uc/dict/list/seem"
    And CookieX
      | TOKEN | ${cookie_token} |
    And Param
    """
    dictType: city
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |