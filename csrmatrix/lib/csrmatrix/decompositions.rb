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
        
		#alias for lup
		#returns a list of matrices {L, U}
		#Reference: http://nucinkis-lab.cc.ic.ac.uk/HELM/workbooks/workbook_30/30_3_lu_decomposition.pdf
  	def lup_decomposition()
			lup()
    end

		def lup()
			m = Matrix.rows(self.decompose)
    	return m.lup().to_a[0].to_a, m.lup().to_a[1].to_a
    end
        
    end
end
