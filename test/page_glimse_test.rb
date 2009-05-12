require 'test/unit'
require 'shoulda'

class PageGlimpseTest < Test::Unit::TestCase
  
  VALID_API_KEY = 'ec0ccd30be1b39393d19cb5f410d26df'
  INVALID_API_KEY = 'ec0ccd30be1b39393d19cb5f410d26d'
  
  def setup
    @glimpser = PageGlimpse.new(TEST_API_KEY)
  end
  
  should "be true" do
    assert true
  end
  
end