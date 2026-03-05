#let todo-nodes = state("__todo-nodes", (:))
#let todo-edges = state("__todo-edges", (:))
#let todo-visit = state("__todo-visit", (:))
#let add-raw-node(status/*todo, done, skip*/, content, name) = {
  todo-nodes.update(old => {
    if old.keys().contains(name) {
      assert(old.at(name).status==status,  message:"Same node name ["+name+"] but different status")
      assert(old.at(name).content==content,message:"Same node name ["+name+"] but different content")
    } else {
      old.insert(name, (content:content, pres:(), subs:(), walked:false, status:status))
    }
    old
  })
  box({
    upper(status)
    context {
      let visited-info = todo-visit.final()
      numbering(" 1.1: ", ..visited-info.at(name).counter)
    }
    content
  })
}
#let add-raw-edge(from, to) = {
  todo-edges.update(old => {
    if not old.keys().contains(from) { old.insert(from, ()) }
    old.at(from).push(to)
    old
  })
}

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

#let add-node(status, content, name, pres:(), subs:()) = {
  add-raw-node(status, content, name)
  add-edges(pres, name)
  add-edges(name, subs)
}
#let TODO(..args)  = add-node("TODO",  ..args)
#let DONE(..args)  = add-node("DONE",  ..args)
#let SKIP(..args) = add-node("SKIP", ..args)

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
        if not from in graph.at(to).pres { graph.at(to).pres.push(from) }
      }
    }
    let (content, visited-info) = dfs-all(graph)
    todo-visit.update(_ => visited-info)
    content
  }
}
