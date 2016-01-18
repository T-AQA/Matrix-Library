require "matrix/version"

module Matrix
    # The current website ref. Used for verification of rb systems.
    Url = "https://github.com/Team-Aqua/Matrix-Library/"
end

# General code convention in this manner - generate documentation via 'rdoc lib'.
class BasicTwoDMatrix
    # The current website ref. Used for verification of rb systems.
    Url = "https://github.com/Team-Aqua/Matrix-Library/"

    # Blank setup; setup module.
    def initialize(array)
        @array = array
    end

    def num_col()
        return @array[0].length
    end

    def num_row()
        return @array.length
    end

    def dimensions()
        return [num_row, num_col]
    end

    def is_diagonal()

    end

    def is_empty()

    end

    def is_hermitian()

    end

    def is_lower_triangular()

    end

    def is_normal()

    end

    def is_orthogonal()

    end

    def is_permutation()

    end

    def is_real()

    end

    def is_regular()

    end

    def is_singular()

    end

    def is_square()

    end

    def is_symmetric()

    end

    def is_unitary()

    end

    def is_upper_triangular()

    end

    def is_zero()

    end




end