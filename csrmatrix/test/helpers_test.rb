require "minitest/autorun"
require "csrmatrix"

class HelpersTest < Minitest::Test

  def setup
    @matrix = TwoDMatrix.new
		@testArray = [[0, 1, 0], [2, 0, 0], [0, 0, 3]]
  end

  def test_max_col
    assert_equal 3, @matrix.max_col(@testArray)
  end

	def test_max_row
    assert_equal 3, @matrix.max_row(@testArray)
  end

	def test_nonzero
    assert_equal 3, @matrix.count_nonzero(@testArray)
  end

	def test_depth
    assert_equal 2, @matrix.depth(@testArray)
  end

	def test_count_total
    assert_equal 9, @matrix.count_total(@testArray)
  end

end