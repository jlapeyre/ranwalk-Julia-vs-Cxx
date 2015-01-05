// c++-11 program to compute numerically the pdf of random walk displacments.
#include <iostream>
#include <iomanip>
#include <stdlib.h>
#include <random>
#include <ctime>

const int num_steps = 3000;
const int num_trials = 100000;

std::random_device rd;
std::mt19937 generator(rd()); // Mersenne Twister
std::bernoulli_distribution randbool(0.5);

int onewalk(int num_coin_flips) {
  int num_heads = 0;
  for (int i=0; i < num_coin_flips; ++i)
    //  if(randbool(generator)) ++num_heads;
  num_heads += randbool(generator);
  int num_tails = num_coin_flips - num_heads;
  return num_heads - num_tails;
}

void run_walks (int num_trials, int num_steps, int * counts_on_lattice_sites) {
  std::clock_t c_start = std::clock();
  for(int i=0; i < num_trials; ++i) {
    // translate final displacement to be >= 0
    int final_displacement = onewalk(num_steps) + num_steps;
    counts_on_lattice_sites[final_displacement] += 1;
  }
  std::clock_t c_end = std::clock();
  double seconds =  (c_end-c_start)/ (double) CLOCKS_PER_SEC;
  std::cerr << "c++ onewalk: " <<  std::fixed <<
    std::setprecision(2) << seconds << std::endl;
}

void print_walks(int num_trials, int num_steps, int * counts_on_lattice_sites, 
                 int num_sites_on_lattice) {
  for (int i=0; i < num_sites_on_lattice; ++i)
    if (counts_on_lattice_sites[i] > 0)
      std::cout << i - num_steps << " " << 
        (counts_on_lattice_sites[i] / (double) num_trials) << std::endl;
}

int main () {

  int num_sites_on_lattice = 2 * num_steps + 1;
  int * counts_on_lattice_sites = new int [num_sites_on_lattice];
  run_walks(num_trials, num_steps, counts_on_lattice_sites);
  print_walks(num_trials, num_steps, counts_on_lattice_sites, num_sites_on_lattice);
  delete(counts_on_lattice_sites); 
  return 0;

}
