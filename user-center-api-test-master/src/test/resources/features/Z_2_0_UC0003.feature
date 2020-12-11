Feature: UC0003-退出登录
  退出登录

  Scenario Outline:  退出登录
    # 提供已存在的手机号校验
    Given API "/api/uc/logout"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |