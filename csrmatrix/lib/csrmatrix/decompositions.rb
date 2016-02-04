module CsrMatrix
	module Decompositions

			def eigen()
				# alias for eigensystem
				# returns a list in the form {eigenvalues, eigenvectors}
				# pre 	existing matrix (matrix.not_null)
				# post 	eigenvalues of the matrix
    		eigenvalue()
			end # eigen
        
			def eigenvalue()
				# identifies the eigenvalues of a matrix
				# pre 	existing matrix (matrix.not_null)
				# post 	eigenvalues of the matrix
				m = Matrix.rows(self.decompose)
				return m.eigensystem().to_a[1].round().to_a
			end # eigenvalue
    end # decompositions
end # csrmatrix
