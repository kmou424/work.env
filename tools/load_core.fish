#!/usr/bin/fish

set SCRIPT_DIR (dirname (realpath (status --current-filename)))

find $SCRIPT_DIR/../core/utils -type f -name "*.fish" | \
while read -la file; \
  source $file; \
end
