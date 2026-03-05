#import "/graph.typ": dfs-all
#let graph = (
  /*
    n0
    |
  --n1-
  |   |
  n2  n3
  |   |
  --n4-

    n5
    |
    n6
    |
    n7
    |
    n8
    |
    n9
  */
  n0:(content:"n0", status:"TODO", pres:(), subs:("n1",)),
  n1:(content:"n1", status:"Todo", pres:("n0"), subs:("n2","n3")),
  n2:(content:"n2", status:"sKip", pres:("n1"), subs:("n4",)),
  n3:(content:"n3", status:"toDo", pres:("n1"), subs:("n4",)),
  n4:(content:"n4", status:"tODo", pres:("n2","n3"), subs:()),
  n5:(content:"n5", status:"todo", pres:(), subs:("n6",)),
  n6:(content:"n6", status:"doNe", pres:("n5"), subs:("n7",)),
  n7:(content:"n7", status:"todO", pres:("n6"), subs:("n8",)),
  n8:(content:"n8", status:"donE", pres:("n7"), subs:("n9",)),
  n9:(content:"n9", status:"DONE", pres:("n8"), subs:()),
)
#dfs-all(graph)
There is no n8 and n9, because n8, n9 subgraph are all done
