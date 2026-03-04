#import "/lib.typ": todo-node, todo-edge, list-todos
#{
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
  list-todos()
}
