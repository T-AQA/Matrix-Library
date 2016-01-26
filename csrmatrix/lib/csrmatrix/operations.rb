module CsrMatrix
    module Operations
        def get_value(index)
            return @val[index]
        end

        def print_full()
            (0...@col_ind.length).each do |iter|
                (0...@col_ind.length).each do |col|
                    if (iter == @row_ptr[iter] and col == @col_ind[iter])
                        print "#{get_value(iter)}  "
                    else
                        print "0  "
                    end
                end
                puts ""
            end    
        end

        def print_sparse()
            (0...@col_ind.length).each do |iter|
                (0...@col_ind.length).each do |col|
                    if (iter == @row_ptr[iter] and col == @col_ind[iter])
                        print "#{get_value(iter)}  "
                    else
                        print "0  "
                    end
                end
                puts ""
            end
        end    
    end
end