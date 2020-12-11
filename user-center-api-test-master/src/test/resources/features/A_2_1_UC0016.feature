Feature: UC0016-网站平台登录
  网站平台登录


  Scenario Outline:  校验未登录
    # 提供已存在的手机号校验
    Given API "/api/uc/user/uk"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data.uk | user_uk |
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline:  网站平台登录
    # 提供已存在的手机号校验
    Given API "/api/uc/user/uk"
    And CookieX
      | TOKEN | ${cookie_token} |
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
      | data.uk | user_uk |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |