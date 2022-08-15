local formatting_instance = {}

function formatting_instance.init(formatters)
	local builtin_sources = {}
	for _, x in ipairs(formatters) do
		local callable = "return require('null-ls').builtins." .. x
		--for w in x:gmatch('a%+') do table.insert(fields, w) end
		 table.insert(builtin_sources, load(callable)())
	end

	--table.foreach(formatters, function(i,x) formatters[i] = require('null-ls').builtins[x] end)
	require("null-ls").setup({
		sources = builtin_sources,
	})
end

return formatting_instance
