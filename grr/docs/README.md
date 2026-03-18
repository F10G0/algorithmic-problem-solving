# Algorithm Notes

This directory contains materials explaining the core algorithm behind the GRR solution.

## Goal

Given a directed graph whose edge directions alternate every day,

- odd days use the original graph
- even days use the reversed graph

the task is to find all vertices `u` such that for every vertex `v`, there exists a day on which `u` can reach `v`.

## Main Observation

The day may be chosen separately for each target vertex.

So for a fixed vertex `u`, the requirement is not:

> `u` reaches all vertices in one fixed orientation

Instead, it is:

> for every vertex `v`, either `u -> v` in the original graph, or `v -> u` in the original graph

This is because reaching `v` from `u` on an even day is equivalent to reaching `u` from `v` in the original graph.

## SCC Reformulation

Vertices inside the same strongly connected component are mutually reachable, so they are equivalent for this problem.

Therefore, the graph can be compressed into an SCC-DAG.

The problem then becomes:

> Find all SCCs `C` such that for every other SCC `D`, either `C -> D` or `D -> C`.

So the task is reduced to a comparability test in a DAG.

## Reachability Characterization

For each SCC `C`, define:

- `Forward(C)`: all SCCs reachable from `C`
- `Backward(C)`: all SCCs that can reach `C`

Then `C` is valid exactly when

- every SCC belongs to `Forward(C)` or `Backward(C)`

Since the compressed graph is a DAG, two different SCCs cannot reach each other in both directions.  
So, except for `C` itself, the forward and backward sets are disjoint.

This gives the criterion:

> `|Forward(C)| + |Backward(C)| = total_scc - 1`

## Final Algorithm

1. Run Tarjan's algorithm to compute SCCs.
2. Compress the original graph into an SCC-DAG.
3. Build both the DAG and its reverse graph.
4. Compute a topological order of SCCs.
5. Propagate forward reachability sets on the DAG.
6. Propagate backward reachability sets on the reverse DAG.
7. For each SCC, check whether forward and backward coverage together include all other SCCs.
8. Output all original vertices belonging to valid SCCs.

## Practical Note

The implemented solution explicitly stores reachability sets for SCC nodes.

This makes the logic direct and easy to verify, but it can be heavy in worst-case complexity because large reachability sets may need to be stored and merged.

For this reason, this directory also includes notes on complexity and an experimental structural optimization attempt.

## Files

- `grr_idea.md`: reasoning process, failed attempts, and key modeling insight
- `grr_complexity.md`: time and space complexity analysis
- `grr_annotated_en.c`: English annotated implementation
- `algorithm.pdf`: detailed technical write-up

## Relationship to the Final Implementation

The final executable version is located in `../src/grr.c`.

The files in this directory document the reasoning process from initial incorrect interpretations to the final SCC-DAG reachability-set solution.
