require "csrmatrix/version"
require "csrmatrix/properties"
require "csrmatrix/arithmetic"
require "csrmatrix/functions"
require "csrmatrix/decompositions"
require "csrmatrix/operations"
require "csrmatrix/helpers"
require "csrmatrix/exceptions"

module CsrMatrix
  # The current website ref. Used for verificationn of rb systems.
  Url = "https://github.com/Team-Aqua/Matrix-Library/"
end

# General code convention in this manner - generate documentation via 'rdoc lib'.
class TwoDMatrix
  #Need to ensure we include Object Class overwrites.
  include CsrMatrix::Operations
  include CsrMatrix::Properties
  include CsrMatrix::Arithmetic
  include CsrMatrix::Functions
  include CsrMatrix::Decompositions
  include CsrMatrix::Helpers
  include CsrMatrix::Exceptions

  # The current website ref. Used for verification of rb systems.
  Url = "https://github.com/Team-Aqua/Matrix-Library/"
  attr_reader :row_ptr, :col_ind, :val, :rows, :columns, :ndim

  # Blank setup; setup module.
  def initialize()
    @nonzero_count = nil
    @row_ptr = nil
    @col_ind = nil
    @val = nil
    @rows = 0
    @columns = 0
    @ndim = 2
  end

  ##
  # SPARSE MATRIX ATTRIBUTE OPERATORS 
  # matrix attributes and overloaded operators
  #

  # equals override for matrix operations
  def ==(o)
		# equals overide to check if object o equals self
		# pre 	o, self
		# post	true if o is_a csrmatrix and o == self
    o.class == self.class && o.state == state
  end

  # FIXME: convert to protected value
  def state
		# returns the current state of the csrmatrix
		# pre self
		# post [@value, @row_pointer, @ column_index, @rows, @columns, @dimention]
    [@val, @row_ptr, @col_ind, @rows, @columns, @ndim]
  end

  # Finds column and row value of an array. 
  def dimensions()
    return [@rows, @columns]
  end
  
  def square?
    return self.rows == self.columns
  end

  def checkInputBounds(row, col)
    if row > @rows
      raise IndexOutOfRangeException.new, "Row index too large"
      return false
    elsif col > @columns
      raise IndexOutOfRangeException.new, "Column index too large"
      return false
    elsif row < 0
      raise IndexOutOfRangeException.new, "Row index too small"
      return false
    elsif col < 0
      raise IndexOutOfRangeException.new, "Column index too small"
      return false
    else
      return true
    end
  end

  def index(row, col=nil)
    if col == nil
        if @val.count < row
          raise IndexOutOfRangeException.new, "Index out of Bounds"
          return false
        end

      return @val[row-1]
    else
      if !checkInputBounds(row, col)
        raise IndexOutOfRangeException.new, "Index out of Bounds"
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
  end


  ##
  # MATRIX DECOMPOSITION FUNCTIONS
  #

  def decompose()
    res = Array.new(@rows) { Array.new(@columns, 0) }
    row_counter = 0
    row_idx = 0
    @row_ptr.drop(1).each do |i| #eg. 2 4 7 10
      while row_counter < i 
        res[row_idx][@col_ind[row_counter]] = @val[row_counter]
        row_counter += 1
      end 
      row_idx += 1
    end
    return res
  end

  def decomp_to_matrix()
    @matrix = Matrix.rows(self.decompose())
    return @matrix
  end

  ##
  # MATRIX GENERATION FUNCTIONS 
  # generation of csr matrix
  #

  # Builds when given a 2d array to CSR
  def build_from_array(array)
    if array.is_a?(Array)
      if depth(array) == 2
        if same_sublength(array)
          dimensions = convert_to_csr(array)
          if dimensions == false # error raised, return to top
            raise NullMatrixException.new, "Null value entered when building."
            return false
          end
          @columns = dimensions[0]
          @rows = dimensions[1]
          nonzero_count = dimensions[2] # FIXME: consider removing
          @val = dimensions[3]
          @row_ptr = dimensions[4]
          @col_ind = dimensions[5]
          return true
        end
        raise MatrixDimException.new, "Invalid row/column pairs imported."
        return false
      end
      raise MatrixDimException.new, "Invalid dimensions."
      return false
    end
    raise MatrixTypeException.new, "Wrong type convert to matrix"
  end 

  # imports a matrix from a matrix library
  def build_from_matrix(matrix)
    if matrix.is_a?(Matrix)
      build_from_array(matrix.to_a())
      return true
    end
    raise MatrixTypeException.new, "Wrong type convert to matrix."
  end 

  # builds a matrix given its rows
  def build_from_rows(array)
    build_from_array(array)
    self.transpose()
  end


  # builds a matrix given its columns ;; redirect to array build
  def build_from_columns(array)
    self.build_from_array(array)
  end   

  # generates an identity matrix
  def build_identity_matrix(size)
    # FIXME: test code: replace with CSR identity gen
    if size.is_a?(Numeric)
      self.build_from_array(Matrix.identity(size).to_a())
      return true
    end
    raise MatrixTypeException.new, "Wrong type convert to matrix."
    return false
  end

  # generates a zero matrix
  def build_zero_matrix(rows, columns = rows)
    # FIXME: test code: replace with CSR zero gen
    if rows.is_a?(Numeric) && columns.is_a?(Numeric)
      self.build_from_array(Matrix.zero(rows, columns).to_a())
      return true
    end
    raise MatrixTypeException.new, "Wrong type convert to matrix."
    return false
  end

  # Builds array using user-generated CSR values
  def build_from_csr(row_ptr, col_ind, val, col_siz, row_siz)
    # generate 
    @val = val
    @row_ptr = row_ptr
    @col_ind = col_ind
    @rows = row_siz
    @columns = col_siz
  end

  # ensures that all subarrays are of same length
  def same_sublength(array)
    testLength = array[0].length
    array.each do |subarray|
      if(subarray.length != testLength)
          return false
      end
    end
    return true
  end

  # Finds the column count, row count and non-zero values in one loop. 
  def convert_to_csr(array)
		
    row_count = 0
    col_count = 0
    nonzero_count = 0

    row_val = 0
    row_prev_sum = 0

    col_val = 0

    value_array = Array.new
    row_ptr = Array.new
    col_ind = Array.new
    
    array.each_index do |i| # each row
      col_val = 0 # eg. for pos [0, 1, 2, 3] it goes 0, 1, 2, 3
      col_tmp = 0
      row_count += 1
      row_prev_sum = row_val
      row_ptr << row_prev_sum # ref: http://op2.github.io/PyOP2/linear_algebra.html
      subarray = array[i]
      subarray.each_index do |x| # each column entry in row
        col_tmp += 1
        if array[i][x] != 0
          # use nonzero value in CSR
          if array[i][x] == nil
            return false
          end
          nonzero_count += 1
          value_array << array[i][x]
          col_ind << col_val
          row_val += 1
        end
        col_val += 1 # eg. col_val add at the end
      end
      if col_tmp >= col_count
        col_count = col_tmp
      end
    end
    row_prev_sum = row_val
    row_ptr << row_prev_sum
    return [col_count, row_count, nonzero_count, value_array, row_ptr, col_ind]
  end

end
