#!/usr/bin/env bash

export PATH="$PWD/bin:$PATH"
export PERL5LIB="$PWD/lib:$HOME/src/pegex-pm/lib"

cat "${1:?Usage: $0 <sql-file>}" | pg-schema-to-yaml
