// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: (visited, num_todos, content)
#let my-heading = heading.with()

#let dfs(graph, start) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, num_todos, content)
  let dfs-helper(node, visited, level:1) = {
    // Show visited leaf
    let status = graph.at(node).status
    let content = my-heading(
      level:level,
      numbering: (..num) => upper(status) + " " + num.pos().map(str).join(".") + ".",
      supplement:upper(status),
      graph.at(node).content
    )
    content = {
      if status == "done" { text(fill:gray, content) }
      else if status == "abort" { text(fill:gray, strike(content)) }
      else { content }
    }

    if visited.contains(node) {
      return (visited, 0, content)
    }

    visited += (node,)
    let num_todos = if graph.at(node).status == "todo" {1} else {0}

    // Visit all unvisited subs
    for sub in graph.at(node).subs {
      let (sub-visited, sub-num_todos, sub-content) = dfs-helper(sub, visited, level:level+1)
      visited = sub-visited
      num_todos += sub-num_todos
      content += sub-content
    }

    if num_todos == 0 {content=none}

    return (visited, num_todos, content)
  }

  // Start DFS from the start node
  dfs-helper(start, ())
}

// DFS that visits all connected components
// Returns array of all nodes in DFS order
#let dfs-all(graph) = {
  let visited = ()
  let num_todos = 0
  let content = []

  for node in graph.keys() {
    if not visited.contains(node) {
      let (new-visited, new-num_todos, new-content) = dfs(graph, node)
      for n in new-visited { if not visited.contains(n) {visited.push(n)} }
      content += new-content
    }
  }

  return content
}
