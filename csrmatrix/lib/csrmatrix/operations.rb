module CsrMatrix
    module Operations
        def get_value(index)
            # gets the value off of the index of matrix
            # pre   int index present
            # post  value at index value
            return @val[index]
        end # get_value

        def print_full()
            # prints the full matrix for user
            # pre   existing matrix (matrix.not_null?)
            # post  matrix in plaintext
            full_matrix = self.decompose()
            full_matrix.each do | row |
                row.each do | val |
                    print "#{val}  "
                end
                puts ""
            end
        end # print_full

        def print_sparse()
            # prints all nonzero values of matrix for user
            # pre   existing matrix (matrix.not_null?)
            # post  sparse matrix in plaintext
            full_matrix = self.decompose()
            full_matrix.each do | row |
                row.each do | val |
                    if val == 0
                        print "---"
                    else
                        print " #{val} "    
                    end
                end
                puts ""
            end
        end # print_sparse   
    end # Operations
end # CsrMatrix
