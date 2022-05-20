Feature: Open main menu
  The main menu should appear when we click on the respective drawer option

  Scenario: Be able to see the establishments of FEUP and their timetable
    Given I am logged in
    When I open the drawer
    And I tap the "key_Food FEUP" button
    Then I expect the text 'Cantina' to be present

  Scenario: Be able to see the menu of an establishment
    Given I am logged in
    When I open the drawer
    And I tap the "key_Food FEUP" button
    And I tap the "establishment_button_Cantina" button and I dont wait
    Then I expect the widget 'establishment_menu' to be present within 30 seconds