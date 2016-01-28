module CsrMatrix
    module Decompositions

        def eigen()
            eigensystem()
        end
        
        def eigensystem()
            m = Matrix.rows(self.decompose)
            a = m.eigensystem().to_a[0].to_a
        end
        
        def lup()

        end
        
        def lup_decomposition()

        end
        
    end
end