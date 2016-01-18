require "minitest/autorun"
require "matrix"

# test with bundle exec rake
class UrlTest < Minitest::Test
  def test_url
    assert_equal "https://github.com/Team-Aqua/Matrix-Library/", TwoDMatrix::Url
    assert_equal "https://github.com/Team-Aqua/Matrix-Library/", Matrix::Url
  end
end

class DemoTest < Minitest::Test
	def setup 
		@matrix = TwoDMatrix.new

    @matrixDense3x3 = TwoDMatrix.new
    @matrixDense3x3.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])

    @matrixSparse3x3 = TwoDMatrix.new
    @matrixSparse3x3.build_from_array([[0, 2, 0], [1, 0, 0], [0, 2, 0]])

    @matrixTrigonal3x3 = TwoDMatrix.new
    @matrixTrigonal3x3.build_from_array([[1, 0, 0], [0, 1, 0], [0, 0, 1]])
	end

  def test_build_from_array
      @matrix.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  end

  def test_dimensions
      assert_equal @matrixSparse3x3.dimensions(), [3, 3]
  end

end