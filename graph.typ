// By Copilot
// Pure DFS implementation for graph traversal
// graph: dict where keys are node names, values are arrays of neighbor names
// start: starting node name
// Returns: (visited, numtodos, content)
#let dfs(graph, start, counter) = {
  // Helper function: DFS with visited tracking
  // Returns tuple: (updated visited set, numtodos, content)
  let dfs-helper(node, visited-info, counter) = {
    // Show visited leaf
    let status_upper = upper(graph.at(node).status)
    let content = block({
      status_upper + numbering(" 1.1: ", ..counter)
      graph.at(node).content
    })

    if visited-info.keys().contains(node) {
      return (visited-info, content)
    }

    let numtodos = if status_upper == "TODO" {1} else {0}

    // The sum of subs numtodos is updated after visiting all subs
    visited-info.insert(node, (numtodos:numtodos, counter:counter))

    // Visit all unvisited subs
    counter.push(1)
    for sub in graph.at(node).subs {
      let (sub-visited-info, sub-content) = dfs-helper(sub, visited-info, counter)
      visited-info = sub-visited-info
      numtodos += visited-info.at(sub).numtodos
      if visited-info.at(sub).numtodos > 0 {
        content += sub-content
        counter.at(-1) += 1
      }
    }
    // Update the numtodos
    visited-info.at(node).numtodos = numtodos

    if numtodos == 0 {content=none}

    return (visited-info, content)
  }

  // Start DFS from the start node
  dfs-helper(start, (:), counter)
}

// DFS that visits all connected components
// Returns array of all nodes in DFS order
#let dfs-all(graph) = {
  let visited-info = (:)
  let content = []
  let counter = (1,)

  for node in graph.keys() {
    if not visited-info.keys().contains(node) {
      let (new-visited-info, new-content) = dfs(graph, node, counter)
      visited-info += new-visited-info
      content += new-content
      counter.at(0) += 1
    }
  }

  return (content, visited-info)
}
