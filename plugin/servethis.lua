vim.api.nvim_create_user_command("ServerThis", 
  function(opts) 
    local port = nil
    if opts.args then
      port = tonumber(opts.args)
    end
    require"servethis".start_server(port)
  end
  , { desc = "Use neovim to serve the current buffer over HTTP" })
