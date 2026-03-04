// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: (visited, numtodos, content)
#let dfs(graph, start, counter) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, numtodos, content)
  let dfs-helper(node, visited-numtodos, counter) = {
    // Show visited leaf
    let status_upper = upper(graph.at(node).status)
    let content = block({
      status_upper + numbering(" 1.1: ", ..counter)
      graph.at(node).content
    })

    if visited-numtodos.keys().contains(node) {
      return (visited-numtodos, content)
    }

    let numtodos = if status_upper == "TODO" {1} else {0}

    // The sum of subs numtodos is updated after visiting all subs
    visited-numtodos.insert(node, numtodos)

    // Visit all unvisited subs
    counter.push(1)
    for sub in graph.at(node).subs {
      let (sub-visited-numtodos, sub-content) = dfs-helper(sub, visited-numtodos, counter)
      visited-numtodos = sub-visited-numtodos
      numtodos += visited-numtodos.at(sub)
      if visited-numtodos.at(sub) > 0 {
        content += sub-content
        counter.at(-1) += 1
      }
    }
    // Update the numtodos
    visited-numtodos.insert(node, numtodos)

    if numtodos == 0 {content=none}

    return (visited-numtodos, content)
  }

  // Start DFS from the start node
  dfs-helper(start, (:), counter)
}

// DFS that visits all connected components
// Returns array of all nodes in DFS order
#let dfs-all(graph) = {
  let visited-numtodos = (:)
  let content = []
  let counter = (1,)

  for node in graph.keys() {
    if not visited-numtodos.keys().contains(node) {
      let (new-visited-numtodos, new-content) = dfs(graph, node, counter)
      visited-numtodos += new-visited-numtodos
      content += new-content
      counter.at(0) += 1
    }
  }

  return content
}
