module CsrMatrix
    module Properties
        
        def diagonal()
            m = Matrix.rows(self.decompose)
            return m.diagonal?
        end

        def empty()
            m = Matrix.rows(self.decompose)
            return m.empty?
        end

        def hermitian()
            m = Matrix.rows(self.decompose)
            return m.hermitian?
        end

        def lower_triangular()
            m = Matrix.rows(self.decompose)
            return m.lower_triangular?
        end

        def normal()
            m = Matrix.rows(self.decompose)
            return m.normal?
        end

        def orthogonal()
            m = Matrix.rows(self.decompose)
            return m.orthogonal?
        end

        def permutation()
            m = Matrix.rows(self.decompose)
            return m.permutation?
        end

        def real()
            m = Matrix.rows(self.decompose)
            return m.real?
        end

        def nonsingular()
            return !self.singular()
        end

        def singular()
            m = Matrix.rows(self.decompose)
            return m.singular?
        end

        def square()
            m = Matrix.rows(self.decompose)
            return m.square?
        end

        def symmetric()
            m = Matrix.rows(self.decompose)
            return m.symmetric?
        end

        def unitary()
            m = Matrix.rows(self.decompose)
            return m.unitary?
        end

        def upper_triangular()
            m = Matrix.rows(self.decompose)
            return m.upper_triangular?
        end

        def zero()
            m = Matrix.rows(self.decompose)
            return m.zero?
        end

    end
end
