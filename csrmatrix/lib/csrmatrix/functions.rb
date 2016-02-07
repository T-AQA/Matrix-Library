module CsrMatrix
    module Functions
        
        def determinant()
            # identifies the determinant of a matrix
            # pre   existing matrix
            # post  determinant of the matrix
            m = Matrix.rows(self.decompose)
            m.det()
        end # determinant

        def det()
            # alias for determinant
            # identifies the determinant of a matrix
            # pre   existing matrix
            # post  determinant of the matrix
            self.determinant()
        end # det

        def rank()
            # identifies the rank of a matrix
            # pre   existing matrix (matrix.not_null?)
            # post  rank of the matrix
            m = Matrix.rows(self.decompose)
            m.rank()
        end # rank

        def round(ndig = 0)
            # identifies the round of a matrix (that is, each value rounded by a specific degree)
            # pre   integer of degree, existing matrix (matrix.not_null?)
            # post  rounded array
            m = Matrix.rows(self.decompose)
            self.build_from_array(m.round(ndig).to_a())
        end # round

        def trace()
            # identifies the trace of the matrix
            # pre   existing matrix (matrix.not_null?)
            # post  trace
            m = Matrix.rows(self.decompose)
            m.trace()
        end # trace

        def tr()
            # alias for trace
            # identifies the trace of the matrix
            # pre   existing matrix (matrix.not_null?)
            # post  trace
            self.trace()
        end # tr

    end # Functions
end # CsrMatrix
