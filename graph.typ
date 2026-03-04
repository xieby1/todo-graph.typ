// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: (visited, numtodos, content)
#let my-heading = heading.with()

#let dfs(graph, start) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, numtodos, content)
  let dfs-helper(node, visited-numtodos, level:1) = {
    // Show visited leaf
    let status_upper = upper(graph.at(node).status)
    let content = my-heading(
      level:level,
      numbering: (..num) => status_upper + " " + num.pos().map(str).join(".") + ".",
      supplement:status_upper,
      graph.at(node).content
    )
    content = {
      if status_upper == "DONE" { text(fill:gray, content) }
      else if status_upper == "ABORT" { text(fill:gray, strike(content)) }
      else { content }
    }

    if visited-numtodos.keys().contains(node) {
      return (visited-numtodos, content)
    }

    let numtodos = if status_upper == "TODO" {1} else {0}

    // The sum of subs numtodos is updated after visiting all subs
    visited-numtodos.insert(node, numtodos)

    // Visit all unvisited subs
    for sub in graph.at(node).subs {
      let (sub-visited-numtodos, sub-content) = dfs-helper(sub, visited-numtodos, level:level+1)
      visited-numtodos = sub-visited-numtodos
      numtodos += visited-numtodos.at(sub)
      if visited-numtodos.at(sub) > 0 { content += sub-content }
    }
    // Update the numtodos
    visited-numtodos.insert(node, numtodos)

    if numtodos == 0 {content=none}

    return (visited-numtodos, content)
  }

  // Start DFS from the start node
  dfs-helper(start, (:))
}

// DFS that visits all connected components
// Returns array of all nodes in DFS order
#let dfs-all(graph) = {
  let visited-numtodos = (:)
  let content = []

  for node in graph.keys() {
    if not visited-numtodos.keys().contains(node) {
      let (new-visited-numtodos, new-content) = dfs(graph, node)
      visited-numtodos += new-visited-numtodos
      content += new-content
    }
  }

  return content
}
