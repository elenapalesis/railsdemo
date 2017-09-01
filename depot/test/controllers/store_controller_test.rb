require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
	assert_select 'nav.side_nav a', minimum: 4
	# verifies a minimum of 4 <a> elements contained in a <nav> element
	# with the class 'side_nav'
	
	assert_select 'main ul.catalog li', 3
	# verifies that there are 3 <li> elements within a <ul> element with
	# the class of 'catalog' within the <main> element.
	# There should be 3 because this matches the number of entries in the
	# fixtures file.
	
	assert_select 'h2', 'Programming Ruby 1.9'
	# verifies that there is an <h2> with the text listed in the second arg.
	# The data comes from the fixtures file.
	
	assert_select '.price', /\$[,\d]+\.\d\d/
	# verifies that there exists a price with a value that contains '$'
	# followed by at least one digit or comma, followed by a '.', followed
	# by two digits.
  end

end
