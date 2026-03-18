# Algorithm Notes

This directory contains materials explaining the core algorithm behind the FAL solution.

## Goal

We are given a set of cats connected by grabbing relations, where edges are removed over time.

For each cat `2..n`, the task is to determine the earliest time at which it becomes disconnected from cat `1` (and therefore falls).

---

## Main Observation

A cat falls exactly when it is no longer connected to cat `1`.

Thus, the problem can be reformulated as:

> Given a graph with edge deletions, determine for each node the first time it becomes disconnected from node `1`.

---

## Difficulty

Handling connectivity under edge deletions is difficult:

- Removing an edge may split a connected component
- Maintaining connectivity dynamically under deletions is complex and inefficient at this scale

Therefore, a direct forward simulation is not suitable.

---

## Reverse Processing

Instead of processing deletions directly, we reverse the timeline:

- Forward: edges are deleted  
- Reverse: edges are added back  

We first construct the graph after all deletions, and then process events in reverse order, inserting edges one by one.

This transforms the problem into:

> Dynamic connectivity with edge insertions

which can be efficiently handled using union-find.

---

## Core Insight

The key equivalence is:

- Reverse: the first time a component becomes connected to node `1`  
- Forward: the first time that component becomes disconnected from node `1`

This works because:

- In forward time, a component falls when it loses all paths to `1`
- In reverse time, the same component reconnects when a path to `1` is restored

Thus, reconnection time in reverse equals disconnection time in forward.

---

## Union-Find Strategy

We maintain connected components using a disjoint set union structure.

During reverse processing:

- For each edge `(u, v)`:
  - check whether exactly one of the two components is connected to `1`
  - if so, the other component receives the current time as its falling time
  - merge the two components

Falling times are stored at the component level and propagated via path compression.

---

## Final Algorithm

1. Read the initial graph from paw relations  
2. Record all deletion events and remove corresponding edges  
3. Build the final graph (after all deletions)  
4. Initialize union-find on this graph  
5. Process events in reverse:  
   - before merging, check connectivity to `1`  
   - assign falling time when a component reconnects to `1`  
   - merge components  
6. Propagate results and output answers  

---

## Complexity

O((n + m) α(n))

where `α(n)` is the inverse Ackermann function.

Memory usage is linear:

O(n + m)

---

## Technique

This problem demonstrates a standard competitive programming pattern:

Edge deletions  
→ reverse processing  
→ edge insertions  
→ union-find  

---

## Files

- `fal_idea.md`: detailed reasoning and intuition  
- `algorithm.pdf`: structured write-up and summary  

---

## Relationship to the Final Implementation

The final implementation is located in `../src/fal.c`.

The files in this directory document the transformation from the original deletion-based problem to an efficient reverse-processing solution using union-find.
