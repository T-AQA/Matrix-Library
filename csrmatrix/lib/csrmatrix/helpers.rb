module CsrMatrix
  module Helpers
  	
		##
		# ARRAY FUNCTIONS
		# for pre-processing of matrix
		#

		# Identifies the 'column' value of an array (eg. the number of entries in a column)
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
			values.each_index do |i|
			  max_count += 1
			end
			return max_count
		end

		# Finds all nonzero values in an array.
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

		# Identifies the depth of an array.
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

		# Counts all elements in array - assumed 2d
    def count_total(array) 
      max_count = 0
      array.each_index do |i|
        subarray = array[i]
        subarray.each_index do |x|
          max_count += 1
        end
      end
      return max_count
    end
	
  end
end
