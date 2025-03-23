local status, orgmode = pcall(require, "orgmode")
if not status then
	return
end

local status2, orgmode_bullets = pcall(require, "org-bullets")
if not status2 then
	return
end

orgmode.setup()

orgmode_bullets.setup()
