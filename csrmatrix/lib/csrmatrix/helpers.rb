module CsrMatrix
  module Helpers
  	
		##
		# ARRAY FUNCTIONS
		# for pre-processing of matrix
		#

		def max_col(array)
			# Identifies the 'column' value of an array (eg. the number of entries in a column)
			# pre 	array
			# post 	column count of array
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
		end # max_col

		def max_row(array)
			# Identifies the 'row' value of an array (eg. the number of entries in a row)
			# pre 	array
			# post 	row count of array
			values = array
			max_count = 0
			values.each_index do |i|
			  max_count += 1
			end
			return max_count
		end # max_row

		def count_nonzero(array) 
			# Finds all nonzero values in an array.
			# pre 	array 
			# post 	int nonzero count of array
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
		end # count_nonzero

		def depth(array)
			# Code from http://stackoverflow.com/questions/9545613/getting-dimension-of-multidimensional-array-in-ruby
			# Identifies the depth of an array.
			# pre 	array
			# post 	int depth of array
	    return 0 if array.class != Array
			result = 1
			array.each do |sub_a|
			  if sub_a.class == Array
			    dim = depth(sub_a)
			    result = dim + 1 if dim + 1 > result
			  end
			end
			return result
		end	# depth

    def count_total(array) 
    	# Counts all elements in array - assumed 2d
    	# pre 	array
    	# post 	int count of all elements
      max_count = 0
      array.each_index do |i|
        subarray = array[i]
        subarray.each_index do |x|
          max_count += 1
        end
      end
      return max_count
    end # count_total
	
  end # Helpers
end # CsrMatrix
