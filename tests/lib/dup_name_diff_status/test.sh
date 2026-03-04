#!/usr/bin/env bash
typst compile $(dirname $(realpath $0))/test.typ |& grep "Same node name .* but different status" &> /dev/null
