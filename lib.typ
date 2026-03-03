#{
  let todos = state("__todos", (:))
  let todo-node(content, label) = {
    todos.update(old => {
      // TODO: check duplicate
      old.insert(str(label), (content:content, subs:(), walked:false, status:"todo"/*todo, done, abort*/))
      old
    })
  }
  let todo-edge(from, to) = {
    todos.update(old => {
      if old.keys().contains(str(from)) {
        old.at(str(from)).subs.push(to)
      } else { /*TODO*/ }
      old
    })
  }


  let dag_walk2(name, indent) = context {
    let cur = todos.get().at(str(name))
    if (not cur.walked) or (cur.walked and indent != 0) {
      h(1em*indent); cur.content; linebreak()
    }
    if not cur.walked {
      todos.update(old => {old.at(str(name)).walked = true; old})
      for sub in cur.subs { dag_walk2(str(sub), indent+1) }
    }
  }

  todo-node([n0], <n0>)
  todo-node([n1], <n1>)
  todo-node([n2], <n2>)
  todo-node([n3], <n3>)
  todo-node([n4], <n4>)
  todo-edge(<n0>, <n1>)
  todo-edge(<n1>, <n2>)
  todo-edge(<n1>, <n3>)
  todo-edge(<n2>, <n4>)
  todo-edge(<n3>, <n4>)
  context {
    repr(todos.final()); linebreak()

    for node in todos.final().keys() {
      dag_walk2(node, 0)
    }
  }
}
