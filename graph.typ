// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: (visited, num_todos, content)
#let my-heading = heading.with(numbering: "TODO 1.1.", supplement:"TODO")

#let dfs(graph, start) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, num_todos, content)
  let dfs-helper(node, visited, level:1) = {
    // Show visited leaf
    let content = my-heading(level:level, {
      if graph.at(node).status == "done" { text(fill:gray, graph.at(node).content) }
      else if graph.at(node).status == "abort" { text(fill:gray, strike(graph.at(node).content)) }
      else { graph.at(node).content }
    })
    if visited.contains(node) {
      return (visited, 0, content)
    }

    visited += (node,)
    let num_todos = if graph.at(node).status == "todo" {1} else {0}

    let sub-contents = []
    // Visit all unvisited subs
    for sub in graph.at(node).subs {
      let sub-num_todos = 0
      let sub-content = []
      (visited, sub-num_todos, sub-content) = dfs-helper(sub, visited, level:level+1)
      num_todos += sub-num_todos
      sub-contents += sub-content
    }
    content += sub-contents

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
  let contents = []

  for node in graph.keys() {
    if not visited.contains(node) {
      let (new-visited, new-num_todos, new-content) = dfs(graph, node)
      for n in new-visited { if not visited.contains(n) {visited.push(n)} }
      contents += new-content
    }
  }

  return contents
}
