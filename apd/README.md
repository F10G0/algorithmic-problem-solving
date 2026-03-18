# APD — Maximum Compatible Cat Set

This project implements an efficient algorithm to select the largest possible subset of cats such that no two selected cats are in conflict.

The solution is based on a parameterized reduction from Maximum Independent Set to Vertex Cover, combined with kernelization and branching.

---

## Problem

Given $n$ cats and $m$ conflict pairs, determine the largest subset of cats such that no two selected cats conflict.

If the maximum achievable subset has size less than $k$, output `CATASTROPHE`.

---

## Key Idea

Instead of directly solving Maximum Independent Set, we:

- transform the problem into Minimum Vertex Cover using complementarity
- exploit the constraint $n - k \le 15$
- solve the problem as a parameterized instance

The small parameter allows efficient reduction and search.

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

- parameterized algorithm (FPT) with small solution size  
- effective kernelization via high-degree reduction  
- exponential search limited to $O(2^s)$ with $s \le 15$  
- clean separation of idea, annotated code, and final implementation  
- fully reproducible with automated tests  

---

## Documentation

- `docs/README.md` — concise algorithm overview  
- `docs/algorithm.pdf` — structured summary of the core idea  

---

## Notes

This project focuses on structural problem transformation and parameterized algorithm design, rather than multi-stage modeling complexity.
