# load core utils
find $CORE_DIR/utils -type f -name "*.fish" | \
while read -la file; \
  source $file; \
end

# only load on shell initializing
_must_non_interactive

# load config
fishing $HOME/workenv_config.fish

# load modules
fishing $CORE_DIR/modules
