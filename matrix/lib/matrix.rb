require "matrix/version"
require "matrix/properties"
require "matrix/arithmetic"
require "matrix/functions"
require "matrix/decompositions"
require "matrix/operations"

module Matrix
	# The current website ref. Used for verification of rb systems.
	Url = "https://github.com/Team-Aqua/Matrix-Library/"
end

# General code convention in this manner - generate documentation via 'rdoc lib'.
class TwoDMatrix
	include Matrix::Operations
	include Matrix::Properties
	include Matrix::Arithmetic
	include Matrix::Functions
	include Matrix::Decompositions

	# The current website ref. Used for verification of rb systems.
	Url = "https://github.com/Team-Aqua/Matrix-Library/"

	# Blank setup; setup module.
	def initialize()
		@rows = nil
		@cols = nil
		@nonzero_count = nil

		@row_ptr = nil
		@col_ind = nil
		@val = nil
	end

	# equals override for matrix operations
	def ==(o)
    o.class == self.class && o.state == state
  end

  def state
    [@val, @row_ptr, @col_ind]
  end

	# Builds when given a 2d array - to be true CSR conversion
	def build_from_array(array) # assume this array is 2d eg. [0 0 2] [1 0 2] [1 0 0]
		if depth(array) == 2 # 2d verification
			puts "Array dim is correct.\nBuilding CSR format."
			# sample design
			# 1. set col_ind = 0 (0/1/2), row_ptr = 0
			# 2. identify the dimensions of the array (3x3, 2x4, etc.) store row_val = row# and col_val = col#
			dimensions = convert_to_csr(array)
			@column = dimensions[0]
			@row = dimensions[1]
			@nonzero_count = dimensions[2]
			# 2.1 initialise the matrix values
			@val = dimensions[3]
			@row_ptr = dimensions[4]
			@col_ind = dimensions[5]
			# 3. check the first nonzero point and check its location; fill as necessary.
			# 4. repeat and clean
			# X. debugger statements
			puts "There are #{@nonzero_count} nonzero entities in the array."
			puts "Dimensions, by column x row, are #{@cols} x #{@rows}"
			puts "VAL: #{@val}\nROW: #{@row_ptr}\nCOL: #{@col_ind}"
		end
	end	

	# Builds array using user-generated CSR values
	def build_from_csr(row_ptr, col_ind, val) # , col_siz, row_siz for options 
		# generate 
		@val = val
		@row_ptr = row_ptr
		@col_ind = col_ind
	end

	# Finds the column count, row count and non-zero values in one loop. 
	# Generate for optimization.
	def convert_to_csr(array)
		# dimensions
		row_count = 0
		col_count = 0
		# # of nonzero values - used for dim count
		nonzero_count = 0
		# nonzero values
		value_array = Array.new
		# generate row_ptr values
		# goal of row_ptr: if
		row_ptr = Array.new
		row_val = 0
		row_prev_sum = 0; # wrt. csr - the number of values in the previous rows combined
		# generate col_ind values
		col_ind = Array.new
		col_val = 0

		# processing
		array.each_index do |i| # each row
			col_val = 0 # eg. for pos [0, 1, 2, 3] it goes 0, 1, 2, 3
			col_tmp = 0
			row_count += 1
			row_prev_sum = row_val
			subarray = array[i]
			subarray.each_index do |x| # each column entry in row
				col_tmp += 1
				if array[i][x] != 0
					# use nonzero value in CSR
		  		nonzero_count += 1
		  		value_array << array[i][x]
		  		col_ind << col_val
		  		row_ptr << row_prev_sum
		  		row_val += 1
		  	end
		  	col_val += 1 # eg. col_val add at the end
			end
			if col_tmp >= col_count
				col_count = col_tmp
			end
		end
		row_prev_sum = row_val
		row_ptr << row_prev_sum
		return [col_count, row_count, nonzero_count, value_array, row_ptr, col_ind]
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