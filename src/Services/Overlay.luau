-- IMPORTED MODULES
const Framework = require "../Framework"
const Scythe = Framework.Scythe

-- TYPES
type Toolbar = Framework.Toolbar
type Display = Framework.Display

-- PRIVATE STATE
const _scope = Scythe.scope()
local _isOpen = false

-- PUBLIC MODULE
const Overlay = {}

function Overlay.OnInit(toolbar: Toolbar, display: Display)
	const pluginConfig = Framework.GetConfig()
	const pluginName = pluginConfig.Name

	const root = display:CreateOverlay "OverlayDisplay"

	const button =
		toolbar:CreateButton(`Overlay_{pluginName}`, "Open a dock widget gui", "rbxassetid://12348119032", "OverlayGui")
	button.ClickableWhenViewportHidden = true

	const t = Instance.new "TextLabel"
	t.Text = "Hi"
	t.TextScaled = true
	t.Size = UDim2.fromScale(0.2, 0.2)
	t.Parent = root

	const clickConn = button.Click:Connect(function()
		_isOpen = not _isOpen

		root.Enabled = _isOpen
		button:SetActive(_isOpen)
	end)

	Scythe.add(_scope, clickConn)
end

function Overlay.OnStart()
	-- start stuff
end

function Overlay.OnUnload()
	if Scythe.isAlive(_scope) then
		Scythe.destroy(_scope)
	end
end

function Overlay.OnDeactivate()
	if Scythe.isAlive(_scope) then
		Scythe.destroy(_scope)
	end
end

return Overlay
