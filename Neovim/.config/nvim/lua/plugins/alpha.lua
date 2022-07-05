local dashboard = require("alpha.themes.dashboard")
math.randomseed(os.time())

-- Set header
  local function pick_color()
    -- Select color in highlight-groups (:hi)
    local colors = {"rainbowcol1", "rainbowcol3", "rainbowcol4", "rainbowcol5", "rainbowcol6", "rainbowcol7",}
    return colors[math.random(#colors)]
  end
  dashboard.section.header.val = require("utils.headers").random()
  dashboard.section.header.opts.hl = pick_color()

-- Set menu--
  --Just highlight shortcut--
    -- local btn = function(sc, txt, keybind, keybind_opts)
    --     local button = dashboard.button(sc, txt, keybind, keybind_opts)
    -- 	-- button.opts.hl = ""
    -- 	button.opts.hl_shortcut = "Number"
    --     return button
    -- end
    -- local leader = '<LD>'
    -- dashboard.section.buttons.val = {
    -- 	button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    -- 	button("f", "  Find file", ":Telescope find_files <CR>"),
    -- 	button("p", "  Find project", ":Telescope projects <CR>"),
    -- 	button("r", "  Recently opened files", ":Telescope oldfiles <CR>"),
    -- 	button("t", "  Find text", ":Telescope live_grep <CR>"),
    -- 	--button("c", "  Configuration" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    -- 	button("u", "  Update plugins", ":PackerSync<CR>"),
    -- 	button("q", "  Quit Neovim", ":qa<CR>"),
    -- }


  --Colorful icons--
  local leader = '<LD>'

  local function button(usr_opts, txt, leader_txt, keybind, keybind_opts)
    local sc_after = usr_opts.shortcut:gsub('%s', ''):gsub(leader_txt, '<leader>')
  
    local default_opts = {
      position = 'center',
      cursor = 5,
      width = 50,
      align_shortcut = 'right',
      hl_shortcut = 'Number'
    }
    local opts = vim.tbl_deep_extend('force', default_opts, usr_opts)
  
    if nil == keybind then
      keybind = sc_after
    end
    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc_after, keybind, keybind_opts }
  
    local function on_press()
      -- local key = vim.api.nvim_replace_termcodes(keybind .. '<Ignore>', true, false, true)
      local key = vim.api.nvim_replace_termcodes(sc_after .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, 't', false)
    end
  
    return {
      type = 'button',
      val = txt,
      on_press = on_press,
      opts = opts,
    }
  end
  dashboard.section.buttons.val = {
    button({shortcut = "r", hl = {{'rainbowcol7', 2, 3}}}, "  Recently opened files", leader, ":Telescope oldfiles <CR>"),
    button({shortcut = "e", hl = {{'rainbowcol3', 2, 3}}}, "  New file", leader, ":ene <BAR> startinsert <CR>"),
    button({shortcut = "f", hl = {{'rainbowcol4', 2, 3}}}, "  Find file", leader, ":cd $HOME/Workspace | Telescope find_files hidden=true path_display=smart<CR>"),
    button({shortcut = "t", hl = {{'Normal', 2, 3}}}, "  Find text", leader, ":Telescope live_g rep path_display=smart<CR>"),
    button({shortcut = "p", hl = {{'rainbowcol2', 2, 3}}}, "  Switch to project", leader, ":Telescope projects <CR>"),
    button({shortcut = "u", hl = {{'rainbowcol5', 2, 3}}}, "  Update plugins", leader, ":PackerSync<CR>"),
    button({shortcut = "q", hl = {{'rainbowcol1', 2, 3}}}, "  Quit Neovim", leader, ":qa<CR>"),
    --button({shortcut = leader .. " f c", hl = {{'rainbowcol1', 2, 3}}}, "  Configuration" , leader, ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
  }

-- Set footer
local function footer()
	local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
	-- local num_plugins_tot = #vim.tbl_keys(packer_plugins)
	 local datetime = os.date(" |  %H:%M   %d-%m-%Y")
	-- local version = vim.version()
	-- local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return num_plugins_loaded .. " plugins loaded ﮣ " .. datetime
end
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "String"

-- Set something
local something = {
  type = "text",
  val = "Coup de Burst at the ready !",
  opts = {
    position = "center",
    hl = "SpecialComment",
  },
}

  -- Layout
  dashboard.config.layout = {
    { type = "padding", val = 3 },
    dashboard.section.header,
    { type = "padding", val = 3 },
    dashboard.section.buttons,
    { type = "padding", val = 3 },
    dashboard.section.footer,
	{ type = "padding", val = 1 },
	something,
  }
  
dashboard.opts.opts.noautocmd = true
require("alpha").setup(dashboard.config)
