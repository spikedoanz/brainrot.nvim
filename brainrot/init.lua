-- ~/.config/nvim/lua/plugins/brainrot/init.lua

local M = {}

function M.open_side_terminal()
    -- Close existing side terminal if it's open
    if vim.g.side_terminal_buf and vim.api.nvim_buf_is_valid(vim.g.side_terminal_buf) then
        vim.api.nvim_buf_delete(vim.g.side_terminal_buf, {force = true})
    end

    -- Open a new window on the right
    vim.cmd("botright vnew")

    -- Resize the window to 30% of screen width
    local width = math.floor(vim.o.columns * 0.27)
    vim.api.nvim_win_set_width(0, width)

    -- Disable line numbers and other UI elements
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = 'no'
    vim.wo.cursorline = false
    vim.wo.cursorcolumn = false
    -- Open terminal in the new window
    vim.cmd("terminal")
    vim.g.side_terminal_buf = vim.api.nvim_get_current_buf()

    -- Run viu command to display the GIF
    vim.api.nvim_chan_send(vim.b.terminal_job_id, 
    "clear && viu ~/.config/nvim/lua/brainrot/assets/subway.gif\n")
end

function M.setup()
    -- Bind <leader>sss to open_side_terminal
    vim.keymap.set('n', '<leader>brainrot', M.open_side_terminal, {noremap = true, silent = true})
end

return M
