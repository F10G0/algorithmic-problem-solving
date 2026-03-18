# FAL — Falling Cats

This project implements an efficient algorithm to determine the earliest time each cat becomes disconnected from the root (cat 1) and falls.

The solution is based on reverse processing of edge deletions and union-find (disjoint set union).

---

## Problem

We are given a set of cats connected by grabbing relations.

- Each cat may hold up to 4 other cats
- Over time, specific grabbing edges are removed
- A cat falls when it is no longer connected to cat 1

For each cat `2..n`, determine the earliest time it becomes disconnected from cat 1.

---

## Key Idea

Instead of processing edge deletions directly, we reverse the process:

- interpret deletions as edge insertions in reverse time
- build the final graph after all deletions
- process events backward while maintaining connectivity

When a connected component first reconnects to node `1` in reverse time, that moment corresponds to the time it becomes disconnected (falls) in forward time.

---

## Repository Structure

- `src/` — final implementation  
- `docs/` — algorithm explanation and derivation  
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

- transforms edge deletions into insertions via reverse processing
- uses union-find for near-linear time complexity
- clean handling of component-level time propagation
- fully reproducible with automated tests

---

## Documentation

- `docs/README.md` — concise algorithm overview  
- `docs/fal_idea.md` — detailed reasoning and intuition  
- `docs/algorithm.pdf` — structured technical write-up  

---

## Notes

This problem demonstrates a classic technique for handling dynamic connectivity with deletions by converting it into an offline insertion problem.

The main challenge lies in the modeling and reversal of time, rather than the implementation itself.
