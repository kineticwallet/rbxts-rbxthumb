--!strict
--!optimize 2

--[[
$$\       $$\                      $$\     $$\                                   $$\ $$\            $$\
$$ |      \__|                     $$ |    \__|                                  $$ |$$ |           $$ |
$$ |  $$\ $$\ $$$$$$$\   $$$$$$\ $$$$$$\   $$\  $$$$$$$\ $$\  $$\  $$\  $$$$$$\  $$ |$$ | $$$$$$\ $$$$$$\
$$ | $$  |$$ |$$  __$$\ $$  __$$\\_$$  _|  $$ |$$  _____|$$ | $$ | $$ | \____$$\ $$ |$$ |$$  __$$\\_$$  _|
$$$$$$  / $$ |$$ |  $$ |$$$$$$$$ | $$ |    $$ |$$ /      $$ | $$ | $$ | $$$$$$$ |$$ |$$ |$$$$$$$$ | $$ |
$$  _$$<  $$ |$$ |  $$ |$$   ____| $$ |$$\ $$ |$$ |      $$ | $$ | $$ |$$  __$$ |$$ |$$ |$$   ____| $$ |$$\
$$ | \$$\ $$ |$$ |  $$ |\$$$$$$$\  \$$$$  |$$ |\$$$$$$$\ \$$$$$\$$$$  |\$$$$$$$ |$$ |$$ |\$$$$$$$\  \$$$$  |
\__|  \__|\__|\__|  \__| \_______|  \____/ \__| \_______| \_____\____/  \_______|\__|\__| \_______|  \____/
]]
--

-- Example: Rbxthumb("Avatar", 0, "352x352, false) --> url

-- >>PRIVATE_VARIABLES<< --
local format: typeof(string.format) = string.format
local match: typeof(string.match) = string.match
local split: typeof(string.split) = string.split

-- >>CORE<< --
return function(thumbnailType: string, thumbnailId: number, thumbnailSize: string, isCircular: boolean?): string
	-- Check for valid types of the required parameters.
	if type(thumbnailId) ~= "number" then
		return ""
	end
	if type(thumbnailType) ~= "string" or typeof(thumbnailSize) ~= "string" then
		return ""
	end
	-- Define the default rbxthumb url template.
	local rbxthumbUrl: string = "rbxthumb://type=%s&id=%d&w=%d&h=%d"
	-- Check if the thumbnail size is valid and can be seperated.
	if match(thumbnailSize, "%dx%d") == nil then
		return ""
	end
	-- Seperate the thumbnail size to get the width and height.
	local widthAsString: string, heightAsString: string = table.unpack(split(thumbnailSize, "x"))
	-- Transform to valid types and validate those.
	local width: number?, height: number? = tonumber(widthAsString), tonumber(heightAsString)
	if type(width) ~= "number" or typeof(height) ~= "number" then
		return ""
	end
	-- Format the given rbxthumb url with the given parameters.
	local rbxthumb: string = format(rbxthumbUrl, thumbnailType, thumbnailId, width, height)
	-- Check if any filters need to apply. Currently only circular is supported.
	if type(isCircular) == "boolean" and isCircular == true then
		rbxthumb ..= "&filters=circular"
	end
	-- Return the fully formatted rbxthumb.
	return rbxthumb :: string
end
