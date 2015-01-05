#!/usr/bin/env julia

# Julia program to compute numerically the pdf of random walk displacments.

const num_steps = 3000
const num_trials = 100000

if VERSION < v"0.4.0-dev+980"
    macro ourrandbool()
        :(randbool())
    end
else
    macro ourrandbool()
        :(rand(Bool))
    end
end

function onewalk1(num_coin_flips)
    num_heads = 0
    for i in 1:num_coin_flips
        num_heads += @ourrandbool()
    end
    num_tails = num_coin_flips - num_heads
    return num_heads - num_tails
end

function onewalk2(num_coin_flips)
    num_heads = 0
    for i in 1:num_coin_flips
        @ourrandbool() ? num_heads += 1 : nothing
    end
    num_tails = num_coin_flips - num_heads
    return num_heads - num_tails
end

function run_walks (num_trials, num_steps, counts_on_lattice_sites, walkfunction,
                    walkfunctionname)
    time = @elapsed for i in 1:num_trials
        # translate final displacement to be >= 1
        final_displacement = walkfunction(num_steps)+num_steps+1  
        counts_on_lattice_sites[final_displacement] += 1
    end
    println(STDERR, "julia $walkfunctionname : $time")
end

function print_walks (num_trials, counts_on_lattice_sites)
    n = length(counts_on_lattice_sites)
    for i in 1:n
        if counts_on_lattice_sites[i] > 0
            println(i-(n+1)/2, " ", counts_on_lattice_sites[i]/num_trials)
        end
    end
end

# Run several walks and collect statistics
function run_simulation()
    num_sites_on_lattice = 2 * num_steps + 1
    counts_on_lattice_sites = zeros(Int,num_sites_on_lattice)
    run_walks(num_trials, num_steps, counts_on_lattice_sites,onewalk1,
                              "onewalk1")

# This is slower than the onewalk1    
#    fill!(counts_on_lattice_sites,0)
#    run_walks(num_trials, num_steps, counts_on_lattice_sites,onewalk2,
#                              "onewalk2")

    print_walks(num_trials, counts_on_lattice_sites)
end

# Run the program
run_simulation()
