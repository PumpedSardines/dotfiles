local dap = require("dap")
local dapui = require("dapui")

print("Loading dap.lua")

dap.setup()

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb", -- adjust as needed
	name = "lldb",
}

local sign = vim.fn.sign_define
local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
for _, group in pairs(dap_round_groups) do
	sign(group, { text = "●", texthl = group })
end

-- local lldb = {
--   name = "Launch lldb",
--   type = "lldb",     -- matches the adapter
--   request = "launch", -- could also attach to a currently running process
--   program = function()
--     return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--   end,
--   cwd = "${workspaceFolder}",
--   stopOnEntry = false,
--   args = {},
--   runInTerminal = false,
-- }
--
-- require("dap").configurations.rust = {
--   lldb, -- different debuggers or more configurations can be used here
-- }

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
