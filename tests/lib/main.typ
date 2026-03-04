#import "/lib.typ": TODO, DONE, ABORT, add-edges, list-todos
#{
  TODO("n0", [n0])
  TODO("n1", [n1], pres:("n0"), subs:"n4")
  TODO("n2", [n2], pres:("n0",), subs:("n4"))
  TODO("n3", [n3], pres:("n0",))
  TODO("n4", [n4], pres:("n1", "n2", "n3"))

  TODO("m0", [m0])
  TODO("m1", [m1])
  TODO("m2", [m2])
  TODO("m3", [m3])
  TODO("m4", [m4])
  add-edges("m0", ("m1", "m2", "m3"))
  add-edges(("m1", "m2", "m3"), ("m4",))

  TODO("o0", [o0])
  DONE("o1", [o1])
  ABORT("o2", [o2])
  TODO("o3", [o3])
  TODO("o4", [o4])
  add-edges("o0", ("o1", "o2", "o3"))
  add-edges(("o1", "o2", "o3"), ("o4",))

  TODO("p0", [p0])
  DONE("p1", [p1])
  ABORT("p2", [p2])
  TODO("p3", [p3])
  DONE("p4", [p4])
  add-edges("p0", ("p1", "p2", "p3"))
  add-edges(("p1", "p2", "p3"), ("p4",))

  list-todos()
}
