[![Build Status](https://travis-ci.org/dirkschumacher/LineFlowSolver.jl.svg?branch=master)](https://travis-ci.org/dirkschumacher/LineFlowSolver.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/mcnjxvve5do10sce/branch/master?svg=true)](https://ci.appveyor.com/project/dirkschumacher/lineflowsolver-jl/branch/master)
[![codecov](https://codecov.io/gh/dirkschumacher/LineFlowSolver.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/dirkschumacher/LineFlowSolver.jl)
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

# LineFlowSolver

The line flow solvers solves the following problem:

Given a graph and a set of lines, assign lines to edges, such that the
overall edge cost is minimized.

Input:

* A directed graph
* A cost vector for each edge
* A set of lines 1..L
* Tuples of edge/line combinations that fix lines to edges
* A set of edges where only one line can be assigned to

Output:

* An assignment of lines to edges

