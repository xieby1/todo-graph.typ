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

#let add-node(status, name, content, pres:(), subs:()) = {
  add-raw-node(status, name, content)
  for pre in pres { add-raw-edge(pre, name) }
  for sub in subs { add-raw-edge(name, sub) }
}
#let add-todo(..args)  = add-node("TODO",  ..args)
#let add-done(..args)  = add-node("DONE",  ..args)
#let add-abort(..args) = add-node("ABORT", ..args)

#let add-edges(from, to) = {
  let froms = {
    if type(from) == array {from}
    else if type(from) == str {(from,)}
    else {assert(false, "from can only be str or array")}
  }
  let tos = {
    if type(to) == array {to}
    else if type(to) == str {(to,)}
    else {assert(false, "to can only be str or array")}
  }
  for f in froms { for t in tos {
    add-raw-edge(f, t)
  }}
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
