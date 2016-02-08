require "matrix"
require "csrmatrix/exceptions"

module CsrMatrix
    module Properties

      def self.included(exceptions)
        exceptions.send :include, Exceptions
      end 
      
      def diagonal?
      	# Determines if the matrix is diagonal; wherein the values outside the main diagonal are all zero.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        for i in 0..self.columns-1
					if (self.col_ind[i] != i) || (self.row_ptr[i] != i)
						return false
					end
				end
				return true
      end # diagonal?

      def empty?
        # Determines if the matrix is empty; wherein all the values are zero.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
				if self.val.count() == 0
					return true
				end
				return false
      end # empty?

      def lower_triangular?
        # Determines if the matrix is lower-diagonal; wherein all the values only exist on and below the diagonal line.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
				for i in 0..self.columns-1
					for column_index in row_ptr[i]..row_ptr[i+1]-1
						if (self.col_ind[column_index] > i)
							return false
						end
					end
				end
				return true
      end # lower_triangular?

      def normal? 
        # Determines if the matrix is normal
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
  			if !self.square?
  			  raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end

        m = Matrix.rows(self.decompose)
        return m.normal?
      end # normal?

      def orthogonal?
        # Determines if the matrix is orthogonal; wherein the rows and columns are orthogonal unit vectors.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        if !self.square?
          raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
	
				# transpose the existing matrix
				@matrix_transpose = TwoDMatrix.new
				@matrix_transpose.build_from_csr(self.row_ptr, self.col_ind, self.val, self.columns, self.rows)
				@matrix_transpose.transpose()

				# build an orthogonal matrix
				@matrix_orthogonal = TwoDMatrix.new
				@matrix_orthogonal.build_from_array(self.multiply_csr(@matrix_transpose))
				
				# test the values in the orthogonal matrix
				for i in 0..@matrix_orthogonal.val.count()-1
					if @matrix_orthogonal.val[i] != 1
						return false
					end
				end
				return true
      end # orthogonal?

      def permutation?
        # Determines if the matrix is a permutation; wherein it is an nxn version of the identity matrix.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
		    if !self.square?
			    raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.permutation?
      end # permutation?

      def real?
        # Determines if the matrix is real; wherein the matrix consists entirely of real numbers.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        for value in self.val
					if !value.is_a? Numeric
						return false
					end
				end
				return true
      end # real?

      def not_null?
        if @val == nil
          return false
        end
        return true
      end

      def nonsingular?
        # Determines if the matrix is nonsingular ; simply the inverse of the singular function
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        return !self.singular?
      end # nonsingular?

      def singular?
        # Determines if the matrix is singular
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        m = Matrix.rows(self.decompose)
        return m.singular?
      end # singular?

      def symmetric?
        # Determines if the matrix is symmetric
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
  			if !self.square?
  				raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.symmetric?
      end # symmetric? 

      def unitary?
        # Determines if the matrix is unitary
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
  			if !self.square?
  				raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.unitary?
      end # unitary?

      def upper_triangular?
        # Determines if the matrix is upper-triangular
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        for i in 0..self.columns-1
					for column_index in row_ptr[i]..row_ptr[i+1]-1
						if (self.col_ind[column_index] < i)
							return false
						end
					end
				end
				return true
      end # upper triangular?

      def zero?
        # Determines if the matrix is zero
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        for value in self.val
					if value != 0
						return false
					end
				end
				return true
      end # zero?

    end # Properties
end # CsrMatrix
