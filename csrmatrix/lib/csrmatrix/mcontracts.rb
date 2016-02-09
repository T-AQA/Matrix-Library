module CsrMatrix    
  module MContracts
    class TwoDMatrixType
      def self.valid? val
        val.is_a? TwoDMatrix
      end
    end
  end
end