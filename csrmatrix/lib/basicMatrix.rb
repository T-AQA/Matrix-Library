require "csrmatrix/version"
require "csrmatrix/properties"
require "csrmatrix/arithmetic"
    
module CsrMatrix

end

class D
    include CsrMatrix::Properties
    include CsrMatrix::Arithmetic

    def initialize()
        @array = 1
    end

    def hi()
        puts "hi"
    end
end