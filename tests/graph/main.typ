#import "/graph.typ": dfs-all
#let graph = (
  n0:(content:"n0", status:"todo", subs:("n1",)),
  n1:(content:"n1", status:"todo", subs:("n2","n3")),
  n2:(content:"n2", status:"todo", subs:("n4",)),
  n3:(content:"n3", status:"todo", subs:("n4",)),
  n4:(content:"n4", status:"todo", subs:()),
  n5:(content:"n5", status:"todo", subs:("n6",)),
  n6:(content:"n6", status:"done", subs:("n7",)),
  n7:(content:"n7", status:"todo", subs:("n8",)),
  n8:(content:"n8", status:"done", subs:("n9",)),
  n9:(content:"n9", status:"done", subs:()),
)
#dfs-all(graph)
There is no n8 and n9, because n8, n9 subgraph are all done
