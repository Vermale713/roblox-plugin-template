-- SERVICES

-- IMPORTED MODULES
const Types = require("@self/Types")
const Promise = require("./Packages/Promise")

-- TYPES
type Service = Types.Service
type PluginConfig = Types.PluginConfig

-- CONSTANTS

-- PRIVATE STATE

-- PRIVATE FUNCTIONS

-- PRIVATE MODULE
local _config: PluginConfig = {
	Name = "Plugin",
	Version = "0.0.0",
}

-- PUBLIC MODULE
const Framework = {}

function Framework.SetConfig(config)
	_config = config
end

function Framework.GetConfig()
	return _config
end

function Framework.Load(dir: Instance)
	return Promise.new(function(resolve)
		const children = dir:GetChildren()

		const services: { Service } = {}

		for _, child in children do
			if not child:IsA("ModuleScript") then
				continue
			end

			const mod: Service = (require)(child)
			table.insert(services, mod)
		end

		resolve(services)
	end)
end

function Framework.Start(services: { Service })
	return Promise.new(function(resolve)
		for _, service in services do
			if service.OnInit then
				service.OnInit()
			end
		end

		for _, service in services do
			task.spawn(function()
				if service.OnStart then
					service.OnStart()
				end
			end)
		end
	end)
end

return Framework
