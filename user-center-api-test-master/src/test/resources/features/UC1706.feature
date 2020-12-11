Feature: UC1706-客户端灰度检查
  客户端灰度检查

  Scenario Outline:  校验未登录
    # 提供已存在的手机号校验
    Given API "/api/uc/cltgray/token/check"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline:  客户端灰度检查
    # 提供已存在的手机号校验
    Given API "/api/uc/cltgray/token/check"
    And CookieX
      | TOKEN | ${cookie_token} |
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |