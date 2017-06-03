function solve(solver::MathProgBase.SolverInterface.AbstractMathProgSolver,
                problem::LineFlowProblem)

    # Lines
    const L = problem.lines

    # Nodes
    const N = problem.nodes

    # Edges
    const E = problem.edges

    # fixed edges
    const FE = problem.fixed_edges

    # single flow edges
    const SE = problem.single_flow_edges

    # edge cost
    const cost = problem.cost

    # check if (edge, line) tuple is valid
    function is_valid_var(e, l)
        const fe_edges = filter(x -> x[1] == e, FE)
        isempty(fe_edges) || length(filter(x -> x[2] == l, fe_edges)) == 1
    end

    # Init the model
    model = Model(solver = solver)

    # A binary variable for each edge and line tuple
    @variable(model, 0 <= x[e = 1:length(E), l = L; is_valid_var(e, l)] <= 1, Bin)

    # Minimize the edge cost for all assigned edge/line tuples
    const valid_el = filter(x -> is_valid_var(x[1], x[2]), [(i,l) for i = 1:length(E) for l = L])
    @objective(model, Min, sum(cost[e[1]] * x[e[1],e[2]] for e = valid_el))

    #Fix edges
    for e in FE
        setlowerbound(x[e[1],e[2]], 1)
    end

    # fix single edges
    const fixed_edge_indexes = map(x -> x[1], FE)
    for e in SE
        const ls = filter(l -> is_valid_var(e, l), L)
        if e ∉ fixed_edge_indexes
            @constraint(model, sum(x[e,l] for l =ls) <= 1)
        end
    end

    # Flow constraint
    for v in N
        const inbound_edges = map(x -> first(indexin([x], E)), filter(x -> x[2] == v, E))
        const outbound_edges = map(x -> first(indexin([x], E)), filter(x -> x[1] == v, E))
        for l in L
            const v_inbound_edges = filter(x -> is_valid_var(x[1], l), inbound_edges)
            const v_outbound_edges = filter(x -> is_valid_var(x[1], l), outbound_edges)
            if !isempty(v_inbound_edges) && !isempty(v_outbound_edges)
                @constraint(model, sum(x[e,l] for e = v_inbound_edges) ==
                                sum(x[e,l] for e = v_outbound_edges))
            end
        end
    end

    # Solve it
    JuMP.solve(model)

    const x_val = getvalue(x)
    assignment = []
    for e in 1:length(E)
        for l in L
            if is_valid_var(e, l)
                if x_val[e, l] > 0.9
                    push!(assignment, (e, l))
                end
            end
        end
    end
    LineFlowSolution(assignment, getobjectivevalue(model))
end
