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
      @val.each_index do |i|
        @val[i] = @val[i] + value
      end
    end

    def scalar_subtract(value)
      # create an identity matrix with the value
      # matrix_subtract the new identity matrix to the given matrix
      @val.each_index do |i|
        @val[i] = @val[i] - value
      end
    end

    def scalar_division(value)
      @val.each_index do |i|
        @val[i] = @val[i] / value.to_f
      end
    end

    def scalar_exp(value)
      @val.each_index do |i|
        @val[i] = @val[i] ** value
      end
    end

    def inverse()
      @val.each_index do |i|
        @val[i] = 1/@val[i].to_f
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

    def is_same_dim(matrix)
      return self.dimensions() == matrix.dimensions()
    end
    
    def matrix_add(matrix)
      if self.is_same_dim(matrix)
        res = Array.new(@rows) { Array.new(@columns, 0) }
        row_idx = 0
        cnta = 0 # total logged entries for matrix a 
        cntb = 0
        while row_idx < @rows # eg. 0 1 2
          rowa = @row_ptr[row_idx + 1] # eg. 0 2 4 7
          rowb = matrix.row_ptr[row_idx + 1]
          while cnta < rowa
            # keep adding values to res until they're equal
            res[row_idx][@col_ind[cnta]] += @val[cnta]
            cnta += 1;
          end
          while cntb < rowb
            res[row_idx][@col_ind[cntb]] += matrix.val[cntb]
            cntb += 1;
          end  
          row_idx += 1;
        end
        return res
      end 
      puts "Matrix does not have same dimensions; cannot add."
      return false
    end

    def matrix_subtract(matrix)
      if self.is_same_dim(matrix)
        res = Array.new(@rows) { Array.new(@columns, 0) }
        row_idx = 0
        cnta = 0 # total logged entries for matrix a 
        cntb = 0
        while row_idx < @rows # eg. 0 1 2
          rowa = @row_ptr[row_idx + 1] # eg. 0 2 4 7
          rowb = matrix.row_ptr[row_idx + 1]
          while cnta < rowa
            # keep adding values to res until they're equal
            res[row_idx][@col_ind[cnta]] += @val[cnta]
            cnta += 1;
          end
          while cntb < rowb
            res[row_idx][@col_ind[cntb]] -= matrix.val[cntb]
            cntb += 1;
          end  
          row_idx += 1;
        end
        return res
      end 
      puts "Matrix does not have same dimensions; cannot subtract."
      return false
    end

    # dev
    def matrix_left_division(matrix)
      tmpmatrix = TwoDMatrix.new
      tmpmatrix = matrix
      tmpmatrix.inverse()
      return self.multiply_csr(tmpmatrix)
    end

    # dev
    def matrix_right_division(matrix)
      tmpmatrix = TwoDMatrix.new
      tmpmatrix = self
      tmpmatrix.inverse()
      return matrix.multiply_csr(tmpmatrix)
    end

    def matrix_exp(matrix)

    end

    # Identifies the 'row' value of an array (eg. the number of entries in a row)
    # Helper function, will clean after.
    def max_row(array)
      values = array
      max_count = 0
      values.each_index do |i|
        max_count += 1
      end
      return max_count
    end

  end 
end