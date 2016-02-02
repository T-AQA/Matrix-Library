require "matrix"
require "csrmatrix/exceptions"

module CsrMatrix
    module Properties

      def self.included(exceptions)
        exceptions.send :include, Exceptions
      end 
      
      # Determines if the matrix is diagonal; wherein the values outside the main diagonal are all zero.
      def diagonal?
          m = Matrix.rows(self.decompose)
          return m.diagonal?
      end

      # Determines if the matrix is empty; wherein all the values are zero.
      def empty?
          m = Matrix.rows(self.decompose)
          return m.empty?
      end

      # Determine if the matrix is hermitian.
      def hermitian?
		    if !self.square?
			    raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.hermitian?
      end

      # Determines if the matrix is lower-diagonal; wherein all the values only exist on and below the diagonal line.
      def lower_triangular?
          m = Matrix.rows(self.decompose)
          return m.lower_triangular?
      end

      # Determines if the matrix is normal; wherein if the number of rows or columns is 0
      def normal? 
  			if !self.square?
  			  raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.normal?
      end

      # Determines if the matrix is orthogonal; wherein the rows and columns are orthogonal unit vectors.
      def orthogonal?
        if !self.square?
          raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.orthogonal?
      end

      # Determines if the matrix is a permutation; wherein it is an nxn version of the identity matrix.
      def permutation?
		    if !self.square?
			    raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.permutation?
      end

      # Determines if the matrix is real; wherein the matrix consists entirely of real numbers.
      def real?
          m = Matrix.rows(self.decompose)
          return m.real?
      end

      # Determines if the matrix is nonsingular
      def nonsingular?
          return !self.singular?
      end

      # Determines if the matrix is singular
      def singular?
          m = Matrix.rows(self.decompose)
          return m.singular?
      end

      # Determines if the matrix is square
      def square?
          m = Matrix.rows(self.decompose)
          return m.square?
      end

      # Determines if the matrix is symmetric
      def symmetric?
  			if !self.square?
  				raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.symmetric?
      end

      # Determines if the matrix is unitary
      def unitary?
  			if !self.square?
  				raise Exceptions::MatrixDimException.new, "Matrix is not square."
          return false
        end
        m = Matrix.rows(self.decompose)
        return m.unitary?
      end

      # Determines if the matrix is upper-triangular
      def upper_triangular?
          m = Matrix.rows(self.decompose)
          return m.upper_triangular?
      end

      # Determines if the matrix is zero
      def zero?
          m = Matrix.rows(self.decompose)
          return m.zero?
      end

    end
end
