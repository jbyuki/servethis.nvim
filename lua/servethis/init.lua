-- Generated using ntangle.nvim
local M = {}
function M.start_server(port)
  local filepath = vim.api.nvim_buf_get_name(0)

  port = port or 8093

  local server = vim.uv.new_tcp()
  server:bind("127.0.0.1", port)
  server:listen(128, function(err)
    assert(not err, err)
    local client = vim.uv.new_tcp()
    server:accept(client)

    local client_co = coroutine.create(function (chunk)
      while true do
        if chunk:find("\r\n\r\n") then
          local s,e = chunk:find("\r\n\r\n")
          local msg = chunk:sub(1,s-1)
          if #msg > 3 and msg:sub(1,3) == "GET" then
            local f = io.open(filepath)
            local content = ""
            if not f then
              content = "ERROR READING " .. filepath
            else
              content = f:read("*a")
              f:close()
            end

            local header = ""
            header = "HTTP/1.1 200 OK\r\n"

            header = header .. "Content-Length: " .. #content .. "\r\n"
            header = header .. "Content-Type: text/html" .. "\r\n"


            client:write(header .. "\r\n" .. content)
          end

          chunk = chunk:sub(e+1)

        else
          chunk = chunk .. coroutine.yield()
        end
      end
    end)

    client:read_start(function (err, chunk)
      assert(not err, err)
      if chunk then
        coroutine.resume(client_co, chunk)
      else
        client:shutdown()
        client:close()
      end
    end)

  end)

  print("Server running on port", port, "serving", filepath)
end
return M

