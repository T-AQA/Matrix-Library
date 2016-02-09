require "minitest/autorun"
require "csrmatrix"
# require "contracts"

class BuilderTest < Minitest::Test

  def setup 
    @matrix = TwoDMatrix.new

    @matrixDense3x3 = TwoDMatrix.new
    @matrixDense3x3.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])

    @matrixSparse3x3 = TwoDMatrix.new
    @matrixSparse3x3.build_from_array([[0, 2, 0], [1, 0, 0], [0, 2, 0]])

    @matrixTrigonal3x3 = TwoDMatrix.new
    @matrixTrigonal3x3.build_from_array([[1, 0, 0], [0, 1, 0], [0, 0, 1]])

    @MatrixBuild = Matrix.rows([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  end

  def test_same_sublength_method
    assert !@matrix.same_sublength([[2,3],[3,3,3]])
    assert @matrix.same_sublength([[2,3],[3,3]])
  end

  def test_build_from_rows
    @matrix.build_from_rows([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    assert_equal [[1, 1, 1], [2, 2, 2], [3, 3, 3]], @matrix.decompose()
  end

  def test_generic_builder
    @matrix.build("rows", [[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    assert_equal [[1, 1, 1], [2, 2, 2], [3, 3, 3]], @matrix.decompose()
    @matrix.build("columns", [[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose() 
    @matrix.build("identity", 3) #rows, columns are same
    assert_equal [[1, 0, 0], [0, 1, 0], [0, 0, 1]], @matrix.decompose()
    @matrix.build("zero", 2) #rows, columns
    assert_equal [[0, 0], [0, 0]], @matrix.decompose()
    @matrix.build("csr", [[0, 3, 6, 9],[0, 1, 2, 0, 1, 2, 0, 1, 2],[1, 2, 3, 1, 2, 3, 1, 2, 3],3,3])
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose()
    @matrix.build("array", [[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose()
    @matrix.build("matrix", @MatrixBuild)
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose()
    assert @matrix.build("identity", 100)
  end

	def test_invalid_generic_builder
		assert_raises(CsrMatrix::Exceptions::MatrixTypeException) { @matrix.build("failure", 0) } 
		assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build("rows", [[11111111111111111, 2, 3], [1, 2, 3], [1, 2, 3]]) } 
  	assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build("columns", [[1111111111, 2, 3], [1, 2, 3], [1, 2, 3]]) } 
  	assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build("identity", 11111111111111111) } 
  	assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build("zero", 11111111111111111) } 
  	assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build("csr", [[0, 3, 6, 9],[0, 1, 2, 0, 1, 2, 0, 1, 2],[11111111111111111, 2, 3, 1, 2, 3, 1, 2, 3],3,3]) } 
  	assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build("array", [[11111111111111111, 2, 3], [1, 2, 3], [1, 2, 3]]) } 
	end

  def test_nil_build
    assert_raises(ParamContractError) { @matrix.build_from_array([[1, nil, 2],[2, nil, 3]]) } 
  end

  def test_bad_row_build
    # reference: http://cczona.com/blog/asserting-exceptions-with-minitest/
    assert_raises(CsrMatrix::Exceptions::MatrixDimException) { @matrix.build_from_rows([[1, 2, 3], [2, 3], [2, 3]]) } 
		assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build_from_rows([[11111111111111111, 3], [2, 3], [2, 3]]) } 
  end

  def test_build_from_matrix
    @matrix.build_from_matrix(@MatrixBuild)
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose()
  end

  def test_wrong_type_matrix
    assert_raises(ParamContractError) { @matrix.build_from_matrix(4) } 
  end  

  def test_build_from_columns
    @matrix.build_from_columns([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose()
  end

  def test_bad_column_build
    assert_raises(CsrMatrix::Exceptions::MatrixDimException) { @matrix.build_from_columns([[1, 2, 3], [2, 3], [2, 3]]) } 
		# assert_raises(CsrMatrix::Exceptions::InputOverflowError) { @matrix.build_from_columns([[1111111111, 3], [2, 3], [2, 3]]) } 
  end

  def test_wrong_type_build
    assert_raises(ParamContractError) { @matrix.build_from_array(4) } 
  end

  def test_wrong_type_column
    assert_raises(ParamContractError) { @matrix.build_from_columns(4) } 
  end

  def test_wrong_type_rows
    assert_raises(ParamContractError) { @matrix.build_from_rows(4) } 
  end

  def test_wrong_type_identity
    assert_raises(ParamContractError) { @matrix.build_identity_matrix([4, 4]) } 
  end

  def test_wrong_type_zero
    assert_raises(ParamContractError) { @matrix.build_zero_matrix([4, 4]) } 
  end  

  def test_build_identity_matrix
    @matrix.build_identity_matrix(3) #rows, columns are same
    assert_equal [[1, 0, 0], [0, 1, 0], [0, 0, 1]], @matrix.decompose()
  end 

  def test_build_zero_matrix
    @matrix.build_zero_matrix(3, 2) #rows, columns
    assert_equal [[0, 0], [0, 0], [0, 0]], @matrix.decompose()
  end

  def test_build_zero_matrix_one
    @matrix.build_zero_matrix(2) #rows, columns
    assert_equal [[0, 0], [0, 0]], @matrix.decompose()
  end

  def test_build_from_csr
    @matrix.build_from_csr([0, 3, 6, 9],[0, 1, 2, 0, 1, 2, 0, 1, 2],[1, 2, 3, 1, 2, 3, 1, 2, 3],3,3)
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose()
  end

  def test_build_from_array # essentially build_from_columns right now
    @matrix.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @matrix.decompose()
  end

  def test_decomposition
    assert_equal [[0, 2, 0], [1, 0, 0], [0, 2, 0]], @matrixSparse3x3.decompose()
  end

  def test_decomp_to_matrix
    @matdecomp = @matrixSparse3x3.decomp_to_matrix()
    assert_equal Matrix[[0, 2, 0], [1, 0, 0], [0, 2, 0]], @matdecomp
  end 

  def test_dimensions
    assert_equal [3, 3], @matrixSparse3x3.dimensions()
  end

end

