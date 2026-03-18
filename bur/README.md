# BUR — Dynamic k-Smallest Selection in Voting Process

This project implements multiple algorithms to solve a sequential voting game by reducing it to a dynamic order-statistics problem.

The core challenge is efficiently selecting the k smallest values under repeated updates.

---

## Problem

Given a sequence of agents (cats), each with a required improvement value `a_i`, and a fixed number of bundles `m`, agents propose distributions one by one.

Each proposal is accepted only if it receives enough votes from previous agents. Otherwise, the proposer is eliminated.

The goal is to determine the final distribution of bundles.

---

## Key Idea

Instead of simulating the voting process directly, we analyze it **backwards**.

At each step:

- each agent has a minimum acceptable value  
- this defines a cost for securing their vote  

Thus, the problem reduces to:

> selecting k = floor(i / 2) agents with minimum total cost

---

## Core Reduction

At every step, we must:

- maintain a set of values `cost_j = b_j + a_j`  
- repeatedly select the k smallest elements  
- update the system  

This transforms the problem into:

> dynamic k-smallest selection with updates

---

## Repository Structure

- `src/` — final implementation  
- `solutions/` — multiple algorithmic implementations (different complexities)  
- `docs/` — idea, model, and complexity analysis  
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

- reduction from a voting game to greedy selection  
- clear separation: idea → model → complexity → implementation  
- multiple solutions illustrating complexity trade-offs  
- includes both practical optimizations and optimal data structure solution  
- fully reproducible with automated tests  

---

## Documentation

- `docs/README.md` — concise overview of the algorithm  
- `docs/bur_idea.md` — intuition and reasoning  
- `docs/bur_model.md` — formal abstraction  
- `docs/bur_complexity.md` — implementation comparison  

---

## Notes

This project emphasizes algorithmic modeling and the evolution of solutions:

from naive simulation to optimized data structures.
