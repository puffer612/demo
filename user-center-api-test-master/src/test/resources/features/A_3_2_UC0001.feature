Feature: UC0001-手机号注册
  校验已存在的手机号

  Scenario Outline:  验证码错误场景
    # 提供已存在的手机号校验
    Given API "/api/uc/regist"
    And Param
      """
        userMobile: ${CTX_PHONE}
        verify:
        userFlag: S
      """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2009            |


  Scenario Outline:  验证码正确-手机号已经被注册
    # 提供已存在的手机号校验
    Given API "/api/uc/regist"
    And Param
      """
        userMobile: ${CTX_PHONE}
        verify:
          verifyValue: ${regist_verify_code}
        userFlag: S
      """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB1001            |