require 'test_helper'

class TweetRequestTest < ActionDispatch::IntegrationTest
  test "can see the welcome page" do
    get "/"
    assert_select "h1", "TwitterGitter"
  end

  test "valid twitter handle returns tweets" do
    get "/?screen_name=vancityreynolds"
    assert_select "strong", "@vancityreynolds"
  end

  test "invalid twitter handle returns error message" do
    get "/?screen_name=test"
    assert_select "div", "Unable to reach tweets for @test."
  end

  test "new user is added to database on request" do
    assert_difference 'User.count' do
      get "/?screen_name=nytimes"
    end
  end

  test "new tweets are added to database on request" do
    get "/?screen_name=thepracticaldev"
    assert_equal 12, Tweet.count
  end
end
