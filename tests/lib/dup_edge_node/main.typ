#import "/lib.typ": add-raw-node, add-raw-edge, list-todos
#{
  add-raw-node("TODO", "n0", [n0])
  add-raw-node("TODO", "n1", [n1])
  add-raw-node("TODO", "n2", [n2])
  add-raw-edge("n0", "n1")
  add-raw-edge("n0", "n1")
  add-raw-edge("n0", "n2")
  list-todos()
}
