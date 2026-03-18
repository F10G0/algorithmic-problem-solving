# GRR — Complexity Analysis

This document analyzes the time and space complexity of the implemented solution, and explains why it is correct but potentially heavy.

---

## 1. Notation

Let:

- $n$ = number of vertices in the original graph  
- $m$ = number of edges in the original graph  
- $s$ = number of strongly connected components (SCCs)  
- $m'$ = number of edges in the SCC-DAG  

Clearly:

- $s \le n$
- $m' \le m$

---

## 2. SCC Computation

We use Tarjan's algorithm.

- Time complexity:  
  $O(n + m)$

- Space complexity:  
  $O(n)$

This is optimal and not a bottleneck.

---

## 3. SCC-DAG Construction

For each edge $u \to v$:

- map it to $(\text{SCC}(u), \text{SCC}(v))$
- ignore edges inside the same SCC

Then:

- sort and deduplicate edges

### Complexity

- edge processing: $O(m)$  
- sorting: $O(m' \log m')$  

In practice, $m'$ is much smaller than $m$ after SCC compression.

---

## 4. Topological Ordering

The SCC graph is a DAG.

We compute a topological order using DFS.

- Time complexity: $O(s + m')$
- Space complexity: $O(s)$

---

## 5. Reachability Set Propagation

This is the core part of the algorithm.

For each SCC node $C$, we maintain:

- a set of reachable SCCs
- implemented with:
  - a hash table (for membership test)
  - a linked list (for iteration)

---

## 6. Forward Propagation

We compute:

- $\mathrm{Forward}(C)$ for every SCC $C$

For each edge $C \to D$:

- merge the set of $D$ into the set of $C$

Using small-to-large optimization:

- always merge the smaller set into the larger one

---

## 7. Backward Propagation

Similarly, on the reverse DAG:

- compute $\mathrm{Backward}(C)$

The same merging process applies.

---

## 8. Cost of Set Merging

Let $|S_C|$ be the size of the set for node $C$.

Each insertion into a set is:

- expected $O(1)$ (hash table)

However, the total number of insertions is the key factor.

---

### Best Case

If the DAG is shallow or sparse:

- each node reaches only a small number of SCCs
- total insertions: $O(s)$ to $O(s \log s)$

---

### Typical Case

With small-to-large merging:

- each SCC id is moved only a limited number of times
- practical performance is often acceptable

---

### Worst Case

In the worst case:

- the DAG is close to a chain or highly connected structure
- each node may reach almost all other nodes

Then:

- $|S_C| = O(s)$ for many nodes
- total insertions can reach:

\[
O(s^2)
\]

This leads to:

- high time complexity
- high memory usage

---

## 9. Space Complexity

Each set explicitly stores SCC ids.

In the worst case:

- each of the $s$ nodes stores $O(s)$ elements

So total memory can reach:

\[
O(s^2)
\]

Additionally:

- each insertion allocates a node (linked list)
- hash tables may resize multiple times

---

## 10. Overall Complexity Summary

| Phase | Time | Space |
|------|------|------|
| SCC (Tarjan) | $O(n + m)$ | $O(n)$ |
| DAG construction | $O(m' \log m')$ | $O(m')$ |
| Topological order | $O(s + m')$ | $O(s)$ |
| Reachability sets | up to $O(s^2)$ | up to $O(s^2)$ |

---

## 11. Interpretation

The algorithm is:

- ✔ conceptually clean  
- ✔ directly reflects the problem definition  
- ✔ easy to verify for correctness  

But:

- ⚠ not optimal in worst-case complexity  
- ⚠ explicitly computes a form of transitive closure  

---

## 12. Why It Still Works in Practice

In many real or contest inputs:

- SCC compression significantly reduces graph size
- the DAG is not fully dense
- reachable sets remain relatively small

Combined with:

- hash-based insertion
- small-to-large merging

the implementation often performs efficiently enough.

---

## 13. Motivation for Optimization

The main inefficiency comes from:

> Explicitly storing reachability sets

An ideal solution would:

- avoid materializing all reachable nodes
- rely only on structural properties of the DAG

This motivates alternative approaches such as:

- interval-based reasoning in topological order
- comparability structure exploitation

These ideas are explored in the experimental solution.

---

## Summary

The implemented solution runs in:

\[
O(n + m + s^2) \text{ worst case}
\]

with:

- excellent correctness guarantees
- but potentially heavy memory and time usage

It should be viewed as:

> A correct reachability-based formulation,  
> rather than a fully optimized DAG solution.
