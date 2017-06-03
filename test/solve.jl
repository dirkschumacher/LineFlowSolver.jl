# lines
lines = [1, 2]

# Nodes
nodes = [1, 2, 3, 4, 5, 6, 7, 8]

# Edges
edges = [(1, 3), (2, 4),
     (3, 4), (4, 3),
     (3, 5), (4, 6),
     (5, 6), (6, 5),
     (5, 7), (6, 8)]

# fixed edges
FE = [(1, 1), (2, 2), (9, 1), (10, 2)]

# single flow edges
SE = [5, 6]

# edge cost
cost = [0, 0, 1, 1, 0, 0, 1, 1, 0, 0]

problem = LineFlowProblem(nodes, edges, lines, FE, SE, cost)
solution = LineFlowSolver.solve(GLPKSolverMIP(msg_lev = 3), problem)

@test FE ⊆ solution.assignment
@test (5, 1) in solution.assignment
@test (6, 2) in solution.assignment
@test 0 == solution.objective_value
