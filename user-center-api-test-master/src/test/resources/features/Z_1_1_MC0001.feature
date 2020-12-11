Feature: MC0001-获取重置手机验证码

  Scenario Outline:  正常
    Given API "/api/mc/msg/sms/verifycode/send"
    And Param
    """
    smsPhone: ${CTX_PHONE}
    smstplNo: "010001"
    captcha: ${reset_pwd_captcha}
    scene: uc_user_pwd_reset
    """

    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data | reset_pwd_verify_code |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |