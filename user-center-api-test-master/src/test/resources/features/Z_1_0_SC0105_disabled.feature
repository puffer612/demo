Feature: SC0105-密码重置图形验证码

  Scenario Outline:  图形验证码
    Given API "/api/sc/captcha/captcha"
    And Param
    """
    scene: ms_sms_verifyCode_send
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data | reset_pwd_captcha |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |