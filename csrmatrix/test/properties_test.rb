require "minitest/autorun"
require "csrmatrix"

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
    @matrixEmpty3x3.build_from_array([[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])

		@matrixZero3x3 = TwoDMatrix.new
    @matrixZero3x3.build_from_array([[0, 0, 0], [0, 0, 0], [0, 0, 0]])

		#@matrixHermitian3x3 = TwoDMatrix.new
		#@matrixHermitian3x3.build_from_array([[2, 2+i, 4], [2-i, 3, i], [4, -i, 1]])
  end

  def test_diagonal
    assert @matrixTrigonal3x3.diagonal()
  end

	def test_empty
    assert @matrixEmpty3x3.empty()
  end

	def test_hermitian
    # FIXME: no imaginary character construction yet
    # assert @matrixHermitian3x3.hermitian()
  end

	def test_lower_triangle
    assert @matrixTrigonal3x3.lower_triangular()
  end

	def test_normal
    assert @matrixSparse3x3.normal()
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

	def test_nonsingular
    assert @matrixTrigonal3x3.nonsingular()
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