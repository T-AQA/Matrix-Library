module CsrMatrix
	module Decompositions
		include Contracts::Core
    C = Contracts

    Contract C::None => C::ArrayOf[C::ArrayOf[C::Num]]
		def eigen()
			# alias for eigenvalue
			is_invariant?
  		self.eigenvalue()
		end # eigen
      
    Contract C::None => C::ArrayOf[C::ArrayOf[C::Num]]
		def eigenvalue()
			# identifies the eigenvalues of a matrix
			is_invariant?
			m = Matrix.rows(self.decompose)
			return m.eigensystem().to_a[1].round().to_a
		end # eigenvalue
  end # Decompositions
end # CsrMatrix
