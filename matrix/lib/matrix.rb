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
	def build_from_array(array) # assume this array is 2d eg. [0 0 2] [1 0 2] [1 0 0]
		if depth(array) == 2 # 2d verification
			puts "Array dim is correct.\nBuilding CSR format."
			# sample design
			# 1. set col_ind = 0 (0/1/2), row_ptr = 0
			# 2. identify the dimensions of the array (3x3, 2x4, etc.) store row_val = row# and col_val = col#
			# 3. check the first nonzero point and check its location; fill as necessary.
			# 4. repeat and clean
		end
	end	

	# Builds array using user-generated CSR values
	def build_from_csr(row_ptr, col_ind, val, col_siz, row_siz)
		# generate 
	end

	# Identifies the 'column' value of an array (eg. the number of entries in a column)
	# Todo: optimize system for O(cn), if possible
	def max_col(array)
		values = array
		max_count = 0
		# Loop over indexes.
		values.each_index do |i|
			counter = 0
		  # Get subarray and loop over its indexes also.
		  subarray = values[i]
		  subarray.each_index do |x|
		  	counter += 1
		  end
		  if counter > max_count
		  	max_count = counter
		  end
		end
		return max_count
	end

	# Identifies the 'row' value of an array (eg. the number of entries in a row)
	def max_row(array)
		values = array
		max_count = 0
		# Loop over indexes.
		values.each_index do |i|
		  # Get subarray and loop over its indexes also.
		  max_count += 1
		end
		return max_count
	end

	def dimensions(array)
		column = max_col(array)
		row = max_row(array)
		puts "Dimensions, by column x row, are #{column} x #{row}"
	end

	# Code taken from http://stackoverflow.com/questions/9545613/getting-dimension-of-multidimensional-array-in-ruby
	def depth(array)
    	return 0 if array.class != Array
		  result = 1
		  array.each do |sub_a|
		    if sub_a.class == Array
		      dim = depth(sub_a)
		      result = dim + 1 if dim + 1 > result
		    end
		  end
		  return result
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