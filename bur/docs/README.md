# Algorithm Notes

This directory contains materials explaining the core algorithm behind the BUR solution.

## Goal

Given a sequence of cats, each with a required improvement value `a_i`, and a fixed number of bundles `m`, the task is to determine how bundles are distributed under the following process:

- cats propose distributions one by one  
- each proposal is accepted only if it gains enough votes  
- otherwise, the proposer is eliminated  

The goal is to determine the final bundle distribution.

---

## Main Observation

Instead of simulating the voting process directly, we analyze the game **backwards**.

At each step, the decision depends only on:

- what each previous cat would receive if the current proposal is rejected  

This allows us to reduce the dynamic voting process to a deterministic selection problem.

---

## Cost Interpretation

For each previous cat `j`, define:

    cost_j = d_j + a_j

where:

- `d_j` is the amount cat `j` would receive if the proposal is rejected  
- `a_j` is the required improvement  

A cat votes YES if and only if it receives at least `cost_j`.

---

## Core Insight

To pass a proposal, the proposer must convince at least:

    k = floor(i / 2)

cats.

Thus, the problem reduces to:

> selecting k cats with minimum total cost

---

## Greedy Reduction

The optimal strategy is:

> always choose the k smallest cost_j

This minimizes the total bundles required to secure enough votes.

---

## Feasibility Condition

Let:

    C = sum of k smallest cost_j

Then:

- if `C > m`, the proposal fails  
- otherwise, it succeeds  

---

## Dynamic Structure

After each step:

- new values `b_j` are assigned  
- costs are updated:

    cost_j = b_j + a_j  

Thus, the system evolves dynamically across steps.

---

## Final Reformulation

The entire problem is equivalent to:

> repeatedly selecting k smallest elements from a dynamically changing multiset

---

## Algorithmic Implication

This formulation leads directly to several implementations:

- sorting-based solution  
- bucket-based optimization  
- balanced tree (Treap) solution  

Each improves efficiency in handling dynamic order statistics.

---

## Files

- `bur_idea.md`  
  Intuition and reasoning behind the greedy strategy  

- `bur_model.md`  
  Formal mathematical formulation of the problem  

- `bur_complexity.md`  
  Comparison of different implementations and complexities  

- `bur_annotated_en.c`  
  Annotated implementation (English)  

- `algorithm.pdf`  
  Detailed technical write-up  

---

## Relationship to the Final Implementation

The final executable version is located in `../src/bur.c`.

The materials in this directory explain the full progression:

    intuition → formal model → algorithm design → implementation
    