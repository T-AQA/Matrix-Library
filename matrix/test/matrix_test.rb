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
	end

	def test_demo_show
		multiarray = [[1,2,3], [1,2,3]]
		puts "**Demo Intro**"
		puts @matrix.demo_show(multiarray)
		puts "**End demo intro**"
	end

	def test_demo_by_index
		multiarray = [[1,2,3], [1,2,3]]
		puts "**Demo by Index**"
		puts @matrix.demo_by_index(multiarray)
		puts "**End demo by index**"
	end

end