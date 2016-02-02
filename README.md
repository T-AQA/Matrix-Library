# Matrix

Welcome to the Matrix gem! This gem is designed to offer high-performance, efficient processes for sparse matrix processes.

If you want to try it out, install the gem and run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csrmatrix'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csrmatrix

## Usage

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Team-Aqua/Matrix-Library/tree/master/matrix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

