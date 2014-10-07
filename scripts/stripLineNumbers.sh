#!/bin/bash

# strips NXXX line numbers from the start of each line
extension="${1##*.}"
filename="${1%.*}"
cat $1 | sed -E 's/^[Nn][0-9]*//g' > "${filename}"_mod."${extension}"

