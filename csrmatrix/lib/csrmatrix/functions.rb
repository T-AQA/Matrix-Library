module CsrMatrix
    module Functions
        include Contracts::Core
        include Contracts::Builtin
        C = Contracts

        def self.included(exceptions)
            exceptions.send :include, Exceptions
        end

        Contract C::None => C::Num
        def determinant()
            # identifies the determinant of a matrix
            is_invariant?
            if !self.square?()
                raise Exceptions::MatrixDimException.new, "Matrix is not square."
                return false
            end

            m = Matrix.rows(self.decompose)
            return m.det()
        end # determinant

        Contract C::None => C::Num
        def det()
            # alias for determinant
            # identifies the determinant of a matrix
            is_invariant?
            return self.determinant()
        end # det

        Contract C::None => C::Num
        def rank()
            # identifies the rank of a matrix
            is_invariant?
            m = Matrix.rows(self.decompose)
            return m.rank()
        end # rank

        #FIXME: I'm not sure whats going on here?
        def round(ndig = 0)
            # identifies the round of a matrix (that is, each value rounded by a specific degree)
            # pre   integer of degree, existing matrix (matrix.not_null?)
            is_invariant?
            # post  rounded array
            for i in 0..self.val.count-1
                self.val[i] = self.val[i].round(ndig)
            end    
            self.val
        end # round

        Contract C::None => Contracts::Num
        def trace()
            # identifies the trace of the matrix
            is_invariant?
            m = Matrix.rows(self.decompose)
            return m.trace()
        end # trace

        Contract C::None => Contracts::Num
        def tr()
            # alias for trace
            # identifies the trace of the matrix
            is_invariant?
            return self.trace()
        end # tr

    end # Functions
end # CsrMatrix
