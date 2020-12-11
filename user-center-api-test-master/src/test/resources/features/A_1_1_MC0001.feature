Feature:  MC0001-短信验证码
  短信验证码

  Scenario Outline:  正常参数
    Given API "/api/mc/msg/sms/verifycode/send"
    And Param
    """
    smsPhone: ${CTX_PHONE}
    smstplNo: "010001"
    captcha: ${login_code}
    scene: uc_login
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data | login_verify_code |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |