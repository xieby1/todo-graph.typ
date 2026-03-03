// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: (num_todos, content)
#let dfs(graph, start) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, num_todos, content)
  let dfs-helper(node, visited) = {
    let num_todos = 0
    let content = []
    if visited.contains(node) {
      return (visited, num_todos, content)
    }

    visited += (node,)
    if graph.at(node).status == "todo" {num_todos += 1}
    content += graph.at(node).content

    // Get neighbors, default to empty array if node not in graph
    let neighbors = graph.at(str(node)).subs

    // Visit all unvisited neighbors
    for neighbor in neighbors {
      let new-num_todos = 0
      let new-content = []
      (visited, new-num_todos, new-content) = dfs-helper(neighbor, visited)
      num_todos += new-num_todos
      content += new-content
    }

    return (visited, num_todos, content)
  }

  // Start DFS from the start node
  let (visited, num_todos, content) = dfs-helper(start, ())
  return (num_todos, content)
}

#{
  let graph = (
    n0:(content:"n0", status:"todo", subs:("n1",)),
    n1:(content:"n1", status:"todo", subs:("n2","n3")),
    n2:(content:"n2", status:"todo", subs:("n4",)),
    n3:(content:"n3", status:"todo", subs:("n4",)),
    n4:(content:"n4", status:"todo", subs:())
  )
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
