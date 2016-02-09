module CsrMatrix
  module Helpers
		include Contracts::Core
    include Contracts::Builtin
    C = Contracts  	
		##
		# ARRAY FUNCTIONS
		# for pre-processing of matrix
		#

		Contract Array => C::Nat
		def max_col(array)
			# Identifies the 'column' value of an array (eg. the number of entries in a column)
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

		Contract Array => C::Nat
		def max_row(array)
			# Identifies the 'row' value of an array (eg. the number of entries in a row)
			values = array
			max_count = 0
			values.each_index do |i|
			  max_count += 1
			end
			return max_count
		end # max_row

		Contract Array => C::Nat
		def count_nonzero(array) 
			# Finds all nonzero values in an array.
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

		Contract Array => C::Nat
		def depth(array)
			# Code from http://stackoverflow.com/questions/9545613/getting-dimension-of-multidimensional-array-in-ruby
			# Identifies the depth of an array.
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

		Contract Array => C::Nat
    def count_total(array) 
    	# Counts all elements in array - assumed 2d
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
