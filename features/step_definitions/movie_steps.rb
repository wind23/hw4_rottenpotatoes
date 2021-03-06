# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body =~ /.*#{e1}.*#{e2}.*/m
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
    ratinglist = rating_list.split(", ");
    ratinglist.each do |e|
        if uncheck == "un"
            uncheck("ratings_#{e}")
        else
            check("ratings_#{e}")
        end
    end
end

When /I check (.*) of the ratings/ do |e|
    if e == "all"
        check("ratings_G")
        check("ratings_R")
        check("ratings_PG")
        check("ratings_PG-13")
    elsif e == "none"
        uncheck("ratings_G")
        uncheck("ratings_R")
        uncheck("ratings_PG")
        uncheck("ratings_PG-13")
    else
        assert 0
    end
end

Then /I should find (.*) films/ do |e|
    if e == "all"
        Movie.all.each do |movie|
	  step %{I should see "#{movie[:title]}"}
        end
    elsif e == "no"
        Movie.all.each do |movie|
	  step %{I should not see "#{movie[:title]}"}
        end
    else
        assert 0
    end
end

Then /the director of "(.*)" should be "(.*)"/ do |e1, e2|
    assert page.body =~ /.*#{e1}.*Director.*#{e2}.*/m
end


