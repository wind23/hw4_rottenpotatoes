require 'spec_helper'


describe MoviesController do
  before :each do
    Movie.create ({:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'})
    Movie.create ({:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'})
    Movie.create ({:title => 'Alien', :rating => 'R', :release_date => '1979-05-25'})
    Movie.create ({:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'})
  end

  describe 'find similar movies' do
    it 'should call method Movie.similar' do
      Movie.should_receive(:similar).with("1")
      post :similar, {:movie_id => 1}
    end

    it 'should return the expected results' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:similar).and_return(fake_results)
      post :similar, {:movie_id => 1}
      response.should render_template('similar')
      assigns(:movies).should == fake_results
    end

  end
end
