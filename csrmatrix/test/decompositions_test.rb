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
		assert_equal [[6, 0, 0], [1, 1, 1], [-3, 0, 1], [-2, 1, 0]], @matrixDense3x3.eigen()
  end

	def test_eigensystem
		assert_equal [[6, 0, 0], [1, 1, 1], [-3, 0, 1], [-2, 1, 0]], @matrixDense3x3.eigensystem()
  end

	#alias for lup_decomposition
	#returns a list of matrices {L, U}
	#Reference: http://nucinkis-lab.cc.ic.ac.uk/HELM/workbooks/workbook_30/30_3_lu_decomposition.pdf
	def test_lup
    assert_equal [[[1, 0, 0], [3, 1, 0], [2, 1, 1]], [[1, 2, 4], [0, 2, 2], [0, 0, 3]]], @matrixLUP3x3.lup()
  end

	def test_lup_decomposition
    assert_equal [[[1, 0, 0], [3, 1, 0], [2, 1, 1]], [[1, 2, 4], [0, 2, 2], [0, 0, 3]]], @matrixLUP3x3.lup_decomposition()
  end

end
