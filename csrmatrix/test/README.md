## How to test CsrMatrix:
CsrMatrix's tests are completed in **Minitest**. However, all the scripts are provided for you to clearly access if so desired.

The relevant test cases are:

    algorithms_test.rb
    builder_test.rb
    decompositions_test.rb
    functions_test.rb
    helpers_test.rb
    operations_test.rb
    properties_test.rb

You can run all these tests simultaneously by doing the following:

First, install, build and compile the ruby library:

    gem install csrmatrix
    bundle install

Then, run the test cases:

    bundle exec rake

Design decisions made for the test cases:

1. We opted against building complex matrices, instead optimising our structures solely for standard simple matrices. 
2. We opted against designing capabilities for null entries in our matrices, instead alerting the user and preventing the matrix construction.
3. We housed all of the exceptions inside of csrmatrix/exceptions, allowing for a clear reference as to the exceptions found in our library.
4. We separated all of the test cases to their respective library references; however, some tests are completed twice for legibility's sake.
5. Many properties operations are referenced from other locations; examples include Matlab and other sparse matrix libraries. See design rationale for more information.
6. Helper functions are generally used inside the modules and classes; however, they are tested at the same level as other functions.