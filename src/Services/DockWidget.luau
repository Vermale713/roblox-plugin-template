-- IMPORTED MODULES
const Framework = require "../Framework"

-- TYPES
type Toolbar = Framework.Toolbar
type Display = Framework.Display

-- PRIVATE STATE
const _cleaner = Framework.Janitor.new()
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

	_cleaner:Add(clickConn)
end

function DockWidget.OnStart()
	-- start stuff
end

function DockWidget.OnUnload()
	_cleaner:Destroy()
end

function DockWidget.OnDeactivate()
	_cleaner:Destroy()
end

return DockWidget
