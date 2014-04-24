Feature: Home page

  Scenario: Viewing application's home page
    Given there's a job titled "A"
    When I am on the homepage
    Then I should see the "A" Job