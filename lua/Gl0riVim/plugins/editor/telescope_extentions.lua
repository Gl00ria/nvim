local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (telescop_extensions.lua)", vim.log.levels.WARN)
  return
end

local telescope_opts = settings.editor_plugins.trelescope.extensions

local zoxide = {}
local telescope_file_browser = {}
local heading = {}
local make = {}
local soft_license = {}
local tabs = {}
local fzf_native = {}
local all_recent = {}
local undo = {}
local docker = {}
local http = {}

if telescope_opts.zoxide.enable then
  zoxide = {
    "jvgrootveld/telescope-zoxide",
    keys = telescope_opts.zoxide.keys,
  }
end

if telescope_opts.file_browser.enable then
  telescope_file_browser = {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = telescope_opts.file_browser.keys,
    config = function()
      local telescope_status, telescope = pcall(require, "telescope")
      if not telescope_status then
        vim.notify("Plugin [telescope] failed to load within (telescope_file_browser extension)", vim.log.levels.WARN)
        return
      end
      local fb_actions = require("telescope._extensions.file_browser.actions")
      if not fb_actions then
        vim.notify("[telescope._extensions.file_browser.actions] failed to load", vim.log.levels.WARN)
        return
      end
      telescope.setup({
        extensions = {
          file_browser = {
            theme = "ivy", -- Available: cursor | dropdown | ivy
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<A-c>"] = fb_actions.create,
                ["<S-CR>"] = fb_actions.create_from_prompt,
                ["<A-r>"] = fb_actions.rename,
                ["<A-m>"] = fb_actions.move,
                ["<A-y>"] = fb_actions.copy,
                ["<A-d>"] = fb_actions.remove,
                ["<C-o>"] = fb_actions.open,
                ["<C-g>"] = fb_actions.goto_parent_dir,
                ["<C-e>"] = fb_actions.goto_home_dir,
                ["<C-w>"] = fb_actions.goto_cwd,
                ["<C-t>"] = fb_actions.change_cwd,
                ["<C-f>"] = fb_actions.toggle_browser,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<C-s>"] = fb_actions.toggle_all,
                ["<bs>"] = fb_actions.backspace,
              },
              ["n"] = {
                ["c"] = fb_actions.create,
                ["r"] = fb_actions.rename,
                ["m"] = fb_actions.move,
                ["y"] = fb_actions.copy,
                ["d"] = fb_actions.remove,
                ["o"] = fb_actions.open,
                ["g"] = fb_actions.goto_parent_dir,
                ["e"] = fb_actions.goto_home_dir,
                ["w"] = fb_actions.goto_cwd,
                ["t"] = fb_actions.change_cwd,
                ["f"] = fb_actions.toggle_browser,
                ["h"] = fb_actions.toggle_hidden,
                ["s"] = fb_actions.toggle_all,
              },
            },
          },
        },
      })
    end,
  }
end

if telescope_opts.markdwon_heading.enable then
  heading = {
    "crispgm/telescope-heading.nvim",
    keys = telescope_opts.markdwon_heading.keys,
  }
end

if telescope_opts.make.enable then
  make = {
    "ptethng/telescope-makefile",
    keys = telescope_opts.make.keys,
  }
end

if telescope_opts.license.enable then
  soft_license = {
    "chip/telescope-software-licenses.nvim",
  }
end

if telescope_opts.tabs.enable then
  tabs = {
    "LukasPietzschmann/telescope-tabs",
    keys = telescope_opts.tabs.keys,
    opts = {
      close_tab_shortcut_i = "<C-d>",
      close_tab_shortcut_n = "d",
    },
  }
end
if telescope_opts.fzf_native.enable then
  fzf_native = {

    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    keys = telescope_opts.fzf_native.keys,
  }
end

if telescope_opts.freq_search.enable then
  all_recent = { "prochri/telescope-all-recent.nvim" }
end

if telescope_opts.undo.enable then
  undo = {
    "debugloop/telescope-undo.nvim",
    keys = telescope_opts.undo.keys,
  }
end
if telescope_opts.docker.enable then
  docker = {
    "lpoto/telescope-docker.nvim",
    keys = telescope_opts.docker.keys,
    config = function()
      local telescope_status, telescope = pcall(require, "telescope")
      if not telescope_status then
        vim.notify("Plugin [telescope] failed to load within (telescope_docker extension)", vim.log.levels.WARN)
        return
      end
      telescope.setup({
        extensions = {
          docker = {
            -- These are the default values
            theme = "ivy", -- Available: cursor | dropdown | ivy
            binary = "docker", -- in case you want to use podman or something
            compose_binary = "docker compose",
            buildx_binary = "docker buildx",
            machine_binary = "docker-machine",
            log_level = vim.log.levels.INFO,
            init_term = "tabnew", -- "vsplit new", "split new", ...
          },
        },
      })
    end,
  }
end

if telescope_opts.http.enable then
  http = {
    "barrett-ruth/telescope-http.nvim",
    config = function()
      local telescope_status, telescope = pcall(require, "telescope")
      if not telescope_status then
        vim.notify("Plugin [telescope] failed to load within (telescope_http extension)", vim.log.levels.WARN)
        return
      end
      telescope.setup({
        extensions = {
          http = {
            -- How the mozilla url is opened. By default will be configured based on OS:
            open_url = "xdg-open %s", -- UNIX
            -- open_url = 'open %s' -- OSX
            -- open_url = 'start %s' -- Windows
          },
        },
      })
      require("telescope").load_extension("http")
    end,
  }
end
return {
  zoxide,
  telescope_file_browser,
  heading,
  make,
  soft_license,
  tabs,
  fzf_native,
  all_recent,
  undo,
  docker,
  http,
}
