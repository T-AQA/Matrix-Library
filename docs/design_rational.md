# Domain Knowledge

* https://en.wikipedia.org/wiki/Sparse_matrix
* https://github.com/nslocum/design-patterns-in-ruby
* http://www.bu.edu/pasi/files/2011/01/NathanBell1-10-1000.pdf
* http://eigen.tuxfamily.org/dox/group__TutorialSparse.html

[Compressed Row Storage](http://www.netlib.org/utk/people/JackDongarra/etemplates/node373.html)

# Design Questions
##### What is a sparse matrix and what features should it possess?
A sparse matrix is a matrix in which most of the elements are zero. Otherwise, it contains the basic attributes of a matrix.

##### What sources of information should you consult to derive features? Do analogies exist? If so with what?
We can use professionally founded references such as Matlab, as well as WolframAlpha's widgets and Ruby's built in matrix class, in order to ascertain which functions are popular for matrix operations. We can also use different existing libraries to gain understanding as to the functionalities that are expected. Finally, we can browse math-related or coding-related forums to understand often-used functionalities, as well as least-used functionalities. 

Analogies exist with matlab's sparce matrix functions and with Ruby's matrix class. They also exist in multiple forms across different languages; many of which are open-source. However, there are only a few packages that perform sparse-matrix operations - examples of these are found in C++ and Java.

##### Who is likely to be the user of a sparse matrix package? What features are they likely to demand?
This package is likely targeted for two classes of users. The first are programmers that would like to use sparse matrix operations in their processing. The second are math students with basic knowledge in ruby, that could apply the package processing for their own work.

##### What is a tri-diagonal matrix?
[Reference](https://en.wikipedia.org/wiki/Tridiagonal_matrix) A tri-diagonal matrix is a matrix in which only the diagonal line, and the lines above and below the lines are full. It is also referred to as both an upper and lower [Hessenberg matrix](https://en.wikipedia.org/wiki/Hessenberg_matrix).

##### What is the relationship between a tri-diagonal matrix and a generic sparse matrix?
A tri-diagonal matrix can be a generic sparse matrix for a sufficiently large tridiagonal matrix. 

##### Are tri-diagonal matrices important? And should they impact your design? If so, how?
No, we do not believe that tri-diagonal matrices are important enough to impact our design. If we were to search for tri-diagonal matrices, the overhead on parsing the matrix structure would cost more than the time gained by specialised processing that could be conducted for tri-diagonal matrices. As such, we decided to not build the library around tri-diagonal matrices; instead, optimising our library and its performance against all types of sparse matrices.

##### What is a good data representation for a sparse matrix?
We plan on representing the array in a [compressed row storage format](http://www.netlib.org/utk/people/JackDongarra/etemplates/node373.html). We chose to use the compressed row storage format, as it provides the strongest balance against sparse and dense matrices. As such, we can ensure that our design is flexible, and can even be used optimally for a dense matrix.

##### Assume that you have a customer for your sparse matrix package. The customer states that their primary requirements as: for a N x N matrix with m non-zero entries Storage should be ~O(km), where k << N and m is any arbitrary type defined in your design. Adding the m+1 value into the matrix should have an execution time of ~O(p) where the execution time of all method calls in standard Ruby container classes is considered to have a unit value and p << m ideally p = 1 In this scenario, what is a good data representation for a sparse matrix?
We plan on representing the array in a [compressed row storage format](http://www.netlib.org/utk/people/JackDongarra/etemplates/node373.html). The compressed row storage format operates to the standards requested by the customer, wherein the storage is ~O(2nnz + n + 1) [where n is number of elements, and nnz is number of nonzero elements], and execution time of ~O(p), or linear scaling processing time, depending on the matrix and process required.

##### Design Patterns are common tricks which normally enshrine good practice Explain the design patterns: Delegate and Abstract Factory
**[Delegate](http://stackoverflow.com/questions/7168714/what-is-the-purpose-of-a-delegation-pattern)** design pattern is not a traditional design pattern - rather, it is a 'base pattern' which states that obtains the original object, then *delegates* the method to the method that conforms to the correct interface. **[Abstract Factory](https://sourcemaking.com/design_patterns/abstract_factory)** design pattern essentially provides an interface for objects without specifying the object's required class. Ergo, the object follows the intended design - but the actual details of the operations are not specified at the top level.

##### Explain how you would approach implementing these two patterns in Ruby:
We could use the two patterns in the following manner: the Abstract Factory design pattern can be used during instantiation and creation of the TwoDMatrix. During this step, the creation of the matrix is dependent on what variables you pass it; by checking the variables after, the interface can build the matrix depending on what variables are provided. For the Delegate design pattern, we can use a combination of classes, mixins and modules to manipulate and use the object. For example, if the object is processed with another object, we can use a module that contains the proper code to manipulate the objects.

##### Are these patterns applicable to this problem? Explain your answer! (HINT: The answer is yes)
Yes! The goal is to make a generic library operation - as a result, we cannot ensure that the specific designs of all library operations are correct from the development side. However, we know enough about the generic properties of matrices that we can develop the overarching design using generic implementations - of which can be exercised using the aforementioned design patterns.

##### What implementation approach are you using (reuse class, modify class, inherit from class, compose with class, build new standalone class); justify your selection.
Initial design proposes test-driven development. Once tests are built, new stand alone classes are constructed to fill out all of the functionality of the library. For the actual library code, we plan on building the main class to house the matrix, then filling several modules to complete the matrix operations and descriptors.

Ultimately, the implementation approach we're using is a mix of 'standalone class' and compose with class' imple. We are producing our own standalone class, while also using modules and other libraries to perform other tasks. We've done this because the standard matrix library has already been constructed; however, we want to build another library to perform at a level more efficient for sparse matrices, while preserving some static functionality that would not have been changed from one implementation to the next.

##### Is iteration a good technique for sparse matrix manipulation? Is “custom” iteration required for this problem? 
Traditional iteration is not a good technique for sparse matrix multiplication, since the iteration proccess could have a large calculation cost due to many zero values in the matrix. A custom iteration is required to solve this problem by multiplying non-zero columns of the CRS matrix with other non-xero columns of a matrix of the same type. We can also use custom iterators to process and 'pull' entries from a matrix array for the end users.

##### What exceptions can occur during the processing of sparse matrices? And how should the system handle them? 
Exceptions may arise! Here's a short list of what may happen:

| Exception Types:   						 | System Response:                          |
|--------------------------------------------|-------------------------------------------|
| Null matrix        						 | Return NullMatrixException                |
| + / - of different matrix sizes			 | Return MatrixDimException		  		 |
| * / ÷ of incorrect matrix sizes			 | Return MatrixDimException				 |
| Manipulating extremely large numbers	     | Return ArithmeticException				 |

##### What information does the system require to create a sparse matrix object? Remember you are building for a set of unknown customers – what will they want?
Customers will likely require:

1. Input of actual arrays, building the structure row by row.
	i. Alternatively, building the structure column by column.
2. Requesting a zero-initialised matrix of specific row and column size.
3. Requesting an identity matrix of specific size.

##### What are the important quality characteristics of a sparse matrix package? Reusability? Efficiency? Efficiency of what?
The most important qualities of a sparse matrix package are:

1. Reusability - insofar that the structures can be reused over and over.
2. Efficiency - in both storage and runtime.
3. Light - we need lightweight process stuctures in order to reduce overhead to a minimum.
4. Scalable - being able to use this package for large processing structures.
5. Convertible - can be used with different libraries or operations.

##### How do we generalize 2-D matrices to n-D matrices, where n > 2 – um, sounds like an extensible design?
Yes, the implementation of CSR is extensible design. For example, in a 3-D matrix, We can do this by:

1. Adding 'row indices' alongside 'column indices'
2. Renaming 'row offsets' to 'height offsets'
3. Change values from a 1-D matrix to a 2-D matrix - that is, expanding the 'frame' into a +1D structure
4. Ensuring / adjusting / our operations to be scalable. (They are inherently scalable, but need to be adjusted if the demand exists)

Therefore, this design is extensible for any number of dimensions - we only need to add an extra column for indices, and to expand the dimensions of the frame involved.

