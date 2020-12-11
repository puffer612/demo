Feature: UC0208-获取地区
  获取地区


  Scenario Outline:  获取地区
    # 提供已存在的手机号校验
    Given API "/api/uc/dict/area/tree"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |