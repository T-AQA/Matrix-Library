module CsrMatrix
    module Functions
        
        def determinant()
            m = Matrix.rows(self.decompose)
            m.det()
        end

        def det()
            self.determinant()
        end

        def rank()
            m = Matrix.rows(self.decompose)
            m.rank()
        end

        def round(ndig = 0)
            m = Matrix.rows(self.decompose)
            self.build_from_array(m.round(ndig).to_a())
        end

        def trace()
            m = Matrix.rows(self.decompose)
            m.trace()
        end

        def tr()
            self.trace()
        end

    end
end