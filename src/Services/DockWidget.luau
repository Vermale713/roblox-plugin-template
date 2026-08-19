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
const DockWidget = {}

function DockWidget.OnInit(toolbar: Toolbar, display: Display)
	const pluginConfig = Framework.GetConfig()
	const pluginName = pluginConfig.Name

	const widget =
		display:CreateDockWidget("DockDisplay", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Left, false, false))

	const button = toolbar:CreateButton(
		`DockWidget_{pluginName}`,
		"Open a dock widget gui",
		"rbxassetid://12348119032",
		"DockWidgetGui"
	)
	button.ClickableWhenViewportHidden = true
	button:SetActive(widget.Enabled) -- This is incase restore was used

	const t = Instance.new "TextLabel"
	t.Text = "Hi"
	t.TextScaled = true
	t.Size = UDim2.fromScale(1, 1)
	t.Parent = widget

	const clickConn = button.Click:Connect(function()
		_isOpen = not _isOpen

		widget.Enabled = _isOpen
		button:SetActive(_isOpen)
	end)

	Scythe.add(_scope, clickConn)
end

function DockWidget.OnStart()
	-- start stuff
end

function DockWidget.OnUnload()
	if Scythe.isAlive(_scope) then
		Scythe.destroy(_scope)
	end
end

function DockWidget.OnDeactivate()
	if Scythe.isAlive(_scope) then
		Scythe.destroy(_scope)
	end
end

return DockWidget
