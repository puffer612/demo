Feature:  MC0001-短信验证码
  短信验证码

  Scenario Outline:  正常参数
    Given API "/api/mc/msg/sms/verifycode/send"
    And Param
    """
    smsPhone: ${CTX_PHONE}
    smstplNo: 010001
    captcha: ${regist_captcha}
    scene: uc_regist
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data.verifyValue | regist_verify_code |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |