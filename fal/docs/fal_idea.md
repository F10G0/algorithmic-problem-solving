# FAL — Idea

## 1. Problem Modeling

We model each cat as a vertex in a graph.

- Cat 1 is the root (always attached to the branch)
- Each paw relation becomes an edge
- A cat falls ⇔ it is no longer connected to node 1

So the problem becomes:

> Given a graph with edge deletions over time, find for each node the earliest time it becomes disconnected from node 1.

---

## 2. Key Difficulty

The operations are **edge deletions**.

Dynamic connectivity with deletions is difficult because:

- Removing an edge may split a connected component
- Maintaining connectivity online requires complex data structures (e.g. link-cut trees)

Given the constraints (up to 1e6 operations), a direct simulation is infeasible.

---

## 3. Core Trick — Reverse Processing

Instead of handling deletions forward, we reverse time.

Forward:
- edges are removed

Reverse:
- edges are added back

This transforms the problem into:

> Dynamic connectivity with edge insertions

which can be efficiently handled using union-find (DSU).

---

## 4. Critical Observation

The key equivalence:

> Reverse: first time a component connects to node 1  
> =  
> Forward: first time that component becomes disconnected from node 1

Why?

- In forward time, a component falls when it **loses all paths to 1**
- In reverse time, the same component reconnects when a **new path to 1 appears**
- The order of operations is exactly reversed

Thus, the moment of reconnection in reverse is exactly the moment of disconnection in forward.

---

## 5. Overall Strategy

### Step 1 — Record deletions

For each event:
- store the edge being removed
- remove it from the current graph

After processing all events, we obtain the **final graph**.

---

### Step 2 — Build final state

Construct connected components using only edges that are never deleted.

At this point:
- this represents the graph after all operations
- some nodes may already be disconnected from 1

---

### Step 3 — Process in reverse

Iterate events from m → 1:

For each edge (u, v):

1. Check their components:
   - if one component is connected to 1 and the other is not  
     → the disconnected component reconnects at time t

2. Record:
   - assign falling time t to that component

3. Merge:
   - union the two components

---

## 6. Time Propagation

We do not assign times to every node immediately.

Instead:

- store the falling time at the component root
- use path compression in DSU to propagate values later

This ensures:
- each node eventually inherits the correct falling time
- no extra traversal is needed

---

## 7. Why It Works

For any node x ≠ 1:

- In forward time:
  - it falls when its component first loses connection to 1

- In reverse time:
  - it reconnects when an edge restores connectivity to 1

Because operations are strictly reversed:

> the first reconnection moment in reverse  
> equals the first disconnection moment in forward

---

## 8. Complexity

- Union-Find operations: amortized O(α(n))
- Total operations: O(n + m)

Overall:

O((n + m) α(n))

Memory:

O(n + m)

---

## 9. Pattern

This problem follows a classic competitive programming pattern:

Edge deletions  
→ reverse processing  
→ edge insertions  
→ union-find

This pattern is widely applicable in:

- dynamic connectivity problems
- offline query processing
- problems where deletions are hard but insertions are easy
