Feature: User can manually delete movie

Scenario: Delete a movie
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Harry Potter"
  And I select "PG-13" from "Rating"
  And I press "Save Changes"
  And I should see "Harry Potter"
  And I follow "Back to movie list"
  And I should see "All Movies"
  And I follow "More about Harry Potter"
  And I press "Delete"
  And I should see "Harry Potter was successfully deleted."
