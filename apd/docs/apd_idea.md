# APD – Idea

## Problem Reformulation

We are given $n$ cats and $m$ conflict pairs.  
Each pair indicates that the two cats cannot be selected together.

This defines an undirected graph:

- Each cat → a vertex  
- Each conflict → an edge  

The goal is to select the largest subset of vertices such that no two are adjacent.

This is exactly the **Maximum Independent Set (MIS)** problem.

---

## Key Observation

The constraint:

n - k ≤ 15

implies that we are allowed to remove at most a small number of vertices:

s = n - k ≤ 15

Instead of directly selecting a large independent set, we consider:

> removing a small set of vertices that covers all edges

This is the **Minimum Vertex Cover (MVC)** problem.

---

## Core Transformation

There is a standard complement relation:

|MIS| = n - |MVC|

So the problem becomes:

> Does there exist a vertex cover of size ≤ s = n - k?

If yes:
- the complement of the vertex cover is an independent set
- its size is at least k

To maximize the answer, we actually compute the **minimum vertex cover**.

---

## Algorithm Overview

We solve the problem as a **parameterized Vertex Cover** instance with parameter:

s = n - k ≤ 15

---

### 1. Kernelization (High-Degree Rule)

If a vertex v satisfies:

deg(v) > s

then v must be included in every valid vertex cover.

Reason:

- If v is not selected, all its neighbors must be selected
- That would require more than s vertices → impossible

So we:

- include v in the vertex cover
- decrease s by 1
- remove its incident edges

Repeat until no such vertex exists.

---

### 2. Edge Bound

After kernelization:

deg(v) ≤ s for all remaining vertices

If a vertex cover of size ≤ s exists, then:

|E| ≤ s²

Otherwise, the instance is impossible.

---

### 3. Branching Search

Pick any uncovered edge (u, v).

To cover this edge, we must choose at least one endpoint:

- choose u
- or choose v

Each choice reduces s by 1.

This yields a recursion:

T(s) = 2 · T(s - 1)

So the complexity is:

O(2^s)

Since s ≤ 15, this is efficient.

---

## Result Construction

After computing a minimum vertex cover:

- all vertices **not in the cover** form a maximum independent set

So we output:

V \ VC

---

## Complexity

- Kernel size: O(s²)
- Search: O(2^s)
- s ≤ 15 → feasible

---

## Key Insight

This is not a standard MIS problem.

The crucial observation is:

> The complement (vertices to remove) is small.

This allows us to:

- transform MIS → Vertex Cover
- solve it using parameterized algorithms (FPT)

---

## Tags

- Modeling (non-direct)
- Structural Insight
- Maximum Independent Set
- Vertex Cover
- Parameterized Algorithm
- Kernelization
- Branching
