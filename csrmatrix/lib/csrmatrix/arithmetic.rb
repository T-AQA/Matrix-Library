require "matrix"
require "csrmatrix/exceptions"

module CsrMatrix    
  module Arithmetic

    # Brings in exception module for exception testing
    def self.included(exceptions)
      exceptions.send :include, Exceptions
    end

    # multiply the matrix by a scalar value
    def scalar_multiply(value)
      # multiply the matrix by a scalar value
      # pre   value to multiply, existing matrix (matrix.not_null)
      # post  boolean, updated matrix
      if value == nil
        raise Exceptions::ArgumentNullException.new, "Multiply by nil error."
        return false
      end
      @val.each_index do |i|
        @val[i] = @val[i] * value
      end
    end
    
    def scalar_add(value)
      # manipulate the matrix by adding a value at each index
      # pre   value to add by, existing matrix (matrix.not_null)
      # post  boolean, updated matrix
      if value == nil
        raise Exceptions::ArgumentNullException.new, "Add by nil error."
        return false
      end
      @val.each_index do |i|
        @val[i] = @val[i] + value
      end
    end

    def scalar_subtract(value)
      # manipulate the matrix by subtracting the value at each index
      # pre   value to subtract by, existing matrix (matrix.not_null)
      # post  boolean, updated matrix
      if value == nil
        raise Exceptions::ArgumentNullException.new, "Subtract by nil error."
        return false
      end
      @val.each_index do |i|
        @val[i] = @val[i] - value
      end
    end

    def scalar_division(value)
      # manipulate the matrix by dividing the value at each index
      # pre   value to divide by, existing matrix (matrix.not_null)
      # post  boolean, updated matrix (in floats, if previously was not)
      if value == nil
        raise Exceptions::ArgumentNullException.new, "Divide by nil error."
        return false
      end
      @val.each_index do |i|
        @val[i] = @val[i] / value.to_f
      end
    end

    def scalar_exp(value)
      # manipulate teh matrix by finding the exponential at each index
      # pre   value to set exponent by, existing matrix (matrix.not_null)
      # post  boolean, updated matrix
      if value == nil
        raise Exceptions::ArgumentNullException.new, "Exp. by nil error."
        return false
      end
      @val.each_index do |i|
        @val[i] = @val[i] ** value
      end
    end

    def inverse()
      # sets the inverse of this matrix
      # pre   existing matrix (matrix.not_null)
      # post  inverted matrix
      m = Matrix.rows(self.decompose)
      self.build_from_array(m.inv().to_a())
    end

    def transpose()
      # transposes the matrix 
      # pre   existing matrix (matrix.not_null)
      # post  array of decomposed matrix values
      m = Matrix.rows(self.decompose)
      self.build_from_array(m.transpose.to_a())
    end

    def t()
      # transposes the matrix 
      # pre   existing matrix (matrix.not_null)
      # post  array of decomposed matrix values
      self.transpose()
    end

    def matrix_vector(vector) 
      # dev based on http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/3-C/sparse.html
      # multiplies the matrix by a vector value (in array form)
      # pre   vector
      # post  array, with results
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
    def matrix_multiply(matrix)
      # multiply dense (non-dense) matrix to csr matrix [eg. [1, 2]] x 2d array
      # pre   matrix to multiply, existing matrix (matrix.not_null)
      # post  array holding resulting matrix
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

    def multiply_csr(matrix)
      # multiply two csr together - ref: http://www.mcs.anl.gov/papers/P5007-0813_1.pdf
      # pre   matrix to multiply, existing matrix (matrix.not_null)
      # post  array holding decomposed result
      return matrix.matrix_multiply(self.decompose())
    end 

    def is_same_dim(matrix)
      # helper function to determine deim count is equal
      # pre   matrix to test, existing matrix (matrix.not_null)
      # post  boolean
      return self.dimensions() == matrix.dimensions()
    end

    def matrix_add(matrix)
      # adds a matrix to existing matrix
      # pre   matrix to add, existing matrix (matrix.not_null)
      # post  boolean, resulting matrix
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
      raise Exceptions::MatrixDimException.new, "Matrix does not have same dimensions; cannot add."
      return false
    end

    def matrix_subtract(matrix)
      # subtracts a matrix to existing matrix
      # pre   matrix to add, existing matrix (matrix.not_null)
      # post  boolean, resulting matrix
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
      raise Exceptions::MatrixDimException.new, "Matrix does not have same dimensions; cannot subtract."
      return false
    end

    def multiply_inverse(matrix)
      # divides (multiply by the inverse of ) a matrix to existing matrix
      # sets y * x^-1, where x is your matrix and y is the accepted matrix
      # pre   matrix to divide, existing matrix (matrix.not_null)
      # post  boolean, resulting matrix
      if !matrix.is_a?(TwoDMatrix)
        raise Exceptions::MatrixTypeException.new, "Matrix is not usable type."
        return false
      end
      if !matrix.square? || !self.square?
        raise Exceptions::MatrixDimException.new, "Matrices does not have usable dimensions; cannot divide."
        return false
      end
      tmpmatrix = TwoDMatrix.new
      tmpmatrix = matrix
      tmpmatrix.inverse()
      return self.multiply_csr(tmpmatrix)
    end

    # multiply x by y^-1; x * y^-1 
    def inverse_multiply(matrix)
      # divides (multiply by the inverse of ) a matrix to existing matrix
      # sets x * y^-1, where x is your matrix and y is the accepted matrix
      # pre   matrix to divide, existing matrix (matrix.not_null)
      # post  boolean, resulting matrix
      if !matrix.is_a?(TwoDMatrix)
        raise Exceptions::MatrixTypeException.new, "Matrix is not usable type."
        return false
      end
      if !matrix.square? || !self.square?
        raise Exceptions::MatrixDimException.new, "Matrices does not have usable dimensions; cannot divide."
        return false
      end
      tmpmatrix = TwoDMatrix.new
      tmpmatrix = self
      tmpmatrix.inverse()
      return matrix.multiply_csr(tmpmatrix)
    end

     def matrix_division(matrix)
      # linear division of one matrix to the next
      # pre   matrix to divide, existing matrix (matrix.not_null)
      # post  boolean, resulting matrix
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
            if matrix.val[cntb] == 0
              raise Exceptions::DivideByZeroException.new, "Cannot divide by zero."
              return false
            end 
            res[row_idx][@col_ind[cntb]] = res[row_idx][@col_ind[cntb]].to_f / matrix.val[cntb]
            cntb += 1;
          end  
          row_idx += 1;
        end
        return res
      end 
      raise Exceptions::MatrixDimException.new, "Matrix does not have same dimensions; cannot add."
      return false
    end

    def max_row(array)
      # Identifies the 'row' value of an array (eg. the number of entries in a row)
      # pre   array
      # post  integer of row count
      values = array
      max_count = 0
      values.each_index do |i|
        max_count += 1
      end
      return max_count
    end

  end 
end
