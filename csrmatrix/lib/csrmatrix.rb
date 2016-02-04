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
		# invariant
		# @nonzero_count.is_a?(array) and @nonzero_count.count() >= 0
		# @row_pointer.is_a?(array) and @row_pointer.count() >= 0
		# @col_ind.is_a?(array) and @col_ind.count() >= 0
		# @val.is_a?(array) and @val.count() >= 0
		# @rows >= 0
		# @columns >= 0
		# @dimension == 2
    @nonzero_count = nil
    @row_ptr = nil
    @col_ind = nil
    @val = nil
    @rows = 0
    @columns = 0
    @ndim = 2
  end # initialize

  ##
  # SPARSE MATRIX ATTRIBUTE OPERATORS 
  # matrix attributes and overloaded operators
  #

  # equals override for matrix operations
  def ==(o)
    # equals overide to check if object o equals self
    # pre   o, self
    # post  true if o is_a csrmatrix and o == self
    o.class == self.class && o.state == state
  end # ==(o)

  # FIXME: convert to protected value
  def state
    # returns the current state of the csrmatrix
    # pre self
    # post [@value, @row_pointer, @column_index, @rows, @columns, @dimension]
    [@val, @row_ptr, @col_ind, @rows, @columns, @ndim]
  end # state

  # Finds column and row value of an array. 
  def dimensions()
    # returns the dimensions of the csrmatrix
		# pre self
    # post [@rows, @columns]
    return [@rows, @columns]
  end # dimensions
  
  def square?
    # returns whether or not the system is square
		# pre self
    # post true if matrix is square
    return self.rows == self.columns
  end # square?

  def checkInputBounds(row, col)
    # checks whether or not the index searched is within bounds	
		# pre  row
		#			 column
    # post true if within bounds 
		#			 false if not within bounds
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
  end # checkInputBounds

  def index(row, col=nil)
		# gets the index in the matrix at row, col
		# pre  	row
		#				col, default to nil
		# post	index	
		#       true on success. faulse on failure.
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
  end # index


  ##
  # MATRIX DECOMPOSITION FUNCTIONS
  #

  def decompose()
		# decompose the matrix into an array
		# pre  csrmatrix
		# post array from the csrmartix
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
  end # decompose

  def decomp_to_matrix()
    @matrix = Matrix.rows(self.decompose())
    return @matrix
  end # decomp_to_matrix

  ##
  # MATRIX GENERATION FUNCTIONS 
  # generation of csr matrix
  #

  # Builds when given a 2d array to CSR
  def build_from_array(array)
		# builds a csr matrix from a 2d array
		# pre  array
		# post csrmatrix from array
		#			 true on success, false on failure.
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
  end # build_from_array

  # imports a matrix from a matrix library
  def build_from_matrix(matrix)
		# builds a csr matrix a ruby matrix
		# pre  ruby matrix
		# post csrmatrix from ruby matrix
		#      true on success, false on failure
    if matrix.is_a?(Matrix)
      build_from_array(matrix.to_a())
      return true
    end
    raise MatrixTypeException.new, "Wrong type convert to matrix."
  end # build_from_matrix

  # builds a matrix given its rows
  def build_from_rows(array)
		# builds a csr matrix from rows
		# pre  array
		# post csrmatrix from array
    build_from_array(array)
    self.transpose()
  end # build_from_rows


  # builds a matrix given its columns ;; redirect to array build
  def build_from_columns(array)
		# build a matrix given columns. same implimentation as array build
		# pre  array
		# post csrmatrix from array
    self.build_from_array(array)
  end # build_from_columns

  # generates an identity matrix
  def build_identity_matrix(size)
    # FIXME: test code: replace with CSR identity gen
		# generate identity matrix of a given size
		# pre   size of identity matrix
		# post  identity matrix 
		#       true on succes, false on failure
    if size.is_a?(Numeric)
      self.build_from_array(Matrix.identity(size).to_a())
      return true
    end
    raise MatrixTypeException.new, "Wrong type convert to matrix."
    return false
  end # build_identity_matrix

  # generates a zero matrix
  def build_zero_matrix(rows, columns = rows)
    # FIXME: test code: replace with CSR zero gen
		# generate a matrix with all values equaling zero for a given number of rows and columns
		# pre  rows
		#			 columns
		# post zero matrix
		#			 true on success, false on failure
    if rows.is_a?(Numeric) && columns.is_a?(Numeric)
      self.build_from_array(Matrix.zero(rows, columns).to_a())
      return true
    end
    raise MatrixTypeException.new, "Wrong type convert to matrix."
    return false
  end # build_zero_matrix

  # Builds array using user-generated CSR values
  def build_from_csr(row_ptr, col_ind, val, col_siz, row_siz)
    # generate an array from user generated csr values
		# pre  row_poiner, column_index, values, column_size, row_size
		# post set values for current csrmatrix
    @val = val
    @row_ptr = row_ptr
    @col_ind = col_ind
    @rows = row_siz
    @columns = col_siz
  end # build_from_csr

  # ensures that all subarrays are of same length
  def same_sublength(array)
		# ensures that all sub arrays have the same length
		# pre  self, array
		# post true if length is equal, false otherwise
    testLength = array[0].length
    array.each do |subarray|
      if(subarray.length != testLength)
          return false
      end
    end
    return true
  end #same_sublength

  # Finds the column count, row count and non-zero values in one loop. 
  def convert_to_csr(array)
		# converts a given array to csr format
		# pre  array
		# post csrmatrix from array
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
  end # convert_to_csr

end # TwoDMatrix
