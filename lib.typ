#let todos = state("__todos", (:))
#let todo-node(name, content) = {
  todos.update(old => {
    // TODO: check duplicate
    old.insert(name, (content:content, subs:(), walked:false, status:"todo"/*todo, done, abort*/))
    old
  })
}
#let todo-edge(from, to) = {
  todos.update(old => {
    if old.keys().contains(from) {
      old.at(from).subs.push(to)
    } else { /*TODO*/ }
    old
  })
}
#let list-todos() = {
  import "graph.typ": dfs-all
  context dfs-all(todos.final())
}
