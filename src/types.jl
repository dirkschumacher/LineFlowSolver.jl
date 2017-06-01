typealias EdgeId Integer
typealias Line Integer
typealias Edge Tuple{Integer, Integer}
type LineFlowProblem
    nodes::Array{Integer}
    edges::Array{Edge}
    lines::Array{Line}
    fixed_edges::Array{Tuple{EdgeId, Line}}
    single_flow_edges::Array{EdgeId}
    cost::Array{Real}
end

type LineFlowSolution
    assignment::Array{Tuple{EdgeId, Line}}
    objective_value::Real
end
