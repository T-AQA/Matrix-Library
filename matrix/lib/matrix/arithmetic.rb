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
      @val.each_index do |i|
        @val[i] = @val[i] / value
      end
    end

    def scalar_exp(value)
      @val.each_index do |i|
        @val[i] = @val[i] ** value
      end
    end

    def inverse()
      @val.each_index do |i|
        @val[i] = 1/@val[i]
      end
    end

    def transpose()

    end

    def matrix_vector(vector) 
      # dev based on http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/3-C/sparse.html
      result = Array.new(vector.length, 0)
      i = 0
      while i < vector.length do
        k = @row_ptr[i]
        while k < @row_ptr[i+1] do
          result[i] = result[i] + @val[k] * vector[@col_ind[k]]
          k += 1
        end
        i += 1
      end   
      return result
    end   

    # dev based on http://stackoverflow.com/questions/29598299/csr-matrix-matrix-multiplication
    # multiply dense (non-dense) matrix to csr matrix [eg. [1, 2]] x 2d array
    # key: the dense matrix is LEFT SIDE, the csr matrix is RIGHT SIDE
    def matrix_multiply(matrix)
      # matrix order, assumes both matrices are square
      res = Array.new(max_row(matrix)) { Array.new(@columns, 0) } # first denotes row, second denotes columns
      n = matrix.length
      i = 0
      # res = dense X csr
      csr_row = 0 # Current row in CSR matrix
      while i < n do
        startv = @row_ptr[i] 
        endv = @row_ptr[i + 1]
        j = startv
        while j < endv do
          col = @col_ind[j]
          csr_value = @val[j]
          k = 0
          while k < n do
            dense_value = matrix[k][csr_row]
            res[k][col] += csr_value * dense_value
            k += 1
          end
          j += 1
        end
        csr_row += 1
        i += 1
      end
      return res
    end

    # multiply two csr together - ref: http://www.mcs.anl.gov/papers/P5007-0813_1.pdf
    def multiply_csr(matrix)
      return matrix.matrix_multiply(self.decompose())
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