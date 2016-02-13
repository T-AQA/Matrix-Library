module CsrMatrix    
  module MContracts
    class TwoDMatrixType
      def self.valid? val
        val.is_a? TwoDMatrix
      end
    end

    class ValidInputNum
      #2^31 - 1
      @threshold = 100000
      def self.valid? val
        if !val.is_a? Numeric
          return false
        end
        if val >= @threshold
          raise CsrMatrix::Exceptions::InputOverflowError.new "Input Too Large"
          return false
        end
        if val <= -@threshold
          raise CsrMatrix::Exceptions::InputOverflowError.new "Input Too Small"
          return false
        end
        return true
      end

      def self.to_s
        "Is Not a valid input number"
      end
    end

    class ValidMatrixNum
      #2^31 - 1
      @threshold = 100000
      def self.valid? val
        if !val.is_a? Numeric
          return false
        end
        if val >= @threshold
          raise CsrMatrix::Exceptions::MatrixValueOverflowError.new "Matrix Value Too Large"
          return false
        end
        if val <= -@threshold
          raise CsrMatrix::Exceptions::MatrixValueOverflowError.new "Matrix Value Too Small"
          return false
        end
        return true
      end
    end

  end
end
