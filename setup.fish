#!/usr/bin/fish

if test -z (command -v fish)
  echo "You must install fish before setup work.env"
  exit -1
end

set FISH_CONF $HOME/.config/fish

if not test -d $FISH_CONF
  mkdir -p $FISH_CONF
end

if not test -d $FISH_CONF/conf.d
  mkdir -p $FISH_CONF/conf.d
end

set loader workenv_loader_template.fish
set core_dir core
set config workenv_config.fish

set loader_target $FISH_CONF/conf.d/workenv_loader.fish
set core_target_dir $FISH_CONF/workenv_$core_dir
set config_target $HOME/$config

if test -f $loader_target
  echo "Removing old work.env loader"
  rm $loader_target
end
echo "Installing work.env loader to $loader_target"
echo "#!/usr/bin/fish

set CORE_DIR $core_target_dir
set CONFIG $config_target

$(cat $loader)" > $loader_target

if test -d $core_target_dir
  echo "Removing old work.env core"
  rm -r $core_target_dir
end
echo "Installing work.env core to $core_target_dir"
cp -r $core_dir $core_target_dir

if not test -f $config_target
  echo "Copying work.env config to $config_target"
  cp $config $config_target
end