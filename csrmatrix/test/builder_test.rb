require "minitest/autorun"
require "csrmatrix"

class BuilderTest < Minitest::Test
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
    assert @matrix.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  end

  def test_decomposition
    assert_equal [[0, 2, 0], [1, 0, 0], [0, 2, 0]], @matrixSparse3x3.decompose()
  end

  def test_dimensions
    assert_equal [3, 3], @matrixSparse3x3.dimensions()
  end

end

