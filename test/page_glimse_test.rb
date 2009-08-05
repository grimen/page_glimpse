require 'rubygems'
require 'test/unit'
require 'shoulda'

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'page_glimpse'))

class PageGlimpseTest < Test::Unit::TestCase
  
  VALID_API_KEY = 'ec0ccd30be1b39393d19cb5f410d26df'
  INVALID_API_KEY = 'ec0ccd30be1b39393d19'
  
  def setup
    @valid_glimpser = PageGlimpse.new(VALID_API_KEY)
    @invalid_glimpser = PageGlimpse.new(INVALID_API_KEY)
  end
  
  should "be instanciated correctly" do
    assert_instance_of PageGlimpse, @valid_glimpser
  end
  
  should "work with valid api key" do
    assert_equal 200, @valid_glimpser.class.get('http://google.com').code.to_i
  end
  
  should "make a snapshot of a valid webpage" do
    @valid_glimpser.request!('http://google.com')
    assert_not_nil @valid_glimpser.thumbnail('http://google.com', :size => :small)
  end
  
  # TODO: Write thorough tests.
  
end