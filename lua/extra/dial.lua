-- use a protected call so we don't error out on first use
local status_ok, dial = pcall(require, "dial")
if not status_ok then
	return
end

dial.augends["custom#boolean"] = dial.common.enum_cyclic({
	name = "boolean",
	strlist = { "true", "false" },
})
table.insert(dial.config.searchlist.normal, "custom#boolean")

-- For Languages which prefer True/False, e.g. python.
dial.augends["custom#Boolean"] = dial.common.enum_cyclic({
	name = "Boolean",
	strlist = { "True", "False" },
})
table.insert(dial.config.searchlist.normal, "custom#Boolean")
