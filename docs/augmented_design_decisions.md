## Augmented Design Decisions

#### Submission Requirements:
1. A detailed rational for any augmented decisions with regard to the above design questions.
Augmentations are not necessarily a bad thing – but they are a learning process! So list them!
2. A list of deviations in the contracts implemented form the contracts specified in Part 2. Deviations are not necessarily a bad thing – but they are a learning process! So list them!
3. A copy of the code
4. A description of any additional testing beyond that described by your contracts.
5. A list of known errors, faults, defects, missing functionality, etc. …telling us about your system’s limitations will score better than letting us find them.

## Augmented Decisions
1. Removed some exceptions in favor of using contracts for error checking. This reduces the number of nested if statement that were in our code due to exception checking.
2. Replaced a large majority of matrix library functions with in-house function development. Optimizes speed of library for matrix processes. 

## Deviations

## Additional Testing
1. Unit tests were added to verify the correctness of our contracts.

## Errors, Faults, Defects, and Missing Functionality
1. We were not able to include complex matrices into our algorithm. Because of this we missed out on using some properties such as testing whether or not the matrix is Hermetian, normal or unitary.
2. We vary in our outputs between Rational and Fractions. This is more of a design decision; we use rationals when the matrix library is involved, and fractions when in house processing is involved. In future designs, the output would be properly isolated.
