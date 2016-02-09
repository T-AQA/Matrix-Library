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

    @matrixnull = TwoDMatrix.new
  end

  def test_determinant
		assert_equal -6, @matrixSparse3x3.determinant()
  end

  def test_err_determinant
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.determinant() }
  end

	#alias for determinant
	def test_det
		assert_equal -6, @matrixSparse3x3.det()
  end

  def test_err_det
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.det() }
  end

	def test_rank
		assert_equal 3, @matrixSparse3x3.rank()
  end

  def test_err_rank
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.rank() }
  end

	def test_round
    @matrixFloat2x2.round(2)
		assert_equal [[1.21, 3.22], [0.10, 2.24]], @matrixFloat2x2.decompose()

    @matrixFloat2x2.round()
    assert_equal [[1, 3], [0, 2]], @matrixFloat2x2.decompose()
  end

  def test_err_round
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.round(2) }
  end

	def test_trace
    assert_equal 6, @matrixDense3x3.trace()
  end

  def big_trace 
    assert_raises(CsrMatrix::Exceptions::BadInputException) { @matrixDense3x3.round(111) }
  end

  def test_err_trace
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.trace() }
  end

	#alias for trace
	def test_tr
    assert_equal 6, @matrixDense3x3.tr()
  end

  def test_err_tr
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.tr() }
  end

	def test_transpose
    @matrixSparse3x3.transpose()
    assert_equal [[0, 2, 0], [1, 0, 0], [0, 0, 3]], @matrixSparse3x3.decompose
  end

  def test_err_transpose
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.transpose() }
  end

	#alias for transpose
	def test_t
    @matrixSparse3x3.t()
    assert_equal [[0, 2, 0], [1, 0, 0], [0, 0, 3]], @matrixSparse3x3.decompose
  end

  def test_err_t
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.t() }
  end

end 