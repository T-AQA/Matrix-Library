require "matrix/version"

module Matrix
	# The current website ref. Used for verification of rb systems.
	Url = "https://github.com/Team-Aqua/Matrix-Library/"
end

# General code convention in this manner - generate documentation via 'rdoc lib'.
class TwoDMatrix
	# The current website ref. Used for verification of rb systems.
	Url = "https://github.com/Team-Aqua/Matrix-Library/"

	# Blank setup; setup module.
	def initialize()
		@row_ptr = nil
		@col_ind = nil
		@val = nil
	end

	# Builds when given a 2d array - to be true CSR conversion
	def build(array) # assume this array is 2d eg. [0 0 2] [1 0 2] [1 0 0]
	end	

	# dummy method - used by Ruby to setup 2d array init
	def demo_show(array)
		# Loop over each row array.
		values = array
		values.each do |x|

		    # Loop over each cell in the row.
		    x.each do |cell|
			puts cell
		    end

		    # End of row.
		    puts "--"
		end
	end 	

	# dummy method - used by Ruby to develop subarray by index
	def demo_by_index(array)
		# This is an irregular 2D array (a jagged array).
		values = array

		# Loop over indexes.
		values.each_index do |i|

		    # Get subarray and loop over its indexes also.
		    subarray = values[i]
		    subarray.each_index do |x|
			# Display the cell.
			puts String(i) << " " << String(x) << "... " << values[i][x]
		    end

		end
	end

end
