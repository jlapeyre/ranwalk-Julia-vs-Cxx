# Random walk simulation in Julia and c++

This code tests the performance of Julia and c++ in a Monte Carlo
simulation of a random walk. The code approximates the pdf of the
displacement of a one dimensional random walker using a high quality
(Mersenne Twister) random number generator. The result is that the
Julia code runs much faster than the c++ code.

## Other performance notes

Because the relative performance of Julia and c++ (for these implementations)
of We have to pass the function performing a single walk as a parameter. So it
cannot be inlined by c++. I suppose it is possible that Julia could
still inline the function.  In any case both the c++ and Julia code
run a few percent slower compared to using the literal function name.

### Versions

 c++ (Debian 4.9.1-15) 4.9.1

 julia version 0.3.4-pre+30

