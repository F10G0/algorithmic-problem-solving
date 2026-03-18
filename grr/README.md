# GRR — Reachability with Alternating Edge Directions

This project implements an algorithm to identify all vertices in a directed graph that can reach every other vertex when edge directions alternate over time.

The solution is based on SCC compression and reachability analysis in the resulting DAG.

---

## Problem

Given a directed graph:

- on odd days, edges follow their original direction  
- on even days, all edges are reversed  

Determine all vertices `u` such that for every vertex `v`, there exists a day on which `u` can reach `v`.

---

## Key Idea

Instead of fixing a single traversal direction, observe that:

- reaching `v` from `u` on an even day  
  is equivalent to  
- reaching `u` from `v` in the original graph  

So the condition becomes:

> for every vertex `v`, either `u -> v` or `v -> u`

This transforms the problem into a **reachability comparability problem**.

We then:

- compress the graph into strongly connected components (SCCs)
- obtain a DAG
- compute forward and backward reachability sets for each SCC

A node is valid if these sets together cover all SCCs.

---

## Repository Structure

- `src/` — final implementation  
- `docs/` — algorithm explanation, idea, and complexity analysis  
- `solutions/` — alternative and intermediate solution attempts  
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

- SCC-based reduction of a dynamic-direction graph problem  
- transformation into DAG comparability  
- explicit forward/backward reachability formulation  
- clear separation between incorrect, intermediate, and final solutions  
- fully reproducible with automated tests  

---

## Documentation

- `docs/README.md` — concise algorithm overview  
- `docs/grr_idea.md` — reasoning process and modeling evolution  
- `docs/grr_complexity.md` — detailed complexity analysis  
- `docs/algorithm.pdf` — full technical write-up  

---

## Notes

This project emphasizes clarity of problem modeling and solution evolution.

While the final implementation is not asymptotically optimal, it provides a direct and verifiable formulation of the problem using SCC-DAG reachability.
