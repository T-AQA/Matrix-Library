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
    @matrixc = TwoDMatrix.new
    @matrixd = TwoDMatrix.new
    @matrixa.build_from_array([[1,2],[3,4]])
    @matrixb.build_from_array([[1,2],[3,4]])
    @matrixc.build_from_array([[1,2,3],[1,2,3],[1,2,3]])
    @matrixd.build_from_array([[5,6],[7,8]])

    @matrixTwoByThree = TwoDMatrix.new
    @matrixTwoByThree.build_from_array([[1,2,3],[4,5,6]])

    @matrixThreeByTwo = TwoDMatrix.new
    @matrixThreeByTwo.build_from_array([[1,2],[3,4],[5,6]])
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
    assert_equal [[Rational('-2/1'), Rational('1/1')], [Rational('3/2'), Rational('-1/2')]], @matrixConst.decompose()
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

  def test_err_add
    assert_raises(CsrMatrix::Arithmetic::MatrixDimException) { @matrixa.matrix_add(@matrixc) }
  end

  def test_err_subtract
    assert_raises(CsrMatrix::Arithmetic::MatrixDimException) { @matrixa.matrix_subtract(@matrixc) }
  end

  def scalar_err_multiply
    assert_raises(CsrMatrix::Arithmetic::ArgumentNullException) { @matrixa.scalar_multiply(nil) }
  end

  def scalar_err_add
    assert_raises(CsrMatrix::Arithmetic::ArgumentNullException) { @matrixa.scalar_add(nil) }
  end

  def scalar_err_subtract
    assert_raises(CsrMatrix::Arithmetic::ArgumentNullException) { @matrixa.scalar_subtract(nil) }
  end

  def scalar_err_divide
    assert_raises(CsrMatrix::Arithmetic::ArgumentNullException) { @matrixa.scalar_divide(nil) }
  end

  def scalar_err_exp
    assert_raises(CsrMatrix::Arithmetic::ArgumentNullException) { @matrixa.scalar_exp(nil) }
  end

  # we multiply by the inverse of b
  def test_matrix_left_division_err
    assert_raises(CsrMatrix::Arithmetic::MatrixDimException) {  @matrixTwoByThree.matrix_left_division(@matrixThreeByTwo) }
  end  

  def test_matrix_right_division_err
    assert_raises(CsrMatrix::Arithmetic::MatrixDimException) {  @matrixThreeByTwo.matrix_right_division(@matrixTwoByThree) }
  end

  # FIXME: functions are broken right now, need to fix left/right division
  # http://www.wolframalpha.com/input/?i=%7B%7B1,2%7D,%7B3,4%7D%7D+%2F+%7B%7B5,6%7D,%7B7,8%7D%7D
  # currently multiplies x by y^-1
  def test_matrix_left_division
    assert_equal [[Rational('3/1'), Rational('-2/1')], [Rational('2/1'), Rational('-1/1')]], @matrixa.matrix_left_division(@matrixd)
  end

  # http://www.wolframalpha.com/input/?i=%7B%7B5,6%7D,%7B7,8%7D%7D+*+%7B%7B1,2%7D,%7B3,4%7D%7D%5E-1
  # multiply y by x^-1
  def test_matrix_right_division
    assert_equal [[Rational('-1/1'), Rational('2/1')], [Rational('-2/1'), Rational('3/1')]], @matrixa.matrix_right_division(@matrixd)
  end

end