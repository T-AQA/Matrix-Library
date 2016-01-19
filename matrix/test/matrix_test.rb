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

	# def test_demo_show
	# 	multiarray = [[1,2,3], [1,2,3]]
	# 	puts "**Demo Intro**"
	# 	puts @matrix.demo_show(multiarray)
	# 	puts "**End demo intro**"
	# end

	# def test_demo_by_index
	# 	multiarray = [[1,2,3], [1,2,3]]
	# 	puts "**Demo by Index**"
	# 	puts @matrix.demo_by_index(multiarray)
	# 	puts "**End demo by index**"
	# end

    def test_build_from_array
        @matrix.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    end

    def test_dimensions
        #assert_equal @matrixSparse3x3.dimensions(), [3, 3]
    end

    def test_print_full
        assert_output(/0  2  0  \n1  0  0  \n0  2  0  \n/) {@matrixSparse3x3.print_full()}
    end

end