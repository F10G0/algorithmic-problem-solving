# Algorithm Notes

This directory contains materials explaining the core algorithm behind the PAW solution.

## Goal

Given an undirected graph, determine:

- whether there exists at least one simple cycle
- whether all simple cycles have the same length
- and if so, compute that length and the total number of valid routes

A valid route is defined as:

- a closed walk (start = end)
- no repeated vertices (except start/end)
- no repeated edges

So each valid route corresponds to a **simple cycle**.

---

## Main Observation

A key structural property of graphs:

> Every simple cycle lies entirely inside a **biconnected component (BCC)**.

Therefore, instead of analyzing the whole graph directly, we:

- decompose the graph into BCCs using Tarjan
- analyze each BCC independently

This reduces the problem to understanding:

> What kinds of BCCs can contain only cycles of equal length?

---

## Structural Classification

A BCC that satisfies the condition must be one of the following:

### 1. Single Cycle

If the BCC satisfies

    E == V

then it is a simple cycle.

- contributes exactly one cycle
- cycle length = number of edges

---

### 2. Theta Structure

Otherwise, the BCC must have:

- exactly two vertices with degree > 2 (denoted s and t)
- all other vertices have degree = 2

This implies the structure:

> multiple internally disjoint paths between s and t

---

## Equal-Length Condition

Let the s → t paths have lengths:

    l1, l2, ..., lk

Each pair of paths forms a cycle:

    cycle length = li + lj

To ensure all cycles have the same length:

    l1 = l2 = ... = lk

So:

- every cycle has length 2 * l
- number of cycles:

    k * (k - 1) / 2

---

## Global Consistency

All BCCs must agree on the same cycle length.

Procedure:

- the first detected cycle defines the global length L
- every subsequent cycle must match L
- otherwise → MEOW-NO

---

## Counting Routes

Each simple cycle of length L contributes:

    2 * L

routes (different starting points and directions).

If the total number of cycles is C, then:

    total routes = (2 * L * C) mod (1e9 + 7)

---

## Final Algorithm

1. Run Tarjan to decompose the graph into BCCs
2. For each BCC:
   - ignore if it contains no cycle
   - if E == V:
     - count 1 cycle
   - otherwise:
     - verify it has exactly two hubs (s, t)
     - enumerate all s → t paths
     - check that all path lengths are equal
     - count k * (k - 1) / 2 cycles
3. enforce a global common cycle length
4. output result

---

## Files

- `paw_idea.md`: core modeling and structural insight
- `paw_annotated_en.c`: annotated implementation
- `algorithm.pdf`: detailed technical write-up

---

## Relationship to the Final Implementation

The final executable version is located in:

    ../src/paw.c

The files in this directory document the transition from structural insight
(BCC decomposition and graph classification) to a complete linear-time solution.
