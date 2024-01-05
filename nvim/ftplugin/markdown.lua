local function get_webpage_title(url)
  local curl = require("plenary.curl")
  local res = curl.get(url, {
    on_error = function(err)
      vim.notify(err.message)
    end
  })

  if res.status ~= 200 then
    return nil
  end

  local _, begin_tag_end = string.find(res.body, "<title>")
  local end_tag_begin, _ = string.find(res.body, "</title>")

  local title = url

  if begin_tag_end ~= nil and end_tag_begin ~= nil then
    title = string.sub(res.body, begin_tag_end + 1, end_tag_begin - 1)
  end

  return title
end

local function is_url(may_url)
  if string.match(may_url, "https?://[%w/:%%#%$&%?%(%)~%.=%+%-]+") == nil then
    return false
  end
  return true
end

local function create_markdown_link(url, title)
  return string.format("[%s](%s)", title, url)
end

local async = require("plenary.async")

vim.paste = (function(lines, _)
  local insert_funcs = {}

  for i, line in ipairs(lines) do
    if is_url(line) then
      local cursor = vim.api.nvim_win_get_cursor(0)
      local row = cursor[1]
      local col = cursor[2]

      local buffer = vim.api.nvim_get_current_buf()
      local preserved_mark = vim.api.nvim_get_mark('A', {})

      vim.api.nvim_buf_set_mark(buffer, 'A', row, col, {})

      local insert_func = async.void(function(url, preserved_mark)
        async.util.sleep(1000)
        local status, retval = pcall(get_webpage_title, line)

        if status and retval then
          local target_mark = vim.api.nvim_get_mark('A', {})

          local buffer = target_mark[3]
          local row = target_mark[1]
          local col = target_mark[2]

          local link = create_markdown_link(url, retval)

          vim.api.nvim_buf_set_text(buffer, row - 1, col, row - 1, col + #url + 4 + 17, { link })
        end

        -- restore preserved mark
        vim.api.nvim_buf_set_mark(preserved_mark[3], 'A', preserved_mark[1], preserved_mark[2], {})
      end)

      table.insert(insert_funcs, { func = insert_func, url = line, preserved_mark = preserved_mark })

      lines[i] = create_markdown_link(line, "Fetching Title...")
    end
  end

  vim.api.nvim_put(lines, 'c', true, true)

  for i = 1, #insert_funcs do
    local func = insert_funcs[i].func
    local url = insert_funcs[i].url
    local preserved_mark = insert_funcs[i].preserved_mark

    func(url, preserved_mark)
  end
end)
