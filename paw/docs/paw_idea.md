# PAW — Idea

## 1. Problem Reformulation

A route that Dexter likes:

- starts and ends at the same vertex
- does not visit any other vertex more than once
- does not reuse edges

This is exactly a **simple cycle** in an undirected graph.

So the problem becomes:

> Check whether all simple cycles have the same length.  
> If yes, compute that length and count how many cycles exist.

Each simple cycle of length `L` contributes:

- `L` starting points
- `2` directions

So each cycle contributes:

    2 * L

routes.

---

## 2. Key Observation — Work Inside BCCs

A crucial fact:

> Every simple cycle lies entirely inside a **biconnected component (BCC)**.

Therefore:

- decompose the graph into BCCs using Tarjan
- analyze each BCC independently

The problem reduces to:

> What kinds of BCCs can have all cycles with equal length?

---

## 3. Core Structural Insight

A BCC that satisfies the condition must be one of two types.

### Case 1 — Single Cycle

If

    E == V

then the BCC is a simple cycle.

It contributes:

- exactly `1` cycle
- cycle length = `E`

---

### Case 2 — Theta Structure

Otherwise, the BCC must have:

- exactly two vertices with degree `> 2`, call them `s` and `t`
- all other vertices have degree `2`

This implies:

> multiple internally disjoint paths between `s` and `t`

---

## 4. Equal-Length Condition

Let the `s -> t` paths have lengths:

    l1, l2, ..., lk

Each pair of paths forms one simple cycle:

    cycle length = li + lj

For all cycles to have equal length:

    l1 = l2 = ... = lk = l

So:

- every cycle has length `2 * l`
- number of cycles:

    k * (k - 1) / 2

---

## 5. Invalid Structures

Reject the BCC if any of the following occurs:

- more than two vertices have degree `> 2`
- some non-hub vertex has degree different from `2`
- the `s -> t` path lengths are not all equal

These structures necessarily produce cycles of different lengths.

---

## 6. Global Consistency

Even if each BCC is valid, all cycles must share the same length.

Procedure:

- the first detected cycle defines global length `L`
- every subsequent cycle must match `L`
- otherwise → `MEOW-NO`

---

## 7. Counting

Let:

- `C` = total number of simple cycles
- `L` = common cycle length

Total number of routes:

    (2 * L * C) mod (1e9 + 7)

---

## 8. Algorithm Outline

1. Run Tarjan to find all BCCs
2. For each BCC:
   - ignore if it has no cycle
   - if `E == V`:
     - count 1 cycle
   - otherwise:
     - check degree structure (exactly two hubs)
     - enumerate all `s -> t` paths
     - verify equal lengths
     - count `k * (k - 1) / 2`
3. Enforce global cycle length consistency
4. Output result

---

## 9. Complexity

    Time:  O(n + m)
    Space: O(n + m)

---

## 10. Key Takeaway

This is not a cycle-enumeration problem.

The key idea is:

> characterize all graph structures where every simple cycle has the same length

This reduces a global constraint to a local structural property of BCCs.
