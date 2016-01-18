require "matrix/version"
require "matrix/attributes"
require "matrix/arithmatic"
    
module Matrix

end

class D
    include Matrix::Attributes
    include Matrix::Arithmatic

    def initialize()
        @array = 1
    end

    def hi()
        puts "hi"
    end
end