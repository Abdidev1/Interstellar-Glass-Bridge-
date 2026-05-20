local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

-- You need to adjust the parts below based on your Roblox group roles.
local GroupTags = {
	[255] = {Text = "[??Owner??]", Color = Color3.fromRGB(0, 170, 255)},
	[254] = {Text = "[??Co-Leader??]", Color = Color3.fromRGB(0, 255, 0)},
	[250]   = {Text = "[???Developer???]", Color = Color3.fromRGB(255, 255, 0)},
	[200]   = {Text = "[??Donator??]", Color = Color3.fromRGB(255, 229, 180)},
	[229]   = {Text = "[??Advertiser??]", Color = Color3.fromRGB(200, 100, 50)},
	[1]   = {Text = "[?Member?]", Color = Color3.fromRGB(255, 0, 0)},
}


local DefaultTag = nil -- This makes it so if the player is not in the group, they receive no chat tag.

TextChatService.OnIncomingMessage = function(message: TextChatMessage)
	if message.TextSource then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		if player then
			local rank = player:GetAttribute("GroupRank")
			local tag = GroupTags[rank]

			if not tag and DefaultTag then
				tag = DefaultTag
			end

			if tag then
				local r, g, b = tag.Color.R * 255, tag.Color.G * 255, tag.Color.B * 255
				local props = Instance.new("TextChatMessageProperties")
				props.PrefixText = string.format(
					"<font color='rgb(%d,%d,%d)'>%s</font> %s",
					r, g, b, tag.Text, message.PrefixText
				)
				return props
			end
		end
	end
	return nil
end
