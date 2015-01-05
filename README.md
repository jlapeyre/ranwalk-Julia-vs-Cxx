## Random walk simulation in Julia and c++

This code compares the performance of [Julia](http://julialang.org)
and [C++-11](http://en.wikipedia.org/wiki/C%2B%2B11)
in a [Monte Carlo simulation](http://en.wikipedia.org/wiki/Monte_Carlo_method)
of a [random walk](http://en.wikipedia.org/wiki/Random_walk).
The Julia code runs three times faster than the C++ code.

The code records a statistic of a one dimensional random walker using
the [Mersenne Twister
RNG](http://en.wikipedia.org/wiki/Mersenne_twister).

#### Typical execution times (smaller is better):

* 3.88s  C++-11
* 1.27s  Julia v0.3
* 1.68s  Julia v0.4


This is similar to other testimonies: I heard about Julia and decided
to test it. It takes a few minutes to learn, a few minutes to code an
example, and the results are astonishing. I had been putting off
moving from perl to python. Now, I don't have to.

#### Running the comparison

The idea is to write the code in a straightforward, idiomatic, yet efficient way.
C++-11 improves on C and previous C++ versions by including high-quality RNG's
in the interface to the standard library, although it is stil a bit of a PITA
to use them.

In linux/unix the test is done like this:

```
> c++ -std=c++11 -O3 rwtest_simple.cc -o rwtest_simple
> ./rwtest_simple > cout.txt
> julia rwtest_simple.jl > jout.txt
```

(The outputs are histograms that can be plotted.)

Using the `g++` flag `-march=native` results in slower code.

The efficiency of the timed portion of both programs depends only on
the speed of generating random numbers, checking the result, and
incrementing counters.  It is certainly possible to write a faster
C/C++ program; but that requires more effort and trial and error, and
probably abandoning the standard library.  I already tried several
ways to increase the speed of the C++ code.

#### Versions

* c++ (Debian 4.9.1-15) 4.9.1

* julia version 0.3.4-pre+30 (and later v0.3 versions)

There are also files `rwtest.jl` and `rwtest.cc`, which are slightly
more complicated. In particular, `rwtest.jl` works with the development
versions, v0.4, of Julia as well as v0.3.
