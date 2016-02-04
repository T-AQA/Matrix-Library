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
          m = Matrix.rows(self.decompose)
          return m.diagonal?
      end # diagonal?

      def empty?
        # Determines if the matrix is empty; wherein all the values are zero.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        m = Matrix.rows(self.decompose)
        return m.empty?
      end # empty?

      def hermitian?
        # Determine if the matrix is hermitian.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
		    if !self.square?
			    raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.hermitian?
      end # hermitian?

      def lower_triangular?
        # Determines if the matrix is lower-diagonal; wherein all the values only exist on and below the diagonal line.
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        m = Matrix.rows(self.decompose)
        return m.lower_triangular?
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
        m = Matrix.rows(self.decompose)
        return m.orthogonal?
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
        m = Matrix.rows(self.decompose)
        return m.real?
      end # real?

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
          m = Matrix.rows(self.decompose)
          return m.upper_triangular?
      end # upper triangular?

      def zero?
        # Determines if the matrix is zero
        # pre   existing matrix (matrix.not_null?)
        # post  boolean 
        m = Matrix.rows(self.decompose)
        return m.zero?
      end # zero?

    end # properties
end # csrmatrix
