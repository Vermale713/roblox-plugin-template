-- SERVICES

-- IMPORTED MODULES
const Framework = require("../Framework")

-- TYPES
type Toolbar = Framework.Toolbar
type Display = Framework.Display

-- ALIASES

-- CONSTANTS

-- PRIVATE STATE
const _connections: { RBXScriptConnection } = {}
const _instances: { Instance } = {}
local _isOpen = false

-- PRIVATE FUNCTIONS
const function cleanupConnections()
	for _, conn in _connections do
		conn:Disconnect()
	end
end

const function cleanupInstances()
	for _, instance in _instances do
		instance:Destroy()
	end
end

-- PRIVATE MODULE

-- PUBLIC MODULE
const Overlay = {}

function Overlay.OnInit(toolbar: Toolbar, display: Display)
	const pluginConfig = Framework.GetConfig()
	const pluginName = pluginConfig.Name

	const root = display:CreateOverlay("OverlayDisplay")

	const button =
		toolbar:CreateButton(`Overlay_{pluginName}`, "Open a dock widget gui", "rbxassetid://12348119032", "OverlayGui")
	button.ClickableWhenViewportHidden = true

	const t = Instance.new("TextLabel")
	t.Text = "Hi"
	t.TextScaled = true
	t.Size = UDim2.fromScale(0.2, 0.2)
	t.Parent = root

	const clickConn = button.Click:Connect(function()
		_isOpen = not _isOpen

		root.Enabled = _isOpen
		button:SetActive(_isOpen)
	end)

	table.insert(_connections, clickConn)
	table.insert(_instances, root)
end

function Overlay.OnStart()
	-- start stuff
end

function Overlay.OnUnload()
	cleanupConnections()
	cleanupInstances()
end

function Overlay.OnDeactivate()
	cleanupConnections()
	cleanupInstances()
end

return Overlay
