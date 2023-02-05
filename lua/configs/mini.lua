-- MINI JUMP
local status_ok_jump, jump = pcall(require, "mini.jump")
if not status_ok_jump then
	return
end

local config = {
	delay = {
		highlight = 10 ^ 7,
	},
}

jump.setup(config)

-- MINI ANIMATE
local status_ok_animate, animate = pcall(require, 'mini.animate')
if not status_ok_animate then
    return
end

animate.setup()