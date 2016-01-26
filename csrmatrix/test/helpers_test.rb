require "minitest/autorun"
require "csrmatrix"

class HelpersTest < Minitest::Test

  def setup
		@testArray = [[0, 1, 0], [2, 0, 0], [0, 0, 3]]
  end

  def test_max_col
    assert_equal 3, max_col(@testArray)
  end

	def test_max_row
    assert_equal 3, max_row(@testArray)
  end

	def test_nonzero
    assert_equal 3, nonzero(@testArray)
  end

	def test_depth
    assert_equals 2, depth(@testArray)
  end

	def test_count_total
    assert_equals 9, count_total(@testArray)
  end

end