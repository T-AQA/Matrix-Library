require "minitest/autorun"
require "csrmatrix"

class AlgorithmTest < Minitest::Test
  def setup
    @matrix = TwoDMatrix.new
    @matrix.build_from_array([[1,2],[3,4]])

    @matrixConst = TwoDMatrix.new
    @matrixConst.build_from_array([[1,2],[3,4]])

    @matrixa = TwoDMatrix.new
    @matrixb = TwoDMatrix.new
    @matrixa.build_from_array([[1,2],[3,4]])
    @matrixb.build_from_array([[1,2],[3,4]])
  end

  def test_scalar_multiply
    assert_equal [2,4,6,8], @matrixConst.scalar_multiply(2)
  end

  def test_scalar_add
    assert_equal [3,4,5,6], @matrixConst.scalar_add(2)
  end

  def test_scalar_subtract
    assert_equal [0,1,2,3], @matrixConst.scalar_subtract(1)
  end

  def test_scalar_division
    assert_equal [0.5, 1.0, 1.5, 2.0], @matrixConst.scalar_division(2)
  end

  # FIXME: convert everything to float with .to_f (ref: http://stackoverflow.com/questions/16563758/how-to-initialize-a-variable-to-the-type-double-in-ruby)
  def test_scalar_exp
    assert_equal [1,4,9,16], @matrixConst.scalar_exp(2)
  end

  def test_inverse
    @matrixConst.inverse()
    assert_equal  [[Rational('-2/1'), Rational('1/1')], [Rational('3/2'), Rational('-1/2')]], @matrixConst.decompose()
  end

  # not implemented yet
  def test_transpose
    @matrixConst.transpose()
    assert_equal [[1,3],[2,4]],  @matrixConst.decompose()
  end

  def test_matrix_multiply
    assert_equal [[7, 10], [15, 22]], @matrixa.multiply_csr(@matrixb)
  end

  def test_is_same_dim
    assert @matrixa.is_same_dim(@matrixb)
  end

  def test_matrix_add
    assert_equal [[2,4],[6,8]], @matrixa.matrix_add(@matrixb)
  end

  def test_matrix_subtract
    assert_equal [[0,0],[0,0]], @matrixa.matrix_subtract(@matrixb)
  end

  def test_matrix_left_division
    # assert_equal [[(0/1), (1/2)], [(-2/1), (5/2)]], @matrixa.matrix_left_division(@matrixb)
    # we multiply by the inverse of b
    assert_equal [[(1), (0)], [(0), (1)]], @matrixa.matrix_left_division(@matrixb)
  end  

  def test_matrix_right_division
    assert_equal [[(1), (0)], [(0), (1)]], @matrixa.matrix_right_division(@matrixb)
  end

  def test_matrix_exp
    # dev
  end 

end