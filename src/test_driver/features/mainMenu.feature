Feature: Open main menu
  The main menu should appear when we click on the respective drawer option

  Scenario: Be able to see the establishments of FEUP and their timetable
    When I fill the "usernameinput" field with "up201907727"
    And  I fill the "passwordinput" field with "******"
    And I tap the "entrar" button
    When I open the drawer
    And I tap the "key_Food FEUP" button
    Then I expect the text 'Cantina' to be present