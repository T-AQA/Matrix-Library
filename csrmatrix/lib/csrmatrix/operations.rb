module CsrMatrix
    module Operations
        def get_value(index)
            return @val[index]
        end

        def print_full()
            full_matrix = self.decompose()
            full_matrix.each do | row |
                row.each do | val |
                    print "#{val}  "
                end
                puts ""
            end

            # print @col_ind
            # item_count = 0
            # cur_num_val = 0
            # col_ptr = 0

            # (0...@rows).each do |row_index|
            #     puts "Row Index: #{row_index} "
            #     cur_num_val = @row_ptr[row_index+1]  - item_count
            #     puts "Number of Value in Row: #{cur_num_val} "
            #     (0...@columns).each do |col_index|
            #         print "Indexing with: #{item_count} --> "
            #         if (col_index == @col_ind[item_count])
            #             print "#{@val[item_count + col_index]}  "
            #             item_count += 1
            #         else
            #             print "0  "
            #         end
            #     end
            #     print "\n"

            #    #item_count = @row_ptr[row_index+1]
            #end
        end

        def print_sparse()
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
        end    
    end
end