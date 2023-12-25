local dap = require("dap")
local dapui = require("dapui")

-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set("n", "<localleader>dl", require("dap.ui.widgets").hover)
vim.keymap.set("n", "<localleader>dc", function()
  -- require('jdtls.dap').setup_dap_main_class_configs()
  dap.continue()
end)
-- require('jdtls.dap').setup_dap_main_class_configs(),
vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint)
-- vim.keymap.set('n', '<Leader>b', ':lua require"dap".toggle_breakpoint(vim.fn.input("Condition: "))<CR>')
vim.keymap.set('n', '<Leader>B', function()
  dap.toggle_breakpoint(vim.fn.input("Condition: "))
end)
vim.keymap.set("n", "<localleader>dn", dap.step_over)
vim.keymap.set("n", "<localleader>di", dap.step_into)
vim.keymap.set("n", "<localleader>do", dap.step_out)
vim.keymap.set("n", "<localleader>dC", function()
  dap.clear_breakpoints()
  require("notify")("Breakpoints cleared", "warn")
end)

-- Close debugger and clear breakpoints
vim.keymap.set("n", "<localleader>de", function()
  -- dap.clear_breakpoints()
  dapui.toggle({})
  dap.terminate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
  require("notify")("Debugger session ended", "warn")
end)

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
