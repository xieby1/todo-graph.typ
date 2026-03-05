#import "/graph.typ"
#graph.dfs-all((
  n0:(content:"n0", status:"TODO", pres:("n0"), subs:("n1",)),
  n1:(content:"n1", status:"TODO", pres:("n1"), subs:("n0",)),
)).first()
