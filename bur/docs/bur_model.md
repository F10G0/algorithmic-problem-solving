# BUR — Formal Model

## Problem Reformulation

We model the game as a sequential decision process.

At step i:

- a new agent (cat i) proposes a distribution  
- previous agents vote based on their future outcome  

---

## State Definition

For each i, define:

- b_j: bundles assigned to cat j (j < i)  
- a_j: required improvement threshold  

Define:

    d_j = bundles cat j receives if current proposal is rejected

---

## Voting Condition

Cat j votes YES iff:

    b_j >= d_j + a_j

Define cost:

    cost_j = d_j + a_j

---

## Reduction

At step i, the proposer must:

- choose a subset S ⊆ {1, ..., i-1}
- such that:

    |S| ≥ floor(i / 2)

and minimize total cost:

    sum_{j ∈ S} cost_j

---

## Optimization Problem

This becomes:

    minimize   ∑ cost_j over S
    subject to |S| = k

where:

    k = floor(i / 2)

---

## Optimal Solution

The optimal S is:

> the set of k smallest cost_j

---

## Feasibility Constraint

Let:

    C = sum of k smallest cost_j

Then:

- if C > m → infeasible  
- else → feasible  

---

## Transition

If feasible:

- for j ∈ S:
  
      b_j = cost_j

- for j ∉ S:
  
      b_j = 0

- proposer:

      b_i = m - C

---

## Dynamic Structure

At each step, we maintain:

- a multiset of values:

      cost_j = b_j + a_j

- updated after each round  

---

## Abstract Problem

The entire process reduces to:

> repeatedly selecting k smallest elements from a dynamically changing multiset

---

## Equivalent Formulation

We maintain a sequence:

    cost_1, cost_2, ..., cost_{i-1}

Each step:

1. compute k = floor(i / 2)  
2. find k smallest elements  
3. compute their sum  
4. update all values  

---

## Key Properties

- monotonic structure (costs only depend on previous state)  
- repeated order-statistics queries  
- dynamic insertions  

---

## Final Reduction

The problem is equivalent to:

> dynamic order statistics with updates and partial sums

---

## Implication

This model directly determines:

- algorithm design  
- data structure choice  
- time complexity  

---

## One-Line Model

At each step:

> choose k smallest elements from a dynamic multiset and update the system accordingly
