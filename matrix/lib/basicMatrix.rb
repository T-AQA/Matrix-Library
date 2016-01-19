require "matrix/version"
require "matrix/properties"
require "matrix/arithmetic"
    
module Matrix

end

class D
    include Matrix::Properties
    include Matrix::Arithmetic

    def initialize()
        @array = 1
    end

    def hi()
        puts "hi"
    end
end