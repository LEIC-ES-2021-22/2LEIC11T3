Feature: Open main menu
  The main menu should appear when we click on the respective drawer option

  Scenario: Be able to see the establishments of FEUP and their timetable
    Given I am logged in
    When I open the drawer
    And I tap the "key_Food FEUP" button
    Then I expect the text 'Grill' to be present

  Scenario: Be able to see the menu of an establishment
    Given I am logged in
    When I open the drawer
    And I tap the "key_Food FEUP" button
    And I tap the "establishment_button_Grill" button and I dont wait
    Then I expect the widget 'establishment_menu' to be present within 30 seconds

  Scenario: Be able to rate a meal
    Given I am logged in
    When I open the drawer
    And I tap the "key_Food FEUP" button
    And I tap the "establishment_button_Grill" button and I dont wait
    And I tap the "review_button_Carne" button and I dont wait
    Then I expect the text 'Deixe um commentário' to be present

  Scenario: Be able to access suggestion page
    Given I am logged in
    When I open the drawer
    And I tap the "key_Food FEUP" button
    And I tap the "establishment_button_Recomendação" button and I dont wait
    And I tap the "dropdown_options" widget
    And I tap the widget that contains the text "Indiferente" within the "dropdown_options"
    Then I expect the text 'Recomendação' to be present
