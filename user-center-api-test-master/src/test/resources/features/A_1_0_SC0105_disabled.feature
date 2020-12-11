Feature: SC0105-图形验证码
    通过异常参数测试, 这个接口设计不合理
    通过网关负责人 这个接口即将被弃用  已通知通知网管负责人,增加弃用颜色

    [新测试环境] - 验证码被屏蔽严重

#  Scenario Outline:  校验-空参数
#    Given API "/api/sc/captcha/captcha"
#    When GET
#    Then STATUS "200"
#    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
#    Examples:
#      | jsonPath     | value             |
#      | result       | GB2001            |
#
#  Scenario Outline:  校验-数据异常参数
#    Given API "/api/sc/captcha/captcha"
#    And Param
#    """
#    scene: "无法确定的参数"
#    """
#    When GET
#    Then STATUS "200"
#    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
#    Examples:
#      | jsonPath     | value             |
#      | result       | GB2001            |


  Scenario Outline:  正常-参数测试
    Given API "/api/sc/captcha/captcha"
    And Param
    """
    scene: "ms_sms_verifyCode_send"
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data | login_code |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |