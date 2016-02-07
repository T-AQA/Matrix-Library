module CsrMatrix
    module Functions
        include Contracts::Core
        include Contracts::Builtin

        Contract Contracts::Send[:not_null?] => Contracts::Num
        def determinant()
            # identifies the determinant of a matrix
            # pre   existing matrix
            # post  determinant of the matrix
            m = Matrix.rows(self.decompose)
            return m.det()
        end # determinant

        Contract Contracts::Send[:not_null?] => Contracts::Num
        def det()
            # alias for determinant
            # identifies the determinant of a matrix
            # pre   existing matrix
            # post  determinant of the matrix
            return self.determinant()
        end # det

        Contract Contracts::Send[:not_null?] => Contracts::Num
        def rank()
            # identifies the rank of a matrix
            # pre   existing matrix (matrix.not_null?)
            # post  rank of the matrix
            m = Matrix.rows(self.decompose)
            return m.rank()
        end # rank

        Contract Contracts::Num => Contracts::Bool
        def round(ndig = 0)
            # identifies the round of a matrix (that is, each value rounded by a specific degree)
            # pre   integer of degree, existing matrix (matrix.not_null?)
            # post  rounded array
            m = Matrix.rows(self.decompose)
            return self.build_from_array(m.round(ndig).to_a())
        end # round

        Contract Contracts::Send[:not_null?] => Contracts::Num
        def trace()
            # identifies the trace of the matrix
            # pre   existing matrix (matrix.not_null?)
            # post  trace
            m = Matrix.rows(self.decompose)
            return m.trace()
        end # trace

        Contract Contracts::Send[:not_null?] => Contracts::Num
        def tr()
            # alias for trace
            # identifies the trace of the matrix
            # pre   existing matrix (matrix.not_null?)
            # post  trace
            return self.trace()
        end # tr

    end # Functions
end # CsrMatrix
