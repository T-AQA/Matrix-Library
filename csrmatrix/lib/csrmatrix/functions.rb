module CsrMatrix
    module Functions
        
        def determinant()
            # identifies the determinant of a matrix
            # pre   existing matrix
            # post  determinant of the matrix
            m = Matrix.rows(self.decompose)
            m.det()
        end

        def det()
            # alias for determinant
            # identifies the determinant of a matrix
            # pre   existing matrix
            # post  determinant of the matrix
            self.determinant()
        end

        def rank()
            # identifies the rank of a matrix
            # pre   existing matrix
            # post  rank of the matrix
            m = Matrix.rows(self.decompose)
            m.rank()
        end

        def round(ndig = 0)
            # identifies the round of a matrix (that is, each value rounded by a specific degree)
            # pre   integer of degree, existing matrix
            # post  rounded array
            m = Matrix.rows(self.decompose)
            self.build_from_array(m.round(ndig).to_a())
        end

        def trace()
            # identifies the trace of the matrix
            # pre   existing matrix
            # post  trace
            m = Matrix.rows(self.decompose)
            m.trace()
        end

        def tr()
            # alias for trace
            # identifies the trace of the matrix
            # pre   existing matrix
            # post  trace
            self.trace()
        end

    end
end
