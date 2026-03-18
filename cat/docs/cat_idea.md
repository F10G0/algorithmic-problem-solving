# CAT — Idea

This problem is not difficult in implementation, but requires two key modeling steps that are not immediately obvious.

---

## 1. From movement rules to cost formula

The original problem describes:

- movement on a grid (horizontal / vertical only)
- two modes: `stroll` and `sprint`
- every turn switches the mode
- at each park, we can freely choose the starting mode

---

### Key observation

Consider moving from park `u = (x1, y1)` to park `v = (x2, y2)`.

Let:

- `dx = |x1 - x2|`
- `dy = |y1 - y2|`

Any shortest path consists of:

- one horizontal segment of length `dx`
- one vertical segment of length `dy`

If both are non-zero, there is exactly one turn.

---

### Freedom of choosing the starting mode

Since we can choose the starting mode at park `u`, we can assign:

- one segment to `stroll`
- the other to `sprint`

So we can always:

- assign the longer segment to `sprint`
- assign the shorter segment to `stroll`

---

### Result

The minimum possible stroll cost from `u` to `v` is:

`cost(u, v) = min(dx, dy)`

---

## 2. From geometry to graph

Now the problem becomes:

- nodes = parks
- edge between every pair `(u, v)`
- weight:

`w(u, v) = min(|x_u - x_v|, |y_u - y_v|)`

Goal:

`shortest path from 1 to n`

---

## 3. The bottleneck: complete graph

This creates a complete graph:

- number of edges = `O(n^2)`
- impossible for `n` up to `200000`

We must reduce edges.

---

## 4. Critical insight: only "nearby" points matter

The weight is:

`w(u, v) = min(dx, dy)`

So an edge is cheap only if:

- x difference is small, or
- y difference is small

---

## 5. Sorting trick

Sort points by x:

`... — u — k — v — ...`

If `k` lies between `u` and `v`, then:

`|x_u - x_k| ≤ |x_u - x_v|`

So moving from `u` to `k` is always at least as competitive in the x-direction as moving to `v`.

The same argument holds for y.

---

## 6. Key conclusion

For each point, it is sufficient to consider only:

- neighbors in sorted order by x
- neighbors in sorted order by y

That is:

`each node → at most 4 edges`

- previous / next in x-order
- previous / next in y-order

---

## 7. Why this works

Any optimal path using a "long jump" edge `(u, v)` can be replaced by a sequence of shorter jumps through intermediate points without increasing cost.

Thus, the optimal path is preserved in this sparse graph.

---

## 8. Final algorithm

1. Sort points by x and by y.
2. For each point, connect:
   - x neighbors
   - y neighbors
3. Run Dijkstra.
4. Answer = `distance[n]`.

---

## 9. Complexity

- sorting: `O(n log n)`
- edges: `O(n)`
- Dijkstra: `O(n log n)`

Total:

`O(n log n)`

---

## 10. Essence of the problem

This is a classic pattern:

`complete graph`
`+ special edge weight`
`→ sort + keep only adjacent edges`
`→ sparse graph + Dijkstra`

The difficulty is not coding, but recognizing:

- the cost formula `min(dx, dy)`
- and the adjacency reduction trick
