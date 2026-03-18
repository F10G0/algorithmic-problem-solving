# CAT — Minimum Stroll Distance Between Parks

This project implements an efficient algorithm to compute the minimum total distance traveled in `stroll` mode when moving between parks on a grid with alternating movement rules.

The solution is based on a geometric reformulation combined with graph sparsification and Dijkstra’s algorithm.

---

## Problem

Given $n$ parks on a 2D grid, each represented by coordinates $(x_i, y_i)$, Dexter wants to travel from park `1` to park `n`.

He moves only horizontally or vertically. During movement:

- he alternates between `stroll` and `sprint`
- every $90^\circ$ turn switches the mode
- at each park, he may freely choose the starting mode

The objective is:

> minimize the total distance traveled in `stroll` mode.

---

## Key Idea

Instead of simulating movement and turns, we observe that:

- any path between two parks consists of one horizontal and one vertical segment
- we can assign the longer segment to `sprint` and the shorter to `stroll`

Thus, the cost between two parks becomes:

- `cost(u, v) = min(|x_u - x_v|, |y_u - y_v|)`

This transforms the problem into a shortest path problem on a complete graph.

To avoid $O(n^2)$ edges, we exploit the structure of the cost function:

- only points close in x or y can produce small weights
- it is sufficient to connect each point to its neighbors in sorted order by x and y

This reduces the graph to $O(n)$ edges, allowing efficient shortest path computation.

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

- reduction from movement rules to a simple edge weight formula
- transformation of a complete graph into a sparse graph via sorting
- efficient `O(n log n)` solution using Dijkstra
- clean separation of idea, algorithm, and implementation
- fully reproducible with automated tests

---

## Documentation

- `docs/README.md` — concise algorithm overview  
- `docs/cat_idea.md` — modeling intuition and key insights  
- `docs/algorithm.pdf` — detailed technical write-up  

---

## Notes

This problem demonstrates a common competitive programming pattern:

> special edge weight + geometric ordering → sparse graph + shortest path

The main challenge lies in modeling and recognizing the structure, rather than implementation complexity.
