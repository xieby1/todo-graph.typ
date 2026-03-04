typst compile $(dirname $(realpath $0))/test.typ |& grep 'edge to node .* does not exist' &> /dev/null
