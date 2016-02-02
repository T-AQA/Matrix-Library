module CsrMatrix
	module Decompositions

			#alias for eigensystem
			#returns a list in the form {eigenvalues, eigenvectors}
			def eigen()
    		eigenvalue()
			end
        
			def eigenvalue()
				m = Matrix.rows(self.decompose)
				return m.eigensystem().to_a[1].round().to_a
			end
    end
end
