require "minitest/autorun"
require "csrmatrix"

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
		assert_equal [[6, 0, 0], [1, 1, 1], [-3, 0, 1], [-2, 1, 0]], @matrixDense3x3.eigen()
  end

	def test_eigensystem
		assert_equal [[6, 0, 0], [1, 1, 1], [-3, 0, 1], [-2, 1, 0]], @matrixDense3x3.eigensystem()
  end

	#alias for lup_decomposition
	#Need to look into this for output http://www.wolframalpha.com/input/?i=%5B%5B0%2C+1%2C+0%5D%2C+%5B2%2C+0%2C+0%5D%2C+%5B0%2C+0%2C+3%5D%5D+LU+decomposition
	def test_lup
    #assert_equal [L, U, P], @matrixSparse3x3.lup()
  end

	def test_lup_decomposition
    #assert_equal [L, U, P], @matrixSparse3x3.lup_decomposition()
  end

end