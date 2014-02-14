require 'spec_helper'


describe Movie do

  before :each do
    Movie.create ({:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'})
    Movie.create ({:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'})
    Movie.create ({:title => 'Alien', :rating => 'R', :release_date => '1979-05-25'})
    Movie.create ({:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'})
  end
  
  it 'should find similar movies' do
    movie = Movie.find_by_director('George Lucas')
    Movie.similar(movie.id)[0][:title].should == 'Star Wars'
    Movie.similar(movie.id)[1][:title].should == 'THX-1138'
    Movie.similar(movie.id)[2].should == nil
  end
  
end
