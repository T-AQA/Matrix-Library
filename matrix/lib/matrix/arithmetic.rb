module Matrix    
  module Arithmetic
    def scalar_multiply(value)
      @val.each_index do |i|
        @val[i] = @val[i] * value
      end
    end
    
    def scalar_add(value)
      # create an identity matrix with the value
      # matrix_add the new identity matrix to the given matrix
    end

    def scalar_subtract(value)
      # create an identity matrix with the value
      # matrix_subtract the new identity matrix to the given matrix
    end

    def scalar_division(value)

    end

    def scalar_exp(value)

    end

    def inverse()

    end

    def transpose()

    end

    def matrix_vector(vector) 
      # dev based on http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/3-C/sparse.html
      result = Array.new(vector.length, 0)
      i = 0
      while i < vector.length do
        puts "i = #{i}"
        k = @row_ptr[i]
        while k < @row_ptr[i+1] do
          puts "vector[k] = #{vector[k]}"
          puts "result = #{result}"
          result[i] = result[i] + @val[k] * vector[@col_ind[k]]
          k += 1
        end
        i += 1
      end   
      return result
    end   

    def matrix_multiply(matrix)
      
    end
    
    def matrix_add(matrix)

    end

    def matrix_subtract(matrix)

    end

    def matrix_left_division(matrix)

    end

      def matrix_right_division(matrix)

      end

      def matrix_exp(matrix)

      end
  end 
end