#!/usr/bin/env julia

# Julia program to compute numerically the pdf of random walk displacments.

const num_steps = 3000
const num_trials = 100000

function onewalk(num_coin_flips)
    num_heads = 0
    for i in 1:num_coin_flips
        num_heads += randbool()
    end
    num_tails = num_coin_flips - num_heads
    return num_heads - num_tails
end

function run_walks (num_trials, num_steps, counts_on_lattice_sites)
    time = @elapsed for i in 1:num_trials
        # translate final displacement to be >= 1
        final_displacement = onewalk(num_steps)+num_steps+1  
        counts_on_lattice_sites[final_displacement] += 1
    end
    println(STDERR, "julia onewalk : $time")
end

function print_walks (num_trials, counts_on_lattice_sites)
    n = length(counts_on_lattice_sites)
    for i in 1:n
        counts_on_lattice_sites[i] > 0 ? 
         println(i-(n+1)/2, " ", counts_on_lattice_sites[i]/num_trials) : nothing
    end
end

# Run several walks and collect statistics
function run_simulation()
    num_sites_on_lattice = 2 * num_steps + 1
    counts_on_lattice_sites = zeros(Int,num_sites_on_lattice)
    run_walks(num_trials, num_steps, counts_on_lattice_sites)
    print_walks(num_trials, counts_on_lattice_sites)
end

# Run the program
run_simulation()
