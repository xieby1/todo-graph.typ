// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: array of node names in DFS order
#let dfs(graph, start) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, traversal order)
  let dfs-helper(node, visited, order) = {
    if visited.contains(node) {
      return (visited, order)
    }

    let new-visited = visited + (node,)
    let new-order = order + (node,)

    // Get neighbors, default to empty array if node not in graph
    let neighbors = graph.at(str(node))

    // Visit all unvisited neighbors
    for neighbor in neighbors {
      (new-visited, new-order) = dfs-helper(neighbor, new-visited, new-order)
    }

    return (new-visited, new-order)
  }

  // Start DFS from the start node
  let (visited, order) = dfs-helper(start, (), ())
  return order
}

#{
  let graph = (n0:("n1",), n1:("n2","n3"), n2:("n4",), n3:("n4",), n4:())
  dfs(graph, "n0")
}

// DFS that visits all connected components
// Returns array of all nodes in DFS order
#let dfs-all(graph) = {
  let all-nodes = graph.keys()
  let visited = ()
  let order = ()

  for node in all-nodes {
    if not visited.contains(node) {
      let component = dfs(graph, node)
      for n in component {
        if not visited.contains(n) {
          visited = visited + (n,)
          order = order + (n,)
        }
      }
    }
  }

  return order
}
