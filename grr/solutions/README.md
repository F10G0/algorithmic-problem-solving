# Solution Variants — GRR

This directory contains multiple solution attempts for the GRR problem, reflecting the full evolution from incorrect modeling to the final implementation.

---

## Overview

| File | Method | Status | Description |
|------|--------|--------|------------|
| grr_path_count_wrong.c | path counting | ❌ wrong | Treats the problem as path coverage; incorrect modeling |
| grr_local_topo_wrong.c | local topological reasoning | ❌ wrong | Uses only local adjacency; ignores transitive reachability |
| grr_dag_comparability_experimental.c | DAG comparability structure | ⚠️ experimental | Attempts structural optimization without explicit sets |
| grr_dag_reachability_set.c | SCC-DAG reachability sets | ✅ final | Correct solution using forward/backward reachability |

---

## Evolution of Ideas

The solutions progress through several key stages:

1. **Path-based thinking (incorrect)**  
   Interprets the problem as requiring nodes to lie on all paths.  
   This fails because the problem is about reachability between arbitrary pairs, not path coverage.

2. **Local topo reasoning (insufficient)**  
   Attempts to use topological order and local edge constraints.  
   This fails because reachability is transitive and cannot be captured by local information alone.

3. **Reachability-set formulation (correct)**  
   After SCC compression, the problem becomes a comparability condition in a DAG.  
   This leads to computing forward and backward reachable sets for each SCC.

4. **Structural optimization (experimental)**  
   Attempts to avoid explicit set construction by exploiting DAG structure.  
   While promising, this approach is harder to implement correctly and was not adopted as the final solution.

---

## Final Approach

The final adopted solution is:

> SCC compression + DAG construction + forward/backward reachability set propagation

For each SCC `C`, we compute:

- all SCCs reachable from `C`
- all SCCs that can reach `C`

Then `C` is valid if these two sets together cover all SCCs.

---

## Notes

- The final solution is **correct and conceptually clean**, but may be heavy in worst-case complexity.
- The experimental version explores a more efficient direction based on DAG structure, which may be improved further in the future.

---

## Usage

The final implementation used for submission is:

```
../src/grr.c
```

which corresponds to:

```
grr_dag_reachability_set.c
```

in this directory.
