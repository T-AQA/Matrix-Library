require "matrix"
require "csrmatrix/exceptions"
require "contracts"

module CsrMatrix
  module Properties
    include Contracts::Core
    C = Contracts

    def self.included(exceptions)
      exceptions.send :include, Exceptions
    end 
    
    Contract C::None => C::Bool
    def diagonal?
    	# Determines if the matrix is diagonal; wherein the values outside the main diagonal are all zero.
      is_invariant?
      for i in 0..self.columns-1
				if (self.col_ind[i] != i) || (self.row_ptr[i] != i)
					return false
				end
			end
			return true
    end # diagonal?

    Contract C::None => C::Bool
    def empty?
      # Determines if the matrix is empty; wherein all the values are zero.
      is_invariant?
			if self.val.count() == 0
				return true
			end
			return false
    end # empty?

    Contract C::None => C::Bool
    def square?
      # returns whether or not the system is square
      is_invariant?
      return self.rows == self.columns
    end # square?

    Contract C::None => C::Bool
    def lower_triangular?
      # Determines if the matrix is lower-diagonal; wherein all the values only exist on and below the diagonal line.
      is_invariant?
			for i in 0..self.columns-1
				for column_index in row_ptr[i]..row_ptr[i+1]-1
					if (self.col_ind[column_index] > i)
						return false
					end
				end
			end
			return true
    end # lower_triangular?

		#USES COMPLEX MATRIX
    Contract C::None => C::Bool
    def normal? 
      # Determines if the matrix is normal
      is_invariant?
			if !self.square?
			  raise Exceptions::MatrixDimException.new, "Matrix is not square."
        return false
      end

      m = Matrix.rows(self.decompose)
      return m.normal?
    end # normal?

    Contract C::None => C::Bool
    def orthogonal?
      # Determines if the matrix is orthogonal; wherein the rows and columns are orthogonal unit vectors.
      is_invariant?
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

    Contract C::None => C::Bool
    def permutation?
      # Determines if the matrix is a permutation; wherein it is an nxn version of the identity matrix.
      is_invariant?
	    if !self.square?
		    raise Exceptions::MatrixDimException.new, "Matrix is not square."
        return false
      end

			#Check the proper number of values
			if self.val.length != self.columns
				return false
			end

			#check for the proper values. ie only 1's				
			for value in self.val
				if value != 1
					return false
				end
			end

			column_ind = self.col_ind
      for column_index in self.col_ind
				if column_ind.include?(column_index)
					column_ind.remove(column_index)
				else
					return false
				end
			end
    end # permutation?

    Contract C::None => C::Bool
    def real?
      # Determines if the matrix is real; wherein the matrix consists entirely of real numbers.
      is_invariant?
      for value in self.val
				if !value.is_a? Numeric
					return false
				end
			end
			return true
    end # real?

    Contract C::None => C::Bool
    def not_null?
      if @val == nil
        return false
      end
      return true
    end

    Contract C::None => C::Bool
    def nonsingular?
      # Determines if the matrix is nonsingular ; simply the inverse of the singular function
      is_invariant?
      return !self.singular?
    end # nonsingular?

    Contract C::None => C::Bool
    def singular?
      # Determines if the matrix is singular
      is_invariant?
      if self.determinant != 0
				return false
			end
			return true
    end # singular?

    Contract C::None => C::Bool
    def symmetric?
      # Determines if the matrix is symmetric
      is_invariant?
			if !self.square?
				raise Exceptions::MatrixDimException.new, "Matrix is not square."
        return false
      end
			
      # transpose the existing matrix
			@matrix_transpose = TwoDMatrix.new
			@matrix_transpose.build_from_csr(self.row_ptr, self.col_ind, self.val, self.columns, self.rows)
			@matrix_transpose.transpose()

			for i in 0..self.val.count()-1
				if self.val[i] != @matrix_transpose.val[i]
					return false
				end
			end
			return true
    end # symmetric? 

		#USES COMPLEX MATRIX
    Contract C::None => C::Bool
    def unitary?
      # Determines if the matrix is unitary
      is_invariant?
			if !self.square?
				raise Exceptions::MatrixDimException.new, "Matrix is not square."
        return false
      end
      m = Matrix.rows(self.decompose)
      return m.unitary?
    end # unitary?

    Contract C::None => C::Bool
    def upper_triangular?
      # Determines if the matrix is upper-triangular
      is_invariant?
      for i in 0..self.columns-1
				for column_index in row_ptr[i]..row_ptr[i+1]-1
					if (self.col_ind[column_index] < i)
						return false
					end
				end
			end
			return true
    end # upper triangular?

    Contract C::None => C::Bool
    def zero?
      # Determines if the matrix is zero
      is_invariant?
      for value in self.val
				if value != 0
					return false
				end
			end
			return true
    end # zero?

  end # Properties
end # CsrMatrix
