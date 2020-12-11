Feature: UC0005-修改用户信息
  修改用户信息

  Scenario Outline:  校验未登录
    # 提供已存在的手机号校验
    Given API "/api/uc/user/profile/edit"
    And Param
       """
       userNickname: niaoshuai
       """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2004            |

  Scenario Outline:  修改用户信息
    # 提供已存在的手机号校验
    Given API "/api/uc/user/profile/edit"
    And CookieX
      | TOKEN | ${cookie_token} |
    And Param
       """
       userNickname: niaoshuai
       """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |