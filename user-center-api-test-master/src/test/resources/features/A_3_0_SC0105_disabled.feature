Feature: SC0015-图形验证码
    通过异常参数测试, 这个接口设计不合理
    通过网关负责人 这个接口即将被弃用  已通知通知网管负责人,增加弃用颜色

    Scenario Outline:  正常参数测试
      Given API "/api/sc/captcha/captcha"
      And Param
        """
        scene: ms_sms_verifyCode_send
        """
      When GET
      Then STATUS "200"
      Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
      Then JSONPATH_GET_MONGO
      | data | regist_captcha |
      Examples:
      | jsonPath     | value             |
      | result       | 000000            |