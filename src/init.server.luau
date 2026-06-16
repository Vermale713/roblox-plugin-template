const framework = require(script.framework)

framework.init({
	Name = "La Godly Plugin",
})

const toolbar = framework.Toolbar.new()

toolbar:createButton("Test", "testing it foo", "", "mcdonalds")

toolbar:createButton("hi", "hi", "", "ma")

const display = framework.Display.new()

display:createDockWidget(DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 500, 500, 300, 700))
display:createOverlay()

plugin.Unloading:Connect(function()
	print("Unloading plugin")
end)
