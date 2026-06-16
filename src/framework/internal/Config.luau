-- IMPORTED MODULES
const Charm = require("../../packages/Charm")

-- PRIVATE STATE
const _getConfig, _setConfig = Charm.signal({
	Name = "Template",
})

const Config = {}

Config.getConfig, Config.setConfig = _getConfig, _setConfig

return Config
