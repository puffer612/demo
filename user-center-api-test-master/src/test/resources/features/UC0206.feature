Feature: UC0206-字典层级
  字典层级

  Scenario Outline:  校验未登录
    Given API "/api/uc/dict/rank"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline:  字典层级
    Given API "/api/uc/dict/rank"
    And CookieX
      | TOKEN | ${cookie_token} |
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |