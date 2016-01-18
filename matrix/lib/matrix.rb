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

			dimensions = get_col_row_count(array)
			column = dimensions[0] # Replace with: array[1].length no need for additional method.
			row = dimensions[1] # Replace with: array.length
			nonzero_count = dimensions[2]
			# 2.1 initialise the matrix values
			@val = dimensions[3]
			@row_ptr = Array.new(nonzero_count)
			@col_ind = Array.new(nonzero_count)
			# 3. check the first nonzero point and check its location; fill as necessary.
			# 4. repeat and clean
			# X. debugger statements
			puts "There are #{nonzero_count} nonzero entities in the array."
			puts "Dimensions, by column x row, are #{column} x #{row}"
			puts "Values are: #{@val}"
		end
	end	

	# Builds array using user-generated CSR values
	def build_from_csr(row_ptr, col_ind, val, col_siz, row_siz)
		# generate 
	end

	# Finds the column count, row count and non-zero values in one loop. 
	# Generate for optimization.
	def get_col_row_count(array)
		row_count = 0
		col_count = 0
		nonzero_count = 0
		value_array = Array.new
		array.each_index do |i|
			col_tmp = 0
			row_count += 1
			subarray = array[i]
			subarray.each_index do |x|
				col_tmp += 1
				if array[i][x] != 0
		  		nonzero_count += 1
		  		value_array << array[i][x]
		  	end
			end
			if col_tmp >= col_count
				col_count = col_tmp
			end
		end
		return [col_count, row_count, nonzero_count, value_array]
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

	def count_nonzero(array) 
		max_count = 0
		array.each_index do |i|
			subarray = array[i]
		  subarray.each_index do |x|
		  	if array[i][x] != 0
		  		max_count += 1
		  	end
		  end
		end
		return max_count
	end

	# Finds column and row value of an array. 
	def dimensions(array)
		column = max_col(array)
		row = max_row(array)
		return [column, row]
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