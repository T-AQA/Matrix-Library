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
    assert @matrix.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  end

  def test_decomposition
    assert_equal @matrixSparse3x3.decompose(), [[0, 2, 0], [1, 0, 0], [0, 2, 0]]
  end

  def test_dimensions
    assert_equal @matrixSparse3x3.dimensions(), [3, 3]
  end

end

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
    assert_equal @matrixConst.scalar_multiply(2), [2,4,6,8]
  end

  def test_scalar_add
    assert_equal @matrixConst.scalar_add(2), [3,4,5,6]
  end

  def test_scalar_subtract
    assert_equal @matrixConst.scalar_subtract(1), [0,1,2,3]
  end

  def test_scalar_division
    assert_equal @matrixConst.scalar_division(2), [0.5, 1.0, 1.5, 2.0] 
  end

  # FIXME: convert everything to float with .to_f (ref: http://stackoverflow.com/questions/16563758/how-to-initialize-a-variable-to-the-type-double-in-ruby)
  def test_scalar_exp
    assert_equal @matrixConst.scalar_exp(2), [1,4,9,16]
  end

  def test_inverse
    assert_equal @matrixConst.inverse(), [1.0, 0.5, 0.3333333333333333, 0.25] 
  end

  # not implemented yet
  def test_transpose
    #assert_equal @matrixConst.transpose(), [[1,3],[2,4]]
  end

  def test_matrix_multiply
    assert_equal @matrixa.multiply_csr(@matrixb), [[7, 10], [15, 22]]
  end

  def test_is_same_dim
    assert @matrixa.is_same_dim(@matrixb)
  end

  def test_matrix_add
    assert_equal @matrixa.matrix_add(@matrixb), [[2,4],[6,8]]
  end

  def test_matrix_subtract
    assert_equal @matrixa.matrix_subtract(@matrixb), [[0,0],[0,0]]
  end

  def test_matrix_left_division
    # assert_equal @matrixa.matrix_left_division(@matrixb), [[1,0],[0,1]]
    # we multiply by the inverse of b
  end  

  def test_matrix_right_division
    # assert_equal @matrixa.matrix_left_division(@matrixb), [[1,0],[0,1]]
  end

  def test_matrix_exp
    # dev
  end 

end

class OperationsTest < Minitest::Test

  def setup
    @matrix = TwoDMatrix.new
    @matrix.build_from_array([[1,2],[3,4]])
    
    @matrixSparse3x3 = TwoDMatrix.new
    @matrixSparse3x3.build_from_array([[0, 2, 0], [1, 0, 0], [0, 2, 0]])
  end

  def test_print_full
    assert_output(/0  2  0  \n1  0  0  \n0  2  0  \n/) {
      @matrixSparse3x3.print_full()
    }
  end

end 

class PropertiesTest < Minitest::Test

  def setup
    @matrix = TwoDMatrix.new

    @matrixDense3x3 = TwoDMatrix.new
    @matrixDense3x3.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])

    @matrixSparse3x3 = TwoDMatrix.new
    @matrixSparse3x3.build_from_array([[0, 1, 0], [2, 0, 0], [0, 0, 3]])

    @matrixTrigonal3x3 = TwoDMatrix.new
    @matrixTrigonal3x3.build_from_array([[-1, 0, 0], [0, -1, 0], [0, 0, -1]])

		@matrixEmpty3x3 = TwoDMatrix.new
    @matrixEmpty3x3.build_from_array([[ , , ], [ , , ], [ , , ]])

		@matrixZero3x3 = TwoDMatrix.new
    @matrixZero3x3.build_from_array([[0, 0, 0], [0, 0, 0], [0, 0, 0]])

		@matrixHermitian3x3 = TwoDMatrix.new
		@matrixHermitian3x3.build_from_array([[2, 2+i, 4], [2-i, 3, i], [4, -i, 1]])
  end

  def test_diagonal
    assert @matrixTrigonal3x3.diagonal()
  end

	def test_empty
    assert @matrixEmpty3x3.empty()
  end

	def test_hermitian
    assert @matrixHermitian3x3.hermitian()
  end

	def test_lower_triangle
    assert @matrixTrigonal3x3.lower_triangle()
  end

	def test_normal
    assert @matrixHermitian3x3.normal()
  end

	def test_orthogonal
    assert @matrixTrigonal3x3.orthogonal()
  end

	def test_permutation
    assert @matrixSparse3x3.permutation()
  end

	def test_real
    assert @matrixSparse3x3.real()
  end

	def test_regular
    assert @matrixTrigonal3x3.regular()
  end

	def test_singular
    assert @matrixDense3x3.singular()
  end

	def test_square
    assert @matrixDense3x3.square()
  end

	def test_symmetric
    assert @matrixTrigonal3x3.symmetric()
  end

	def test_unitary
    assert @matrixTrigonal3x3.unitary()
  end

	def test_upper_triangle
    assert @matrixTrigonal3x3.symmetric()
  end

	def test_zero
    assert @matrixZero3x3.zero()
  end

end 

class DecompositionsTest < Minitest::Test

  def setup
    @matrix = TwoDMatrix.new

    @matrixDense3x3 = TwoDMatrix.new
    @matrixDense3x3.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])

    @matrixSparse3x3 = TwoDMatrix.new
    @matrixSparse3x3.build_from_array([[0, 1, 0], [2, 0, 0], [0, 0, 3]])
  end

	#alias for eigensystem
	#returns a list in the form {eigenvalues, eigenvectors}
  def test_eigen
    assert_equals @matrixDense3x3.eigen(), [[6, 0, 0], [1, 1, 1], [-3, 0, 1], [-2, 1, 0]]
  end

	def test_eigensystem
    assert_equals @matrixDense3x3.eigensystem(), [[6, 0, 0], [1, 1, 1], [-3, 0, 1], [-2, 1, 0]]
  end

	#alias for lup_decomposition
	#Need to look into this for output http://www.wolframalpha.com/input/?i=%5B%5B0%2C+1%2C+0%5D%2C+%5B2%2C+0%2C+0%5D%2C+%5B0%2C+0%2C+3%5D%5D+LU+decomposition
	def test_lup
    #assert @matrixSparse3x3.lup(), [L, U, P]
  end

	def test_lup_decomposition
    #assert @matrixSparse3x3.lup_decomposition(), [L, U, P]
  end

end
