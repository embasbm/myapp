Feature: Home page

  Scenario: Viewing application's home page
    Given there's a job named "MyString"
    When I am on the homepage
    Then I should see the "MyString" job