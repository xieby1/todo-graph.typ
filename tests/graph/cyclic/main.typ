#import "/graph.typ"
#graph.dfs-all((
  n0:(content:"n0", status:"TODO", subs:("n1",)),
  n1:(content:"n1", status:"TODO", subs:("n0",)),
)).first()
