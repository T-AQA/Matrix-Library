require "minitest/autorun"
require "csrmatrix"

class FunctionsTest < Minitest::Test

  def setup
    @matrix = TwoDMatrix.new

    @matrixDense3x3 = TwoDMatrix.new
    @matrixDense3x3.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])

    @matrixSparse3x3 = TwoDMatrix.new
    @matrixSparse3x3.build_from_array([[0, 1, 0], [2, 0, 0], [0, 0, 3]])

    @matrixFloat2x2 = TwoDMatrix.new
    @matrixFloat2x2.build_from_array([[1.213, 3.22], [0.1, 2.2365]])
  end

  def test_determinant
		assert_equal -6, @matrixSparse3x3.determinant()
  end

	#alias for determinant
	def test_det
		assert_equal -6, @matrixSparse3x3.det()
  end

	def test_rank
		assert_equal 3, @matrixSparse3x3.rank()
  end

	def test_round
    @matrixFloat2x2.round(2)
		assert_equal [[1.21, 3.22], [0.10, 2.24]], @matrixFloat2x2.decompose()
  end

	def test_trace
    assert_equal 6, @matrixDense3x3.trace()
  end

	#alias for trace
	def test_tr
    assert_equal 6, @matrixDense3x3.tr()
  end

	def test_transpose
    @matrixSparse3x3.transpose()
    assert_equal [[0, 2, 0], [1, 0, 0], [0, 0, 3]], @matrixSparse3x3.decompose
  end

	#alias for transpose
	def test_t
    @matrixSparse3x3.t()
    assert_equal [[0, 2, 0], [1, 0, 0], [0, 0, 3]], @matrixSparse3x3.decompose
  end

end 