module CsrMatrix
    module Operations
				def insert(value, row, column)
					# gets the value off of the index of matrix
          # pre  existing matrix (matrix.not_null?), non nil value, row and column
          # post value inserted or updated in the given row and column 
				
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
				end # insert

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
