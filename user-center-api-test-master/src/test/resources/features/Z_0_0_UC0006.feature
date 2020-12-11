Feature: UC0006-密码修改
  密码修改

  Scenario Outline:  校验未登录
    # 提供已存在的手机号校验
    Given API "/api/uc/user/pwd/edit"
    And Param
    """
    userLoginpwd: 123456
    userLoginpwd_new: 1234567
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline:  密码修改
    # 提供已存在的手机号校验
    Given API "/api/uc/user/pwd/edit"
    And CookieX
      | TOKEN | ${cookie_token}|
    And Param
    """
    userLoginpwd: 123456
    userLoginpwd_new: 1234567
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |