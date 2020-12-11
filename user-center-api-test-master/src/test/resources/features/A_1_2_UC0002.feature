Feature: UC0002-手机号登录
  手机号登录
  网关重启之后存在潜在BUG 比如

  Scenario Outline:  短信验证码为空
    Given API "/api/uc/login"
    And Param
    """
    userMobile: ${CTX_PHONE}
    userFlag: S
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data.token | cookie_token              |
    Examples:
      | jsonPath     | value             |
      | result       | GB2009            |

  Scenario Outline:  正常参数测试
    Given API "/api/uc/login"
    And Param
    """
    userMobile: ${CTX_PHONE}
    verify: "${login_verify_code}"
    userFlag: S
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data.token | cookie_token              |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |