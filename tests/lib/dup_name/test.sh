#!/usr/bin/env bash
typst compile $(dirname $(realpath $0))/test.typ |& grep "Duplicate name" &> /dev/null
