return {
  --
  -- LazyVim Specs
  --
  require("plugins.utils.which_key"),
  require("plugins.utils.persistence"), -- disabled
  require("plugins.utils.mini_surround"), -- optional
  require("plugins.utils.yanky"), -- optional

  --
  -- Personal Specs
  --
  require("plugins.utils.zen_mode"),
  require("plugins.utils.twilight"),
  require("plugins.utils.screenkey"),
  require("plugins.utils.track"), -- track files like 'harpoon'
  require("plugins.utils.table_mode"),
  require("plugins.utils.undotree"),
  require("plugins.utils.ccc"),
  -- require("plugins.utils.startuptime"),
  -- require("plugins.utils.dial"),
  require("plugins.utils.tmux_navigatior"),
  require("plugins.utils.markview"),
}
