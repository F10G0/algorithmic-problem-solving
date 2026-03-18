# PAW — Park Walks (Equal-Length Cycles)

This project implements an efficient algorithm to determine whether all simple cycles in an undirected graph have the same length, and if so, counts the total number of valid routes.

The solution is based on biconnected component (BCC) decomposition and structural classification of cycle-containing subgraphs.

---

## Problem

Given an undirected graph, determine:

- whether there exists at least one simple cycle
- whether all simple cycles have the same length
- and if so, compute that length and the total number of valid routes

A valid route is a closed walk that:

- starts and ends at the same vertex
- does not revisit any other vertex
- does not reuse edges

---

## Key Idea

Instead of enumerating cycles directly, we:

- decompose the graph into biconnected components (BCCs)
- analyze each BCC independently
- classify valid structures that can only produce cycles of equal length

A valid BCC must be either:

- a single simple cycle (`E == V`)
- or a theta structure: two vertices connected by multiple internally disjoint paths of equal length

These constraints ensure all cycles have the same length.

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

- linear-time solution using Tarjan BCC decomposition
- structural classification instead of explicit cycle enumeration
- handles large graphs efficiently (`O(n + m)`)
- clean separation between idea, annotated code, and final implementation
- fully reproducible with automated test scripts

---

## Documentation

- `docs/README.md` — concise algorithm overview  
- `docs/paw_idea.md` — core structural insight  
- `docs/algorithm.pdf` — detailed technical write-up  

---

## Notes

This project emphasizes structural graph reasoning and algorithmic clarity,
showing how global cycle constraints can be reduced to local properties of BCCs.
