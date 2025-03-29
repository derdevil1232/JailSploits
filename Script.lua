local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "ee4cf514bede436eb49815e06408d35e"
local falseData = "14bad2e36519475c8a67d7e8c51f2949"

KeyGuardLibrary.Set({
	publicToken = "2e6eb1ea22ec4ac1b36f5c4e9b632bcd",
	privateToken = "263dbc06ee4c40d19708558bb0e837c4",
	trueData = trueData,
	falseData = falseData,
})

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local key = ""

local Window = Fluent:CreateWindow({
		Title = "Key System",
		SubTitle = "JailSploits",
		TabWidth = 160,
		Size = UDim2.fromOffset(580, 340),
		Acrylic = false,
		Theme = "Dark",
		MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
		KeySys = Window:AddTab({ Title = "Key System", Icon = "key" }),
}

local Entkey = Tabs.KeySys:AddInput("Input", {
		Title = "Enter Key",
		Description = "Enter Key Here",
		Default = "",
		Placeholder = "Enter key…",
		Numeric = false,
		Finished = false,
		Callback = function(Value)
				key = Value
		end
})

local Checkkey = Tabs.KeySys:AddButton({
		Title = "Check Key",
		Description = "Enter Key before pressing this button",
		Callback = function()
				local response = KeyGuardLibrary.validateDefaultKey(key)
				if response == trueData then
						print("Key is valid")
						loadstring(game:HttpGet("https://raw.githubusercontent.com/derdevil1232/JailSploits/refs/heads/main/main.lua"))()
				else
						print("Key is invalid")
				end
		end
})

local Getkey = Tabs.KeySys:AddButton({
		Title = "Get Key",
		Description = "Get Key here",
		Callback = function()
				setclipboard(KeyGuardLibrary.getLink())
		end
})

Window:SelectTab(1)
