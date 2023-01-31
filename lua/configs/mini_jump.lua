local status_ok, mini_jump = pcall(require, "mini.jump")
if not status_ok then
	return
end

local config = {
	delay = {
		highlight = 10 ^ 7,
	},
}

mini_jump.setup(config)
