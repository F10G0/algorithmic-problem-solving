# BUR — Complexity & Implementation Evolution

## Overview

This problem admits multiple solutions with very different complexities.

All implementations are based on the same core idea:

> repeatedly select the k smallest values from a dynamic set

The difference lies in how we maintain and query this set efficiently.

---

## Core Operation

At step i, we need to:

1. compute cost_j = b_j + a_j for all j < i  
2. select k = floor(i / 2) smallest values  
3. compute their sum  
4. update all values  

So the bottleneck is:

> dynamic k-smallest selection + updates

---

## Solution 1 — Sorting Every Round

### Method

- build an array of pairs (cost_j, j)
- sort it
- take first k elements

### Complexity

- per round: O(i log i)
- total: O(n² log n)

### Pros

- simplest implementation
- easy to verify correctness

### Cons

- too slow for large n
- repeated sorting is wasteful

---

## Solution 2 — Quickselect / Partial Selection

### Method

- use selection algorithm (k-th element)
- partition array
- sum smallest k elements

### Complexity

- average per round: O(i)
- total: O(n²)

### Pros

- avoids full sorting
- better asymptotics than sorting

### Cons

- still quadratic
- harder to implement correctly
- unstable ordering (tie-breaking needs care)

---

## Solution 3 — Bucket Counting (Key Optimization)

### Key Observation

a_i ≤ 64

Thus:

cost_j = b_j + a_j is small enough to group efficiently in practice

### Method

- maintain frequency array: bucket[cost]
- scan from small to large
- greedily take k elements

### Complexity

- per round: O(MAXA + i)
- total: O(n²)

### Pros

- very fast in practice
- simple implementation
- no sorting needed

### Cons

- still quadratic in worst case
- relies on bounded value range

---

## Solution 4 — Optimized Bucket (SIMD / Unrolling)

### Method

- same as bucket solution
- optimize memory access and loops:
  - loop unrolling
  - SIMD-like operations
  - cache-friendly layout

### Complexity

- still O(n²)
- much smaller constant

### Pros

- fastest practical solution for constraints
- highly optimized

### Cons

- less readable
- architecture-dependent optimizations

---

## Solution 5 — Balanced Tree (Treap)

### Key Idea

Instead of recomputing everything each round:

- maintain a dynamic ordered structure
- support:
  - insert
  - split by rank
  - count ≤ x
  - merge

### Data Structure

- group by cost
- each group is a Treap ordered by index

### Method

At each step:

1. iterate costs from small to large  
2. accumulate counts until reaching k  
3. locate split point using binary search + count  
4. split trees and update states  

### Complexity

- per round: O(log n)
- total: O(n log n)

### Pros

- optimal asymptotic complexity
- scalable to large inputs
- clean theoretical solution

### Cons

- complex implementation
- requires careful handling of splits and merges

---

## Comparison Table

| Method            | Complexity        | Difficulty | Practical Speed |
|------------------|------------------|-----------|-----------------|
| Sort             | O(n² log n)      | Easy      | Slow            |
| Quickselect      | O(n²)            | Medium    | Medium          |
| Bucket           | O(n²)            | Easy      | Fast            |
| Bucket (SIMD)    | O(n²)            | Hard      | Very Fast       |
| Treap            | O(n log n)       | Hard      | Fast            |

---

## When to Use Which

- Small constraints → sorting is enough  
- Moderate constraints → bucket is ideal  
- Tight constraints → Treap or optimized bucket  

---

## Key Insight

All solutions are solving the same problem:

> dynamic order statistics with repeated updates

The only difference is:

> how efficiently we maintain and query the set

---

## Final Takeaway

This problem is a textbook example of:

- transforming a game into greedy selection
- reducing logic to order statistics
- improving complexity via data structures

---

## One-Line Summary

From sorting to Treap, every solution is an optimization of:

> repeatedly selecting k smallest elements under dynamic updates
