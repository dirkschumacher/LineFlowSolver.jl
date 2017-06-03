using LineFlowSolver
using Base.Test
using JuMP
using GLPKMathProgInterface

tests = ["solve"]

println("Running tests:")

for t in tests
    test_fn = "$t.jl"
    println(" * $test_fn")
    include(test_fn)
end
