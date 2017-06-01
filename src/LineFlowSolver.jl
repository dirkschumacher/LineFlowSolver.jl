module LineFlowSolver
    using JuMP
    using MathProgBase

    # package code goes here
    include("types.jl")
    include("solver.jl")

    export LineFlowProblem
    export LineFlowSolution
end # module
