Feature: UC0007-通过手机号重置密码

  Scenario Outline:  正常
    # 提供已存在的手机号校验
    Given API "/api/uc/user/pwd/reset"
    And Param
    """
    userMobile: ${CTX_PHONE}
    userFlag: S
    userLoginpwd: 123456
    verify: ${reset_pwd_verify_code}
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |