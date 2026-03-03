// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: (visited, num_todos, content)
#let dfs(graph, start) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, num_todos, content)
  let dfs-helper(node, visited, indent:0) = {
    // Show visited leaf
    let content = {
      h(1em*indent)
      if graph.at(node).status == "done" { text(fill:gray,[✅#graph.at(node).content]) }
      else if graph.at(node).status == "abort" { text(fill:gray,[❌#graph.at(node).content]) }
      else { graph.at(node).content }
      linebreak()
    }
    if visited.contains(node) {
      return (visited, 0, content)
    }

    visited += (node,)
    let num_todos = if graph.at(node).status == "todo" {1} else {0}

    // Visit all unvisited subs
    for sub in graph.at(str(node)).subs {
      let sub-num_todos = 0
      let sub-content = []
      (visited, sub-num_todos, sub-content) = dfs-helper(sub, visited, indent:indent+1)
      num_todos += sub-num_todos
      content += sub-content
    }

    if num_todos == 0 {content=[]}

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

// TODO: separate as test
#{
  let graph = (
    n0:(content:"n0", status:"todo", subs:("n1",)),
    n1:(content:"n1", status:"todo", subs:("n2","n3")),
    n2:(content:"n2", status:"todo", subs:("n4",)),
    n3:(content:"n3", status:"todo", subs:("n4",)),
    n4:(content:"n4", status:"todo", subs:()),
    n5:(content:"n5", status:"todo", subs:("n6",)),
    n6:(content:"n6", status:"done", subs:("n7",)),
    n7:(content:"n7", status:"todo", subs:("n8",)),
    n8:(content:"n8", status:"done", subs:()),
  )
  // repr(dfs(graph, "n0")); linebreak()
  // repr(dfs(graph, "n5")); linebreak()
  dfs-all(graph)
}
