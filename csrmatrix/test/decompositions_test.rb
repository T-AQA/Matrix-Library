require "minitest/autorun"
require "csrmatrix"

class DecompositionsTest < Minitest::Test

  def setup
    @matrix = TwoDMatrix.new

    @matrixDense3x3 = TwoDMatrix.new
    @matrixDense3x3.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])

		@matrixLUP3x3 = TwoDMatrix.new
		@matrixLUP3x3.build_from_array([[1, 2, 4], [3, 8, 14], [2, 6, 13]])
  end

	#alias for eigensystem
	#returns a list in the form {eigenvalues, eigenvectors}
  def test_eigen
		assert_equal [[0, 0, 0], [0, 6, 0], [0, 0, 0]], @matrixDense3x3.eigen()
  end

	def test_eigenvalue
		assert_equal [[0, 0, 0], [0, 6, 0], [0, 0, 0]], @matrixDense3x3.eigenvalue()
  end

end
