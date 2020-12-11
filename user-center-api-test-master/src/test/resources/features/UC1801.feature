Feature: UC1801-绑定手机号

  Scenario Outline: 校验未登录
    Given API "/api/uc/bind/phone"
    And Param
    """
    verifyPhone: ${CTX_PHONE}
    verifyToken:
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline: TOKEN为空
    Given API "/api/uc/bind/phone"
    And CookieX
      | TOKEN | ${cookie_token} |
    And Param
    """
    verifyPhone: ${CTX_PHONE}
    verifyToken:
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2001            |