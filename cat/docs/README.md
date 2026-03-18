# Algorithm Notes

This directory contains materials explaining the core algorithm behind the CAT solution.

## Goal

Given $n$ parks on a 2D grid, the task is to travel from park $1$ to park $n$.

Movement is restricted to horizontal and vertical directions. During movement, Dexter alternates between two modes:

- `stroll`
- `sprint`

Every $90^\circ$ turn switches the mode. At each park, Dexter may freely choose the starting mode for the next segment.

The objective is to minimize the total distance traveled in `stroll` mode.

---

## Main Observation

Consider moving directly between two parks $u=(x_u,y_u)$ and $v=(x_v,y_v)$.

Let:

- $\Delta x = |x_u - x_v|$
- $\Delta y = |y_u - y_v|$

Any shortest path consists of one horizontal segment and one vertical segment (at most one turn).

Since the starting mode can be chosen freely, we can assign:

- the longer segment to `sprint`
- the shorter segment to `stroll`

Therefore, the minimum stroll cost is:

- `cost(u, v) = min(Δx, Δy)`

So the problem becomes:

> Find the shortest path in a graph where each pair of parks is connected with weight  
> `w(u, v) = min(|x_u - x_v|, |y_u - y_v|)`.

---

## Graph Reformulation

We obtain a complete graph:

- nodes = parks
- edges = all pairs
- weight = `min(|dx|, |dy|)`

The goal is:

> shortest path from node `1` to node `n`.

---

## Key Optimization

A complete graph has $O(n^2)$ edges, which is infeasible.

However, the edge weight has a special structure:

- small weights arise when two points are close in either x or y

---

### Sorting Trick

Sort all points by x-coordinate.

For each point, only consider:

- its predecessor in x-order
- its successor in x-order

Repeat the same for y-coordinate.

Thus, each node has at most 4 candidate edges:

- previous / next in x-order
- previous / next in y-order

---

### Why This Works

If two points are not adjacent in sorted order, there exists an intermediate point that is at least as close in one coordinate.

This intermediate point can replace the direct connection without increasing cost.

Therefore, all relevant shortest paths are preserved in this sparse graph.

---

## Final Algorithm

1. Read all park coordinates.
2. Sort indices by x and by y.
3. For each point, determine its position in both orderings.
4. For each point, connect:
   - neighbors in x-order
   - neighbors in y-order
5. Run Dijkstra’s algorithm from node `1`.
6. Output the distance to node `n`.

---

## Complexity

- sorting: `O(n log n)`
- edges: `O(n)`
- Dijkstra: `O(n log n)`

Total:

- `O(n log n)`

---

## Files

- `cat_idea.md`: modeling intuition and key insights
- `cat_annotated_en.c`: annotated implementation
- `algorithm.pdf`: detailed technical write-up

---

## Relationship to the Final Implementation

The final executable version is located in `../src/cat.c`.

This directory documents the transformation from movement rules to a shortest path problem, and the optimization that reduces a complete graph to a sparse one.
