# Algorithm Notes

This directory contains materials explaining the core algorithm behind the APD solution.

## Goal

Given $n$ cats and $m$ conflict pairs, the task is to select the largest possible subset of cats such that no two selected cats are in conflict.

Additionally, if the maximum achievable subset has size less than $k$, the output should be `CATASTROPHE`.

## Main Observation

Each cat can be viewed as a vertex, and each conflict pair as an undirected edge.

So the problem becomes:

> Find the largest subset of vertices with no edges between them.

This is exactly the **Maximum Independent Set (MIS)** problem.

---

## Structural Constraint

The key constraint is:

n - k ≤ 15

This means we are allowed to remove at most a small number of vertices.

Let:

s = n - k

Instead of directly constructing a large independent set, we consider removing a small set of vertices that covers all edges.

---

## Vertex Cover Reformulation

A set of vertices that covers all edges is called a **Vertex Cover (VC)**.

There is a standard relation:

|MIS| = n - |VC|

So the problem becomes:

> Find a vertex cover of size at most s.

If such a set exists, its complement is an independent set of size at least $k$.

To maximize the result, we compute the **minimum vertex cover**.

---

## Kernelization

We first simplify the graph using a standard reduction rule.

If a vertex $v$ satisfies:

deg(v) > s

then $v$ must be included in any vertex cover of size ≤ s.

Otherwise, all its neighbors would need to be selected, which exceeds the limit.

So we:

- include $v$ in the cover
- decrease $s$
- remove its incident edges

This process is repeated until no such vertex exists.

---

## Edge Bound

After kernelization, all remaining vertices satisfy:

deg(v) ≤ s

In this case, if a vertex cover of size ≤ s exists, then:

|E| ≤ s²

If this bound is violated, the instance is immediately impossible.

---

## Branching

If edges still remain, pick any uncovered edge (u, v).

To cover this edge, we must choose:

- u, or
- v

This creates two recursive branches, each reducing the remaining budget by 1.

---

## Core Insight

The problem is not solved as a general MIS instance.

Instead, the key is:

> The complement (vertices to remove) is small.

This allows us to transform the problem into a **parameterized Vertex Cover** instance and solve it efficiently.

---

## Final Algorithm

1. Build the conflict graph.
2. Set s = n - k.
3. Apply kernelization using the high-degree rule.
4. If |E| > s², return `CATASTROPHE`.
5. Use branching to find the minimum vertex cover.
6. Output all vertices not in the cover.

---

## Files

- `apd_idea.md`: core idea and structural explanation
- `apd_annotated_en.c`: English annotated implementation
- `algorithm.pdf`: concise summary of the algorithm

---

## Relationship to the Final Implementation

The final executable version is located in `../src/apd.c`.

The files in this directory document the transformation from a maximum independent set problem to a parameterized vertex cover solution.
