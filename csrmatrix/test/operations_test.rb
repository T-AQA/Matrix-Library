require "minitest/autorun"
require "csrmatrix"

class OperationsTest < Minitest::Test

  def setup
    @matrix = TwoDMatrix.new
    @matrix.build_from_array([[1,2],[3,4]])
    
    @matrixSparse3x3 = TwoDMatrix.new
    @matrixSparse3x3.build_from_array([[0, 2, 0], [1, 0, 0], [0, 2, 0]])
  end

	def test_insert
		@matrixSparse3x3.insert(1, 3, 1)
		assert_equal [[0, 2, 0], [1, 0, 0], [1, 2, 0]], @matrixSparse3x3.decompose()

		@matrixSparse3x3.insert(3, 1, 3)
		assert_equal [[0, 2, 3], [1, 0, 0], [1, 2, 0]], @matrixSparse3x3.decompose()

		@matrixSparse3x3.insert(1, 1, 2)
		assert_equal [[0, 1, 3], [1, 0, 0], [1, 2, 0]], @matrixSparse3x3.decompose()
	end

  def test_print_full
    assert_output(/1  2  \n3  4  \n/) {
      @matrix.print_full()
    }

    assert_output(/0  2  0  \n1  0  0  \n0  2  0  \n/) {
      @matrixSparse3x3.print_full()
    }

  end

end 
