Feature: UC0004-获取用户信息
  获取用户信息

  Scenario Outline:  校验未登录
    # 提供已存在的手机号校验
    Given API "/api/uc/user/profile/view"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline:  获取用户信息
    # 提供已存在的手机号校验
    Given API "/api/uc/user/profile/view"
    And CookieX
      | TOKEN | ${cookie_token} |
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |

