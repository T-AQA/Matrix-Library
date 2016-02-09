require "csrmatrix/exceptions"

module CsrMatrix
  module Operations
    include Contracts::Core
    C = Contracts

    Contract C::Num, C::Nat, C::Nat => C::Bool
    def insert(value, row, column)
      # gets the value off of the index of matrix
      is_invariant?
    
      # insert if the value exists
      for i in self.row_ptr[row-1]..self.row_ptr[row]-1
        if column-1 == self.col_ind[i]
          self.val[i] = value
          return true
        end
      end

      # add value if it does not exist
      for i in self.columns-1..0
        index = self.row_ptr[row]-1 + i
        if self.col_ind[index] < column-1
          #add value
          self.col_ind.insert(index+1, column-1)
          self.val.insert(index+1, value)
          
          #increment row pointers
          for j in row..self.row_ptr.count()-1
            self.row_ptr[j] += 1
          end

          return true
        end
      end

      #add value
      self.col_ind.insert(self.row_ptr[row]-1, column-1)
      self.val.insert(self.row_ptr[row]-1, value)

      #increment row pointers
      for j in row..self.row_ptr.count()-1
        self.row_ptr[j] += 1
      end             
      return true

      #post
      if self.index(row, column) != value
        raise ContractReturnError.new "index not as expected"
      end
    end # insert
    
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
      puts ""
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
