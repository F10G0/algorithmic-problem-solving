# Algorithm Notes

This directory contains materials explaining the core algorithm behind the LUC solution.

## Goal

Given `n` cats and `m` matches, each match specifies two participants but does not specify the winner.

The task is to assign a winner to every match such that:

- the number of wins of every cat is bounded,
- the maximum number of wins among all cats is minimized.

The output should include:

- the minimum possible maximum number of wins,
- a valid assignment of winners for all matches.

---

## Main Observation

Each match can be seen as an undirected edge between two cats.

Assigning a winner is equivalent to orienting that edge toward the winner.

Therefore:

> The number of wins of a cat equals its indegree in the oriented graph.

So the problem becomes:

> Orient all edges so that the maximum indegree is minimized.

---

## Reformulation

Let `L` be the maximum allowed number of wins for any cat.

The problem reduces to checking:

> Is there an orientation such that every cat has at most `L` wins?

This decision problem is monotone:

- If a value `L` is feasible, then any larger value is also feasible.
- If a value `L` is not feasible, then any smaller value is also not feasible.

This allows us to apply binary search on `L`.

---

## Initial Assignment

We begin with a simple greedy orientation:

- for each match `(u, v)`, assign the win to the cat with fewer current wins.

This produces a reasonably balanced starting point, which can later be adjusted.

---

## Core Insight: Augmenting Paths

If a cat currently has more than `L` wins, we must reassign one of its winning matches.

However, directly flipping a match may cause the other endpoint to exceed `L`.

To resolve this, we use an augmenting path:

1. start from an overloaded cat `x`,
2. follow a match currently won by `x` to its opponent `y`,
3. if `y` has fewer than `L` wins, we can transfer the win directly,
4. otherwise, continue from `y` and try to move one of its wins,
5. repeat until reaching a cat with available capacity.

If such a path is found, we flip all winners along the path.

---

## Path Interpretation

An augmenting path is a sequence of matches:

    x → y → z → ... → t

where:

- each step follows a match currently won by the current cat,
- the final cat `t` has fewer than `L` wins.

After flipping all matches along the path:

- the starting cat loses one win,
- the final cat gains one win,
- all intermediate cats keep the same number of wins.

---

## BFS-Based Search

To find augmenting paths efficiently, the implementation uses BFS:

- nodes: cats
- edges: matches currently won by the current cat

From a cat `u`, we only traverse matches where `u` is the current winner.

This ensures that every traversal step corresponds to a valid transfer of one win.

BFS is chosen because:

- it avoids deep recursion,
- it systematically explores possible reassignment chains,
- it allows easy reconstruction of the path.

---

## Feasibility Check

To test a fixed limit `L`:

1. iterate over all cats,
2. while a cat has more than `L` wins:
   - attempt to find an augmenting path starting from it,
   - if no such path exists, `L` is not feasible,
3. if all cats can be adjusted to satisfy the limit, `L` is feasible.

Each successful augmentation reduces the total overload by one.

---

## Binary Search

Since feasibility is monotone, we apply binary search to find the minimum feasible `L`.

- lower bound: `⌊m / n⌋`
- upper bound: `m`

After determining the optimal value, one final feasibility pass produces a valid assignment.

---

## Alternative Implementation

An alternative DFS-based implementation of augmenting paths is provided in:

- `luc_dfs.c`

This version follows the same idea but uses recursion instead of BFS.
It is conceptually simpler, but the BFS version is generally more stable.

---

## Files

- `luc_annotated_en.c` — annotated BFS-based implementation  
- `luc_dfs.c` — alternative DFS-based augmenting path implementation  
- `algorithm.pdf` — detailed technical write-up  

---

## Relationship to the Final Implementation

The final executable version is located in `../src/luc.c`.

The files in this directory document:

- the graph interpretation of the problem,
- the binary search + augmenting path strategy,
- and alternative implementations of the same core idea.
