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
    @matrixzero = TwoDMatrix.new
    @matrixa.build_from_array([[1,2],[3,4]])
    @matrixb.build_from_array([[1,2],[3,4]])
    @matrixc.build_from_array([[1,2,3],[1,2,3],[1,2,3]])
    @matrixd.build_from_array([[5,6],[7,8]])
    @matrixzero.build_from_array([[0,1],[1,2]])

    @matrixTwoByThree = TwoDMatrix.new
    @matrixTwoByThree.build_from_array([[1,2,3],[4,5,6]])

    @matrixThreeByTwo = TwoDMatrix.new
    @matrixThreeByTwo.build_from_array([[1,2],[3,4],[5,6]])

    @matrixnull = TwoDMatrix.new
  end

  def test_scalar_full
    # tests the full capacity of the system; testing robustness
    @matrixConst.scalar_multiply(2)
    @matrixConst.scalar_division(2)
    @matrixConst.scalar_add(2)
    @matrixConst.scalar_subtract(1)
    @matrixConst.scalar_add(2)
    @matrixConst.scalar_subtract(1)
    @matrixConst.matrix_add(@matrixb)
    @matrixConst.inverse()
    @matrixConst.round(2)
    assert_equal [[-3.0, 2.0], [2.5, -1.5]], @matrixConst.decompose
  end 

  def test_over_multiply
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_multiply(10000000000000000) }
  end

  def test_under_multiply
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_multiply(-10000000000000000) }
  end

  def test_scalar_multiply
    assert_equal [2,4,6,8], @matrixConst.scalar_multiply(2)
  end

  def test_scalar_add
    assert_equal [3,4,5,6], @matrixConst.scalar_add(2)
  end

  def test_over_add
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_add(10000000000000000) }
  end

  def test_under_add
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_add(-10000000000000000) }
  end

  def test_scalar_subtract
    assert_equal [0,1,2,3], @matrixConst.scalar_subtract(1)
  end

  def test_over_subtract
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_subtract(10000000000000000) }
  end

  def test_under_subtract
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_subtract(-10000000000000000) }
  end

  def test_scalar_division
    assert_equal [0.5, 1.0, 1.5, 2.0], @matrixConst.scalar_division(2)
  end

  def test_over_division
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_division(10000000000000000) }
  end

  def test_under_division
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_division(-10000000000000000) }
  end

  # FIXME: convert everything to float with .to_f (ref: http://stackoverflow.com/questions/16563758/how-to-initialize-a-variable-to-the-type-double-in-ruby)
  def test_scalar_exp
    assert_equal [1,4,9,16], @matrixConst.scalar_exp(2)
  end

  def test_over_exp
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_exp(10000000000000000) }
  end

  def test_under_exp
    assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrixConst.scalar_exp(-10000000000000000) }
  end

  def test_inverse
    @matrixConst.inverse()
    assert_equal [[Rational('-2/1'), Rational('1/1')], [Rational('3/2'), Rational('-1/2')]], @matrixConst.decompose()
  end

  def test_err_inverse
    assert_raises( ArgumentError ) { @matrixConst.inverse(4)}

    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.inverse()}    
  end

  # not implemented yet
  def test_transpose
    @matrixConst.transpose()
    assert_equal [[1,3],[2,4]],  @matrixConst.decompose()
  end

  def test_err_transpose
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.transpose() }
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
    assert_raises(CsrMatrix::Exceptions::MatrixDimException) { @matrixa.matrix_add(@matrixc) }
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.matrix_add(@matrixc)}
  end

  def test_err_subtract
    assert_raises(CsrMatrix::Exceptions::MatrixDimException) { @matrixa.matrix_subtract(@matrixc) }
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.matrix_subtract(@matrixc)}
  end

  def test_scalar_err_multiply
    assert_raises(ParamContractError) { @matrixa.scalar_multiply(nil) }
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.scalar_multiply(1) }
  end

  def test_scalar_err_add
    assert_raises(ParamContractError) { @matrixa.scalar_add(nil) }
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.scalar_add(1)}
  end

  def test_scalar_err_subtract
    assert_raises(ParamContractError) { @matrixa.scalar_subtract(nil) }
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.scalar_subtract(1)}
  end

  def test_scalar_err_divide
    assert_raises(ParamContractError) { @matrixa.scalar_division(nil) }
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.scalar_division(1)}
  end

  def test_scalar_err_exp
    assert_raises(ParamContractError) { @matrixa.scalar_exp(nil) }
    assert_raises(CsrMatrix::Exceptions::InvariantError) { @matrixnull.scalar_exp(1)}
  end

  # we multiply by the inverse of b
  def test_matrix_multiply_inverse_err
    assert_raises(CsrMatrix::Exceptions::MatrixDimException) {  @matrixTwoByThree.multiply_inverse(@matrixThreeByTwo) }
  end  

  def test_matrix_inverse_multiply_err
    assert_raises(CsrMatrix::Exceptions::MatrixDimException) {  @matrixThreeByTwo.inverse_multiply(@matrixTwoByThree) }
  end

  def test_matrix_multiply_inverse
    assert_equal [[Rational('3/1'), Rational('-2/1')], [Rational('2/1'), Rational('-1/1')]], @matrixa.multiply_inverse(@matrixd)
  end

  def test_matrix_inverse_multiply
    assert_equal [[Rational('-1/1'), Rational('2/1')], [Rational('-2/1'), Rational('3/1')]], @matrixa.inverse_multiply(@matrixd)
  end

  def test_err_matrix_multiply
    assert_raises( CsrMatrix::Exceptions::InvariantError ) {@matrixnull.matrix_multiply(@matrixb.decompose())}
  end

  def test_matrix_divide
    assert_equal [[5.0, 3.0], [2.3333333333333335, 2.0]], @matrixd.matrix_division(@matrixa)
  end  

  def test_err_divide_by_zero
    assert_raises(CsrMatrix::Exceptions::DivideByZeroException) {  @matrixd.matrix_division(@matrixzero) }
  end
end
