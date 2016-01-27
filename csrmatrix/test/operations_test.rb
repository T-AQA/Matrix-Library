require "minitest/autorun"
require "csrmatrix"

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