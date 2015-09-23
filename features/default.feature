Feature:

  Scenario: Create a snippet of HTML based on the JSON
    Given I create a new converter
    And I pass JSON data of {"name":"value", "name2": "value"}
    Then it should return HTML with 'name'
    And it should return HTML with 'name2'
    And it should return HTML with 'value' 2 times
