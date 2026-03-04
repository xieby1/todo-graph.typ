typst compile $(dirname $(realpath $0))/test.typ |& grep 'edge from node .* does not exist' &> /dev/null
 
