# Matrix

Welcome to the Matrix gem! This gem is designed to offer high-performance, efficient processes for sparse matrix processes.

If you want to try it out, install the gem and run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'matrix'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matrix

## Usage

## Usage
#### Construction

Start by building the matrix object. This will be a simple shell, on which we can perform our operations on:

```ruby 
@matrix = TwoDMatrix.new
 => #<TwoDMatrix:0x007fa5b2083ba8 @nonzero_count=nil, @row_ptr=nil, @col_ind=nil, @val=nil, @rows=0, @columns=0, @ndim=2> 
```

Then, we can fill it out using a variety of manners - either building the functions from arrays:

```ruby 
@matrix.build_from_array([[1, 2, 3], [1, 2, 3], [1, 2, 3]]) 
@matrix.build_from_rows([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
@matrix.build_from_columns([[1, 2, 3], [1, 2, 3], [1, 2, 3]]) 
@matrix.build_from_csr([0, 3, 6, 9],[0, 1, 2, 0, 1, 2, 0, 1, 2],[1, 2, 3, 1, 2, 3, 1, 2, 3],3,3)
```

Or from an existing matrix using Ruby's matrix library:
```ruby
@MatrixBuild = Matrix.rows([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
@matrix.build_from_matrix(@MatrixBuild)
```

Or by generating a zero or identity matrix:
```ruby
@matrix.build_zero_matrix(3, 2)
@matrix.build_identity_matrix(3)
```

#### Properties 
CsrMatrix offers many property checks for matrices. Test the system by using the following code:
```ruby
@matrixTrigonal3x3.diagonal?
```

The list of usable properties, as of this point, are as follows:
```ruby
.diagonal? .empty? .lower_triangular? .normal? .orthogonal? .permutation? .real? .nonsingular? .singular? .square? .symmetric? .unitary? .upper_ .triangular? .zero?
```

#### Arithmetic
CsrMatrix offers the full suite of standard arithmetic processes for matrices. With regards to scalar operations:
```ruby
@matrixConst.scalar_multiply(2)
@matrixConst.scalar_add(2)
@matrixConst.scalar_subtract(1)
@matrixConst.scalar_division(2)
@matrixConst.scalar_exp(2)
```

As for matrix-to-matrix processes:
```ruby 
@matrixa.multiply_csr(@matrixb)
@matrixa.matrix_add(@matrixb)
@matrixa.is_same_dim(@matrixb)
@matrixa.matrix_add(@matrixb)
@matrixa.matrix_subtract(@matrixb)
@matrixa.matrix_inverse_multiply(@matrixd)
@matrixa.matrix_multiply_inverse(@matrixd)
@matrixa.matrix_division(@matrixd)
```

And for others:
```ruby 
@matrixConst.inverse()
@matrixConst.transpose()
```

#### Other
CsrMatrix offers standard display and assorted property assertion functions for your sparse matrix:

```ruby 
@matrixSparse3x3.print_full()
@matrixSparse3x3.print_sparse()
@matrixSparse3x3.get_value(4)
@matrixSparse3x3.index(1,1)
@matrixSparse3x3.det()
@matrixSparse3x3.determinant()
@matrixSparse3x3.rank()
@matrixFloat2x2.decompose()
@matrixDense3x3.trace()
@matrixDense3x3.tr()
@matrixSparse3x3.transpose()
@matrixSparse3x3.t()
```

#### Exporting CsrMatrix
If you would like to integrate the matrix with your other code, you can simply disassemble it and reconstruct it at your leisure:

```ruby
@matrix.decompose()
@matrix.decomp_to_matrix()
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Team-Aqua/Matrix-Library/tree/master/matrix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

