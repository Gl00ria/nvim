return {
  "monaqa/dial.nvim",
  cmd = {
    "DialIncrement",
    "DialDecrement",
  },
  keys = {
    { "<leader>K", "<cmd>DialIncrement<cr>", desc = "Dial Increment  " },
    { "<leader>J", "<cmd>DialDecrement<cr>", desc = "Dial Decrement  " },
  },
  config = function()
    -- minimum requirements for this plugin
    if vim.version().minor < 6 then
      vim.notify("Plugin [dial] requires 0.6.1 or higher", vim.log.levels.WARN)
      return
    end

    -- use a protected call so we don't error out on first use
    local status_ok, dial_config = pcall(require, "dial.config")
    if not status_ok then
      vim.notify("Plugin [dial] failed to load", vim.log.levels.WARN)
      return
    end

    local augend = require("dial.augend")

    dial_config.augends:register_group {
      default = {
        augend.date.new {
          pattern = "%d/%m/%Y",
          default_kind = "day",
          -- if true, it does not match dates which does not exist, such as 2022/05/32
          only_valid = false,
          -- if true, it only matches dates with word boundary
          word = false,
        },
        -- augend.constant.alias.Alpha, -- Alphabet "uppercase"
        -- augend.constant.alias.alpha, -- Alphabet "lowercase"
        augend.integer.alias.decimal, -- decimal natural numbers
        augend.integer.alias.decimal_int, -- decimal including negative numbers
        augend.integer.alias.hex, -- hex numbers
        augend.integer.alias.octal, -- octal numbers
        augend.integer.alias.binary, -- binary numbers
        augend.constant.alias.de_weekday, -- German weekdays
        augend.constant.alias.de_weekday_full, -- German weekdays "Full"
        augend.constant.alias.ja_weekday, -- Japanese weekdays
        augend.constant.alias.ja_weekday, -- Japanese weekdays "Full"
        augend.semver.alias.semver, -- -- Semantic version
        augend.constant.new {
          elements = {
            "FIX",
            "FIXME",
            "FIXIT",
            "BUG",
            "WARNING",
            "ISSUE",
            "INFO",
            "TODO",
            "HACK",
            "WARN",
            "PERFORMANCE",
            "PERF",
            "OPTIMIZE",
            "HINT",
            "NOTE",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "Sunday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "MONDAY",
            "TUESDAY",
            "WEDNESDAY",
            "THURSDAY",
            "FRIDAY",
            "SATURDAY",
            "SUNDAY",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "ONE",
            "TWO",
            "THREE",
            "FOUR",
            "FIVE",
            "SIX",
            "SEVEN",
            "EIGHT",
            "NINE",
            "TEN",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "One",
            "Two",
            "Three",
            "Four",
            "Five",
            "Six",
            "Seven",
            "Eight",
            "Nine",
            "Ten",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
            "ten",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "Enable", "Disable" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "enable", "disable" },
          word = true,
          cyclic = true,
        },
        augend.constant.alias.bool, -- true, false. "lowercase"
        augend.constant.new {
          elements = { "TRUE", "FALSE" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "True", "False" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "should", "should_not" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "0", "1" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "foo", "bar" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "YES", "NO" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "yes", "no" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "And", "Or" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "and", "or" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "AND", "OR" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "==", "!=" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "<", ">" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "<=", ">=" },
          word = false,
          cyclic = true,
        },
        -- augend.constant.new({
        -- 	elements = { "+", "-", "_" },
        -- 	word = false,
        -- 	cyclic = true,
        -- }),
        augend.constant.new {
          elements = { '"', "'" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "\\", "/" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "[", "{", "(" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "]", "}", ")" },
          word = false,
          cyclic = true,
        },
        -- lowercase hexcolor (#ffffff, #ff0000 )
        augend.hexcolor.new {
          case = "lower",
        },
      },
    }
  end,
}
