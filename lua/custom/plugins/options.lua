vim.wo.relativenumber = true
vim.o.clipboard = ''

-- Configure how new splits should be opened
vim.opt.splitright = false
vim.opt.splitbelow = false

-- vim.opt.expandtab = true
-- vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- vim.opt.foldlevelstart = 3

-- vim.opt.wrap = false

local function read_gitignore(file_path)
  local file = io.open(file_path, 'r')
  if not file then
    return ''
  end

  local patterns = {}
  for line in file:lines() do
    local cleaned_line = line:gsub('^%s+', ''):gsub('%s+$', '') -- Trim spaces

    if not cleaned_line:match '^[!#]' and cleaned_line ~= '' and cleaned_line ~= 'nvim' and not line:match ',' then
      if cleaned_line:sub(1, 1) == '/' then
        -- cleaned_line = "." .. cleaned_line
        cleaned_line = cleaned_line:sub(2)
      end
      -- if cleaned_line:sub(-1) ~= "/" and (vim.fn.isdirectory(cleaned_line) == 1 or vim.fn.isdirectory(cleaned_line:sub(2))) then
      if cleaned_line:sub(-1) ~= '/' and vim.fn.isdirectory(cleaned_line) == 1 then
        cleaned_line = cleaned_line .. '/' -- Add ** to directories
      end
      if cleaned_line:sub(-1) == '/' then
        cleaned_line = cleaned_line .. '*' -- Replace trailing / with /*
      end
      table.insert(patterns, cleaned_line)
    end
  end

  file:close()
  return table.concat(patterns, ',')
end

local function set_wildignore_from_gitignore()
  local ignore = {
    os.getenv 'HOME' .. '/.config/git/ignore',
    '.gitignore',
    '.git/info/exclude',
  }
  local wildignore = '**.vim'
  for _, file in ipairs(ignore) do
    local patterns = read_gitignore(file)
    if #patterns > 0 then
      wildignore = wildignore .. ',' .. patterns
    end
  end
  -- wildignore = wildignore:gsub("^,", "")

  vim.api.nvim_set_option_value('wildignore', wildignore, { scope = 'global' })
  -- print("wildignore set to: " .. wildignore)
end

set_wildignore_from_gitignore()

return {}
