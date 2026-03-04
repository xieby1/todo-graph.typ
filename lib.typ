#let todo-nodes = state("__todo-nodes", (:))
#let todo-edges = state("__todo-edges", (:))
#let add-raw-node(status/*todo, done, abort*/, name, content) = {
  todo-nodes.update(old => {
    assert(not old.keys().contains(name), message:"Duplicate name: " + name)
    old.insert(name, (content:content, subs:(), walked:false, status:status))
    old
  })
}
#let add-raw-edge(from, to) = {
  todo-edges.update(old => {
    if not old.keys().contains(from) { old.insert(from, ()) }
    old.at(from).push(to)
    old
  })
}
#let list-todos() = {
  import "graph.typ": dfs-all
  context {
    let graph = todo-nodes.final()
    let edges = todo-edges.final()
    // Fill all edges to graph
    for from in edges.keys() {
      assert(graph.keys().contains(from), message:"edge from node [" + from + "] does not exist")
      for to in edges.at(from) {
        assert(graph.keys().contains(to), message:"edge to node [" + to + "] does not exist")
        if not to in graph.at(from).subs { graph.at(from).subs.push(to) }
      }
    }
    dfs-all(graph)
  }
}
