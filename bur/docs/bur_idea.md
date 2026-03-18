# BUR — Idea

## Core Observation

At first glance, this problem looks like a complex multi-round voting game.

However, with **backward reasoning**, the entire process becomes much simpler.

---

## Step 1 — Backward Thinking

Assume we already know the final outcome for all cats before `i`.

Now consider cat `i` as the proposer.

If their proposal is rejected:

- cat `i` is removed  
- the game continues with cats `< i`  
- all previous cats already have a known outcome  

So for every previous cat `j < i`, we know:

    d_j = bundles they get if current proposal is rejected

---

## Step 2 — Voting = Buying Support

A cat `j` will vote YES if:

- they would otherwise be eliminated, OR  
- they receive at least:

    b_j >= d_j + a_j

So the minimum cost to convince cat `j` is:

    cost_j = d_j + a_j

---

## Step 3 — Problem Transformation

Now the problem becomes:

We have:
- `i` previous cats  
- each cat has a cost: `cost_j = d_j + a_j`  

We need:
- `k = floor(i / 2)` supporters  

---

## Step 4 — Greedy Insight

To minimize total cost:

    Always pick the k smallest cost_j

Reason:

- any other choice increases total cost  
- smaller cost = cheaper vote  

---

## Step 5 — Feasibility Check

Let:

    C = sum of k smallest cost_j

Then:

- if `C > m` → impossible → proposer is eliminated  
- else → proposal succeeds  

---

## Step 6 — Constructing the Split

If successful:

- selected cats receive:  
  `b_j = cost_j`

- unselected cats receive:  
  `b_j = 0`

- proposer receives:  
  `b_i = m - C`

---

## Step 7 — Tie-Breaking Rule

If multiple cats have equal cost:

    Choose smaller index first

This matches the requirement:

> minimize bundles assigned to i+1, then i+2, ...

---

## Final Model

Each round reduces to:

1. compute `cost_j = b_j + a_j`  
2. select `k = floor(i / 2)` smallest `(cost_j, j)`  
3. check if sum ≤ `m`  
4. update state  

---

## Key Reduction

The entire problem is equivalent to:

> repeatedly selecting k smallest elements from a dynamic set

---

## Why This Matters

All game complexity disappears.

What remains is:

- order statistics  
- greedy selection  
- dynamic updates  

---

## Implementation Paths

This directly leads to multiple solutions:

- O(n² log n) — sort every round  
- O(n²) — bucket counting  
- O(n log n) — balanced tree (Treap)  

---

## One-Line Summary

The problem is a dynamic k-smallest selection problem disguised as a voting game.
