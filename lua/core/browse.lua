-- use a protected call so we don't error out on first use
local status_ok, browse = pcall(require, "browse")
if not status_ok then
  return
end

local bookmarks = {
  "https://github.com/rockerBOO/awesome-neovim",
  "https://aur.archlinux.org/packages/",
}

local function command(name, rhs, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, rhs, opts)
end

command("Browselist", function()
  browse.browse { bookmarks = bookmarks }
end, {})

command("GoogleSearch", function()
  browse.input_search()
end, {})


command("BrowserBookmarks", function()
  browse.open_bookmarks { bookmarks = bookmarks }
end, {})

command("BrowseDevdocsSearch", function()
  browse.devdocs.search()
end, {})

command("BrowseDevdocsFiletypeSearch", function()
  browse.devdocs.search_with_filetype()
end, {})

command("BrowseMdnSearch", function()
  browse.mdn.search()
end, {})
