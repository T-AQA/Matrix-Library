module CsrMatrix
    module Decompositions

				#alias for eigensystem
				#returns a list in the form {eigenvalues, eigenvectors}
        def eigen()
            eigensystem()
        end
        
        def eigensystem()
            m = Matrix.rows(self.decompose)
            return m.eigensystem().to_a[0].to_a
        end
        
				#alias for lup_decomposition
				#returns a list of matrices {L, U}
				#Reference: http://nucinkis-lab.cc.ic.ac.uk/HELM/workbooks/workbook_30/30_3_lu_decomposition.pdf
        def lup()
						lup_decomposition()
        end
        
        def lup_decomposition()
						puts "lup"
        end
        
    end
end
