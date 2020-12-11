Feature: UC0025-随机用户名和头型

  Scenario Outline:  随机用户名和头型
    # 提供已存在的手机号校验
    Given API "/api/uc/user/avatar/nickname/list/random"
    And Param
    """
    count: 2
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |