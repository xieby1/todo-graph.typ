#import "/graph.typ": dfs-all
#let graph = (
  n0:(content:"n0", status:"TODO", subs:("n1",)),
  n1:(content:"n1", status:"Todo", subs:("n2","n3")),
  n2:(content:"n2", status:"sKip", subs:("n4",)),
  n3:(content:"n3", status:"toDo", subs:("n4",)),
  n4:(content:"n4", status:"tODo", subs:()),
  n5:(content:"n5", status:"todo", subs:("n6",)),
  n6:(content:"n6", status:"doNe", subs:("n7",)),
  n7:(content:"n7", status:"todO", subs:("n8",)),
  n8:(content:"n8", status:"donE", subs:("n9",)),
  n9:(content:"n9", status:"DONE", subs:()),
)
#dfs-all(graph)
There is no n8 and n9, because n8, n9 subgraph are all done
