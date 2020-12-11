Feature: UC0019-获取历史UK
  获取历史 UK

  Scenario Outline:  校验未登录
    # 提供已存在的手机号校验
    Given API "/api/uc/user/uk/his"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline:  获取历史 UK
    # 提供已存在的手机号校验
    Given API "/api/uc/user/uk/his"
    And CookieX
      | TOKEN | ${cookie_token} |
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |