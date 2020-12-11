Feature: UC9999-心跳
  关键核心 API
  Scenario Outline:  正常心跳
    Given API "/api/uc/heartbeat"
    When GET
    Then STATUS "200"
    Then JSONPATH_ASSERT "<jsonPath>" equals "<value>"
    Then JSONPATH_GET_MONGO
    | result | code |
    Examples:
      | jsonPath     | value             |
      | result       | 000000            |