local input = getInput():lower()
local applicationsDir = "/Applications"

-- Hole alle .app-Dateien im /Applications-Verzeichnis
local handle = io.popen('find "' .. applicationsDir .. '" -maxdepth 1 -name "*.app"')
if not handle then return end

for line in handle:lines() do
  local appPath = line
  local appName = appPath:match(".*/(.*)%.app$")

  if appName and appName:lower():find(input, 1, true) then
    local clicked = addItem(appName, appPath)

    if clicked then
      -- App starten über `open`
      os.execute('open "' .. appPath .. '"')
    end
  end
end

handle:close()
