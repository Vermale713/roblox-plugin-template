-- IMPORTED MODULES
local Charm = require(script.Parent.Parent.Parent.packages.Charm)

-- PRIVATE STATE
local _getConfig, _setConfig = Charm.signal({
	Name = "Template",
})

local Config = {}

Config.getConfig, Config.setConfig = _getConfig, _setConfig

return Config
