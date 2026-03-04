#import "/lib.typ": add-todo, add-done, add-abort, add-edges, list-todos
#{
  add-todo("n0", [n0])
  add-todo("n1", [n1], pres:("n0",), subs:("n4",))
  add-todo("n2", [n2], pres:("n0",), subs:("n4",))
  add-todo("n3", [n3], pres:("n0",))
  add-todo("n4", [n4], pres:("n1", "n2", "n3"))

  add-todo("m0", [m0])
  add-todo("m1", [m1])
  add-todo("m2", [m2])
  add-todo("m3", [m3])
  add-todo("m4", [m4])
  add-edges("m0", ("m1", "m2", "m3"))
  add-edges(("m1", "m2", "m3"), ("m4",))

  add-todo("o0", [o0])
  add-done("o1", [o1])
  add-abort("o2", [o2])
  add-todo("o3", [o3])
  add-todo("o4", [o4])
  add-edges("o0", ("o1", "o2", "o3"))
  add-edges(("o1", "o2", "o3"), ("o4",))

  add-todo("p0", [p0])
  add-done("p1", [p1])
  add-abort("p2", [p2])
  add-todo("p3", [p3])
  add-done("p4", [p4])
  add-edges("p0", ("p1", "p2", "p3"))
  add-edges(("p1", "p2", "p3"), ("p4",))

  list-todos()
}
