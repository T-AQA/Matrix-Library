# Domain Knowledge


# Design Questions

| Questions | Answers |
|:----------|:--------|

|  What is a sparse matrix and what features should it possess? | |
|  What sources of information should you consult to derive features? Do analogies exist? If so with what? | |
|  Who is likely to be the user of a sparse matrix package? What features are they likely to demand? | |
|  What is a tri-diagonal matrix? | |
|  What is the relationship between a tri-diagonal matrix and a generic sparse matrix? | |
|  Are tri-diagonal matrices important? And should they impact your design? If so, how? | |
|  What is a good data representation for a sparse matrix? | |
|  Assume that you have a customer for your sparse matrix package. The customer states that their primary requirements as: for a N x N matrix with m non-zero entries 
o Storage should be ~O(km), where k << N and m is any arbitrary type defined in your design.
o Adding the m+1 value into the matrix should have an execution time of ~O(p) where the execution time of all method calls in standard Ruby container classes is considered to have a unit value and p << m ideally p = 1
In this scenario, what is a good data representation for a sparse matrix? | |
|  Design Patterns are common tricks which normally enshrine good practice
|o Explain the design patterns: Delegate and Abstract Factory | |
|o Explain how you would approach implementing these two patterns in Ruby | |
|o Are these patterns applicable to this problem? Explain your answer! (HINT: The answer is yes) | | 
|  What implementation approach are you using (reuse class, modify class, inherit from class, compose with class, build new standalone class); justify your selection. | |
|  Is iteration a good technique for sparse matrix manipulation? Is “custom” iteration required for this problem? | |
|  What exceptions can occur during the processing of sparse matrices? And how should the system handle them? | |
|  What information does the system require to create a sparse matrix object? Remember you are building for a set of unknown customers – what will they want? | |
|  What are the important quality characteristics of a sparse matrix package? Reusability? Efficiency? Efficiency of what? | |
|  How do we generalize 2-D matrices to n-D matrices, where n > 2 – um, sounds like an extensible design? | |