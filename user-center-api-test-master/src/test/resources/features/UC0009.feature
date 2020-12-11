Feature: UC0009-用户缓存清除
  用户缓存清除

  Scenario Outline:  不传递用户标识
    # 提供已存在的手机号校验
    Given API "/api/uc/user/cache/clear"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2001            |