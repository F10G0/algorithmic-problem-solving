# LUC — Minimum Maximum Wins

This project implements an efficient algorithm to assign winners in incomplete match results such that the maximum number of wins of any participant is minimized.

The solution is based on binary search combined with augmenting path reassignments in a graph interpretation of the problem.

---

## Problem

Given `n` cats and `m` matches, each match specifies two participants but does not specify the winner.

Determine an assignment of winners such that:

- every match has exactly one winner,
- the maximum number of wins among all cats is minimized.

---

## Key Idea

Instead of assigning winners greedily and stopping there, we:

- interpret matches as edges in a graph
- treat wins as indegrees of nodes
- binary search the maximum allowed wins `L`
- use augmenting paths to redistribute wins when a cat exceeds `L`

The augmenting path process allows local adjustments that preserve validity while reducing overload.

---

## Repository Structure

- `src/` — final implementation  
- `docs/` — algorithm explanation and annotated code  
- `tests/` — sample inputs and automated test scripts  
- `problem/` — original problem statement  

---

## Usage

### Build

See `src/README.md`

### Test

See `tests/README.md`

---

## Highlights

- graph-based formulation of win assignment as edge orientation
- binary search on the optimal maximum load
- augmenting path technique for local reassignment
- both BFS-based and DFS-based implementations provided
- efficient handling of large inputs with adjacency lists and timestamp marking

---

## Documentation

- `docs/README.md` — concise algorithm overview  
- `docs/algorithm.pdf` — detailed technical write-up  

---

## Notes

This project focuses on transforming a combinatorial assignment problem into a graph optimization problem, and solving it with classical techniques such as binary search and augmenting paths.
