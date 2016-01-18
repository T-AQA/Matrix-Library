# Domain Knowledge
https://en.wikipedia.org/wiki/Sparse_matrix

http://www.bu.edu/pasi/files/2011/01/NathanBell1-10-1000.pdf

[Compressed Row Storage](http://www.netlib.org/utk/people/JackDongarra/etemplates/node373.html)

# Design Questions
##### What is a sparse matrix and what features should it possess?
A sparse matrix is a matrix in which most of the elements are zero.

##### What sources of information should you consult to derive features? Do analogies exist? If so with what?
We can use professionally founded references such as Matlab, as well as WolframAlpha's widgets and Ruby's built in matrix class, in order to ascertain which functions are popular for matrix operations. Analogies exist with matlab's sparce matrix functions and with Ruby's matrix class.

##### Who is likely to be the user of a sparse matrix package? What features are they likely to demand?
This package is likely targeted for two classes of users. The first are programmers that would like to use sparse matrix operations in their processing. The second are math students with basic knowledge in ruby, that could apply the package processing for their own work.

##### What is a tri-diagonal matrix?
[Reference](https://en.wikipedia.org/wiki/Tridiagonal_matrix) A tridiagonal matrix is a matrix in which only the diagonal line, and the lines above and below the lines are full. It is also referred to as both an upper and lower [Hessenberg matrix](https://en.wikipedia.org/wiki/Hessenberg_matrix).

##### What is the relationship between a tri-diagonal matrix and a generic sparse matrix?
A tri-diagonal matrix can technically be a generic sparse matrix. 

##### Are tri-diagonal matrices important? And should they impact your design? If so, how?
Yes - in our opinion, tri-diagonal matrices are imporant and should be recognised. We plan on recognising tri-diagonal matrices before parsing into CSR format. This way, we can store the matrix more efficiently than a traditional matrix.

##### What is a good data representation for a sparse matrix?
We plan on representing the array in a [compressed row storage format](http://www.netlib.org/utk/people/JackDongarra/etemplates/node373.html). 


##### Assume that you have a customer for your sparse matrix package. The customer states that their primary requirements as: for a N x N matrix with m non-zero entries Storage should be ~O(km), where k << N and m is any arbitrary type defined in your design. Adding the m+1 value into the matrix should have an execution time of ~O(p) where the execution time of all method calls in standard Ruby container classes is considered to have a unit value and p << m ideally p = 1 In this scenario, what is a good data representation for a sparse matrix?
We plan on representing the array in a [compressed row storage format](http://www.netlib.org/utk/people/JackDongarra/etemplates/node373.html). 


##### Design Patterns are common tricks which normally enshrine good practice Explain the design patterns: Delegate and Abstract Factory
**[Delegate](http://stackoverflow.com/questions/7168714/what-is-the-purpose-of-a-delegation-pattern)** design pattern is not a traditional design pattern - rather, it is a 'base pattern' which states that obtains the original object, then *delegates* the method to the method that conforms to the correct interface. **[Abstract Factory](https://sourcemaking.com/design_patterns/abstract_factory)** design pattern essentially provides an interface for objects without specifying the object's required class. Ergo, the object follows the intended design - but the actual details of the operations are not specified at the top level.

##### Explain how you would approach implementing these two patterns in Ruby
The design patterns are most useful when parsing the array for further processing. When we view the array, the array could indeed follow a tri-diagonal matrix structure. In that case, we would have to perform additional functions in order to optimise the array. Then, we would follow the generic processing in order to structure all 

##### Are these patterns applicable to this problem? Explain your answer! (HINT: The answer is yes)
Yes! The goal is to make a generic library operation - as a result, we cannot define all library operations from the development side. However, we know enough about the generic properties of matrices that we can develop the overarching design using generic implementaitons - of which can be exercised using the aforementioned design patterns.

##### What implementation approach are you using (reuse class, modify class, inherit from class, compose with class, build new standalone class); justify your selection.
TBD - Initial design proposes test-driven development, but design process will likely be:
	1. Build new standalone class.
	2. Reuse/modify class.

##### Is iteration a good technique for sparse matrix manipulation? Is “custom” iteration required for this problem? 
Iteration is not a good technique for sparse matrix multiplication, since the iteration proccess could have a large calculation cost due to many zero values in the matrix. A custom iteration is required to solve this problem by multiplying non-zero columns of the csr matrix with other non-xero columns of a matrix of the same type.

##### What exceptions can occur during the processing of sparse matrices? And how should the system handle them? 
Exceptions may arise! Here's a short list of what may happen:

| Exception Types:   | System Response:          |
|--------------------|---------------------------|
| Null matrix        | Return null exception     |
| Dense matrix       | TBD                       |
| Tridiagonal matrix | Process array efficiently |

##### What information does the system require to create a sparse matrix object? Remember you are building for a set of unknown customers – what will they want?
Customers will likely require:

	1. Identificaiton of their array, in a form of a name or object attribution.
	2. Generic properties (built to CSR standards) - row offset, column indices (+ if extensible design is required), values.
	3. Visual representation of the object - eg. object.print()

##### What are the important quality characteristics of a sparse matrix package? Reusability? Efficiency? Efficiency of what?
The most important qualities of a sparse matrix package are:

	1. Reusability - insofar that the system can be reused for different structures.
	2. Efficiency - in both storage and runtime.
	3. Light - we need lightweight process stuctures in order to reduce overhead to a minimum.

##### How do we generalize 2-D matrices to n-D matrices, where n > 2 – um, sounds like an extensible design?
Yes, the implementation of CSR is extensible design. For example, in a 3-D matrix, We can do this by:

	1. Adding 'row indices' alongside 'column indices'
	2. Renaming 'row offsets' to 'height offsets'
	3. Change values from a 1-D matrix to a 2-D matrix - that is, expanding the 'frame' into a +1D structure.

Therefore, this design is extensible for any number of dimensions - we only need to add an extra column for indices, and to expand the dimensions of the frame involved.

