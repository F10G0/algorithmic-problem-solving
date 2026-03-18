# Solutions Overview

This directory contains multiple implementations of the BUR problem, each corresponding to a different algorithmic strategy.

All solutions are based on the same core reduction:

> repeatedly selecting k smallest elements from a dynamic set

The difference lies in how this operation is implemented.

---

## Implementations

### bur_bruteforce.c

- **Approach:** naive simulation  
- **Method:** recompute costs and scan all elements each round  
- **Complexity:** O(n²)  

**Notes:**

- simplest implementation  
- useful as a correctness baseline  

---

### bur_sort.c

- **Approach:** sorting-based solution  
- **Method:** sort costs each round and take first k  
- **Complexity:** O(n² log n)  

**Notes:**

- conceptually straightforward  
- inefficient due to repeated sorting  

---

### bur_bucket_basic.c

- **Approach:** basic bucket counting  
- **Method:** compute costs into an array, then count frequencies  
- **Complexity:** O(n²)  

**Notes:**

- clean and easy-to-understand bucket implementation  
- serves as a transition from brute force to optimized solutions  

---

### bur_bucket.c

- **Approach:** optimized bucket counting  
- **Method:** integrate counting and updates with reduced overhead  
- **Complexity:** O(n²)  

**Notes:**

- avoids extra arrays  
- faster than the basic version  

---

### bur_bucket_simd.c

- **Approach:** highly optimized bucket  
- **Method:** uses loop unrolling and wide-memory operations  
- **Complexity:** O(n²)  

**Notes:**

- very small constant factors  
- cache-friendly and performance-oriented  

---

### bur_treap.c

- **Approach:** balanced tree (Treap)  
- **Method:** maintain ordered structure and support dynamic k-smallest queries  
- **Complexity:** O(n log n)  

**Notes:**

- asymptotically optimal solution  
- more complex implementation  

---

## Comparison

| File                   | Method              | Complexity      | Difficulty | Practical Speed |
|------------------------|---------------------|----------------|------------|-----------------|
| bur_bruteforce.c       | brute force         | O(n²)          | Easy       | Medium          |
| bur_sort.c             | sorting             | O(n² log n)    | Easy       | Slow            |
| bur_bucket_basic.c     | bucket (basic)      | O(n²)          | Easy       | Medium          |
| bur_bucket.c           | bucket              | O(n²)          | Easy       | Fast            |
| bur_bucket_simd.c      | optimized bucket    | O(n²)          | Medium     | Very Fast       |
| bur_treap.c            | Treap               | O(n log n)     | Hard       | Fast            |

---

## When to Use

- learning / debugging → `bur_bruteforce.c`  
- simple implementation → `bur_bucket.c`  
- understanding bucket optimization → `bur_bucket_basic.c`  
- performance-critical → `bur_bucket_simd.c` or `bur_treap.c`  

---

## Key Takeaway

All implementations solve the same underlying problem:

> dynamic order statistics with repeated updates

The choice of solution depends on how efficiently this operation is handled.

---

## Evolution Path

This directory demonstrates the progression:

brute force → sorting → bucket → optimized bucket → balanced tree
