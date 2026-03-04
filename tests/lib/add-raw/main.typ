#import "/lib.typ": add-raw-node, add-raw-edge, list-todos
#{
  add-raw-edge("n0", "n1")
  add-raw-edge("n1", "n2")
  add-raw-edge("n1", "n3")
  add-raw-edge("n2", "n4")
  add-raw-edge("n3", "n4")
  add-raw-node("TOdo", [n0], "n0")
  add-raw-node("DoNE", [n1], "n1")
  add-raw-node("DONE", [n2], "n2")
  add-raw-node("TODO", [n3], "n3")
  add-raw-node("ABORt", [n4], "n4")
  list-todos()
}
