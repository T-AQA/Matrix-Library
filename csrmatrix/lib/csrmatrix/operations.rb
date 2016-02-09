require "csrmatrix/exceptions"

module CsrMatrix
    module Operations
        include Contracts::Core
        C = Contracts

        Contract C::Nat => C::Num
        def get_value(index)
            # gets the value off of the index of matrix
            is_invariant?
            return @val[index]
        end # get_value

        Contract C::Nat, C::Or[C::Nat, nil] => C::Num 
        def index(row, col=nil)
            # gets the index in the matrix at row, col
            is_invariant?
                
            if col == nil
                if @val.count < row
                  raise CsrMatrix::Exceptions::IndexOutOfRangeException.new, "Index out of Bounds"
                  return false
                end

              return @val[row-1]
            else
              if !checkInputBounds(row, col)
                raise CsrMatrix::Exceptions::IndexOutOfRangeException.new, "Index out of Bounds"
                return false
              end

              num_elm_in_prev = row_ptr[row-1]
              num_elm_in_row = row_ptr[row] - num_elm_in_prev
                
              (0...num_elm_in_row).each do | x |
                if ( col-1 == @col_ind[num_elm_in_prev+x] )
                  return @val[num_elm_in_prev+x]
                end
              end
              return 0
            end
        end # index

        Contract C::None => C::Any
        def print_full()
            # prints the full matrix for user
            is_invariant?
            full_matrix = self.decompose()
            full_matrix.each do | row |
                row.each do | val |
                    print "#{val}  "
                end
                puts ""
            end
        end # print_full

        Contract C::None => C::Any
        def print_sparse()
            # prints all nonzero values of matrix for user
            is_invariant?
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
