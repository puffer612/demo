Feature: UC0018-绑定身份信息

  Scenario Outline: 验证数据信息
    Given API "/api/uc/bind/identify"
    And Param
    """
    userIdcardtype: 身份证
    userIdcard: 412722199111133531
    userName: 任帅鹏
    """
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | GB2001            |