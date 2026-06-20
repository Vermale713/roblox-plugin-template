-- SERVICES

-- IMPORTED MODULES
const Framework = require("../Framework")

-- TYPES
type Toolbar = Framework.Toolbar

-- ALIASES

-- CONSTANTS

-- PRIVATE STATE
const _connections: { RBXScriptConnection } = {}

-- PRIVATE FUNCTIONS
const function cleanupConnections()
	for _, conn in _connections do
		conn:Disconnect()
	end
end

-- PRIVATE MODULE

-- PUBLIC MODULE
const Hi = {}

function Hi.OnInit(toolbar: Toolbar)
	const pluginConfig = Framework.GetConfig()
	const pluginName = pluginConfig.Name

	const button =
		toolbar:CreateButton(`Hi_{pluginName}`, "Print 'hi' on click", "rbxassetid://12348119032", "Simple Print")
	button.ClickableWhenViewportHidden = true

	const clickConn = button.Click:Connect(function()
		print("hi")
	end)

	table.insert(_connections, clickConn)
end

function Hi.OnStart()
	-- start stuff
end

function Hi.OnUnload()
	cleanupConnections()
end

function Hi.OnDeactivate()
	cleanupConnections()
end

return Hi
