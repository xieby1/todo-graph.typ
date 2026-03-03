#import "graph.typ": dfs-all
#{
  let todos = state("__todos", (:))
  let todo-node(name, content) = {
    todos.update(old => {
      // TODO: check duplicate
      old.insert(name, (content:content, subs:(), walked:false, status:"todo"/*todo, done, abort*/))
      old
    })
  }
  let todo-edge(from, to) = {
    todos.update(old => {
      if old.keys().contains(from) {
        old.at(from).subs.push(to)
      } else { /*TODO*/ }
      old
    })
  }


  todo-node("n0", [n0])
  todo-node("n1", [n1])
  todo-node("n2", [n2])
  todo-node("n3", [n3])
  todo-node("n4", [n4])
  todo-edge("n0", "n1")
  todo-edge("n1", "n2")
  todo-edge("n1", "n3")
  todo-edge("n2", "n4")
  todo-edge("n3", "n4")
  context dfs-all(todos.final())
}
