local cmp_instance = {}

function cmp_instance.init()
  require("coq_3p") {
    { src = "nvimlua", short_name = "nLUA" },
    { src = "vimtex", short_name = "vTEX" },
  }
  -- Automatically start coq
  vim.g.coq_settings = { auto_start = 'shut-up' }

  return cmp_instance
end

function cmp_instance.get_capabilites()
  return function(capabilities) return require("coq").lsp_ensure_capabilities(capabilities) end
end

return cmp_instance
