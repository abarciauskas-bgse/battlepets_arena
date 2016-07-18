Feature: Contests
  Contests pit one BattlePet against another and evaluate them against a set of rules.
  There is always one winner and one loser in any contest. None of the contests are fatal, so upon completion, both creatures should earn some experience and be made immediately available for another contest.
  Experience and past contest results should be recorded.

  Background:
    Given a witty battlepet "Totoro" exists
    And "Totoro" has medium strength
    And a less witty battlepet "Luna" exist
    And a battlepet "Hamtaro" exists
    And "Hamtaro" has medium strength

  Scenario: Two battlepets participate in a contest of wit
    When "Totoro" and "Luna" participate in a contest of wit
    Then the contest will be completed
    And "Totoro" will be declared the winner

  Scenario: Two battlepets of equal strength participate in a contest of strength, the more experienced battlepet wins
    Given "Totoro" and "Luna" participate in a contest of wit
    When "Totoro" and "Hamtaro" participate in a contest of strength
    Then the contest will be completed
    And "Totoro" will be declared the winner
