
local _, GuildAssist = ...;
local gratulationSend = false
local discordSend = false

GuildAssist = LibStub("AceAddon-3.0"):NewAddon("GuildAssist3", "AceConsole-3.0", "AceEvent-3.0" );


if GuildAssist then
	SLASH_RELOAD1 = "/rl";
	SlashCmdList.RELOAD = ReloadUI;

	-- faster show framestack command
	SLASH_FRAMESTK1 = "/fs";
	SlashCmdList.FRAMESTK = function ()
		LoadAddOn('Blizzard_DebugTools')
		FrameStackTooltip_Toggle()
	end
end


local AConfig = LibStub("AceConfig-3.0")
local AConfigDialog = LibStub("AceConfigDialog-3.0")
local AceGUI = LibStub("AceGUI-3.0")

-- create minimap button 
local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)
if LDB then
	local GA_MinimapBtn = LDB:NewDataObject("GuildAssistLDB", {
		type = "launcher",
		text = "GuildAssist",
		icon = "Interface\\Icons\\inv_misc_enggizmos_27",
		OnClick = function(_, button)
			if button == "RightButton" then
				if (GuildAssist.ui.help:IsShown() == false) then
					GuildAssist.ui.help = GA_CreateHelpFrame()
				else
					GuildAssist.ui.help:Hide()
				end
			end
			if button == "LeftButton" then
				if (InterfaceOptionsFrame:IsShown() == false) then
					InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
					InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
				else
					InterfaceOptionsFrame:Hide()
				end
			end
		end,
		OnTooltipShow = function(tt)
			tt:AddLine("GuildAssist3")
			tt:AddLine("|cffffff00LeftClick|r to open the GuildAssist Settings.")
			tt:AddLine("|cffffff00RightClick|r to open the GuildAssist Help.")
		end,
	})
	if LDBIcon then
		LDBIcon:Register("GuildAssist3", GA_MinimapBtn) -- PC_MinimapPos is a SavedVariable which is set to 90 as default
	end
end

local defaults = {
	profile = {
		firstStart= true,
		playerName = UnitName("player"),
		message = "Welcome to GuildAssist3",
		showOnScreen = false,
		showInChat = false,
		showMenuOnStart = false,
		showOptionsOnStart = false,
		showHelpOnStart = false,
		discordmsg = "",
		gratulationMessage = "",
		sendAutoGratulation = false,
		sendAutoDiscord = false,
		waitTimeDiscord = 2,
		waitTimeGratulation = 3,
		sendAsciiTruck = false,
		sendAsciiHeart = false,
	},
}

local options = {
	name ="GuildAssist3 Options",
	handler = GuildAssist,
	type = "group",
	args = {
		generalSetting = {
		name ="General Settings",
		order = 0,
		handler = GuildAssist,
		desc = "Here you can setup the Discord Automatic settings.",
		type = "group",
		width = "full",
		args = {
			generalHeader = {
				type = "header",
				name = "General Options",
				desc = "Common GuildAssist options.",
				order = 0
			},
			generalDesc = {
				type = "description",
				order = 1,
				name = "General options for GuildAssist Addon.",
				fontSize = "medium"
			},
			showMenuOnStart = {
				type ="toggle",
				name ="Show menu on Start",
				desc = "Toggle to show addon menu at start.",
				get = "IsShowMenuOnStart",
				set = "ToggleShowMenuOnStart",
				order = 2,
				width = "full"
			},
			showOptionsOnStart = {
				type ="toggle",
				name ="Show options menu on Start",
				desc = "Toggle to show addon options at start.",
				get = "IsShowOptionOnStart",
				set = "ToggleShowOptionMenuOnStart",
				order = 3,
				width = "full"
			},
			showHelpOnStart = {
				type ="toggle",
				name ="Show help window on Start",
				desc = "Toggle to show addon help at start.",
				get = "IsShowHelpOnStart",
				set = "ToggleShowHelpOnStart",
				order = 4,
				width = "full"
			},
			generalHeaderHelp = {
				type = "header",
				name = "Need Help?",
				desc = "Do you need help?",
				order = 5
			},
			generalHelpDesc = {
				type = "description",
				order =6,
				name = "If you want a list with chatcommands and features or faceing bugs or some other trouble just click here!",
				width = "full",
				fontSize = "medium"
				
			},
			generalHelpButton = {
				type = "execute",
				order = 7,
				name = "Show Help",
				func = "OpenHelpFrame"
			}
		}},
		gratulationSetting = {
		name ="Gratulation Settings",
		order = 1,
		handler = GuildAssist,
		desc = "Here you can setup the Gratulation Automatic settings.",
		type = "group",
		width = "full",
		args = {
			gratulationHeader = {
				type = "header",
				order = 0,
				name = "Gratulation Settings",
			},
			generalDesc = {
				type = "description",
				order = 1,
				name = "Automatic Gratulation options for GuildAssist Addon.",
				fontSize = "medium"
			},
			showInChat = {
				order = 4,
				type = "toggle",
				name = "Show message in Chat",
				desc = "Toggles the display of the message in the chat window.",
				get = "IsShowInChat",
				set = "ToggleShowInChat",
				width = "full"
			},
			showOnScreen = {
				order = 3,
				type = "toggle",
				name = "Show message on Screen",
				desc = "Toggles the display of the message on screen.",
				get = "IsShowOnScreen",
				set = "ToggleShowOnScreen",
				width = "full"
			},
			gratulationMessage ={
				order = 2,
				type = "input",
				name = "Enter Automatic Gratulationmessage",
				desc = "The message to send if a guildmate get a achievement.",
				get = "GetGratulationMessage",
				set = "SetGratulationMessage",
				width = "full"
			},
			sendAutoGratulation = {
				order = 5,
				type = "toggle",
				name = "Send automatic Gratulation",
				desc = "Enable/Disable sending automatic gratulationmessage to guild.",
				get = "IsSendAutoGratulation",
				set = "ToggleAutoGratulation",
				width = "full"
			},
			asciiHeader = {
				order = 7,
				type = "header",
				name = "Use ASCii Gratulation Images",
			},
			asciiDesc = {
				order = 8,
				type = "description",
				name = "You can also choose a predefined ASCii Images as Gratulation Message.",
				width = "full",
				fontSize = "medium"
			},
			sendGratulationTruck = {
				order = 9,
				type = "toggle",
				name = "Send ASCii Truck Gratulation",
				desc = "Enable/Disable sending sending ASCii Truck as  gratulationmessage to guild.",
				get = "IsSendAsciiTruck",
				set = "ToggleSendAsciiTruck",
				width = "full",
			},
			sendGratulationHeart = {
				order = 10,
				type = "toggle",
				name = "Send ASCii Heart Gratulation",
				desc = "Enable/Disable sending ASCii Heart as gratulationmessage to guild.",
				get = "IsSendAsciiHeart",
				set = "ToggleSendAsciiHeart",
				width = "full",
			},
			waitTimeGratulation = {
				type = "range",
				name = "Time to wait before send gratulation after achievement earned.",
				min = 1,
				max = 10,
				step = 0.5,
				get = "GetWaitTimeAutoGratulation",
				set = "SetWaitTimeAutoGratulation",
				width = "full",
				order = 11
			},
			testGratulationHeader = {
				type = "header",
				order = 12,
				name = "Test Gratulation Message"
			},
			testGratulationDesc = {
				type = "description",
				order = 13,
				name = "Send the final Gratulation to your chat window.",
				fontSize = "medium"
			},
			sendTestGratulation = {
				order = 14,
				type = "execute",
				name = "Send Test Gratulation",
				func = "SendTestGratulation",
			},
		}},
		discordSetting = {
			order = 2,
			name ="Discord Settings",
			handler = GuildAssist,
			desc = "Here you can setup the Discord Automatic settings.",
			type = "group",
			width = "full",
			args = {
				discordHeader = {
					type ="header",
					order = 0,
					name = "Discord options",
					desc = "Here you can setup the Discord Automatic settings.",
					width = "full",

				},
				discordDesc = {
					type = "description",
					order = 1,
					name = "Here you can setup the Discord Automatic settings.",
					fontSize = "medium",
					width = "full"
				},
				discordMessage = {
					type = "input",
					order = 2,
					name = "Discord Invitelink",
					desc = "The message to be displayed when you get home.",
					usage = "<Your message>",
					get = "GetDiscordMessage",
					set = "SetDiscordMessage",
					width = "full"
				},
				sendAutoDiscord = {
					type = "toggle",
					order = 3,
					name = "Send automatic discordlink",
					desc = "Enable/Disable send automatic discordlink.",
					set = "ToggleSendAutoDiscord",
					get = "IsAutoDiscord",
					width = "full"
				},
				waitTimeDiscord = {
					type = "range",
					order = 4,
					name = "Time to wait before send discordlink.",
					min = 1,
					max = 10,
					step = 0.5,
					get = "GetWaitTimeAutoDiscord",
					set = "SetWaitTimeAutoDiscord",
					width = "full"
				},
				testDiscordHeader = {
					type = "header",
					order = 5,
					name = "Test Discord Message"
				},
				testDiscordDesc = {
					type = "description",
					order = 6,
					name = "Send the final Discordlink to your chat window.",
					fontSize = "medium"
				},
				sendTestGratulation = {
					order = 7,
					type = "execute",
					name = "Send Test Discord",
					func = "SendTestDiscord",
				},
			}},
			trackerSetting = {
			order = 3,
			name ="Dungeontracker Settings",
			handler = GuildAssist,
			desc = "Here you can setup the Dungeontracker settings.",
			type = "group",
			width = "full",
			args = {
				trackerHeader ={
					name = "Dungeontracker Settings",
					order = 0,
					type = "header",
					width = "full"
				},
				trackerDesc = {
					name = "Here you can setup the all Dungeontracker options.",
					order = 1,
					type = "description",
					fontSize = "medium",
					width = "full"
				}					
			}},
	},
	}

-- setter and getter functions for options
function GuildAssist:SendTestGratulation()
	self:Print("Your Gratulationmessage:")
	if (self.db.profile.sendAsciiTruck or self.db.profile.sendAsciiHeart)then
		if (self.db.profile.sendAsciiHeart)then
			GuildAssist:TestSendGZHeart()
		elseif(self.db.profile.sendAsciiTruck) then
			GuildAssist:TestSendGZTruck()
		end
	else
		self:Print(self.db.profile.gratulationMessage)
	end
	
end

function GuildAssist:SendTestDiscord()
	if(self.db.profile.discordmsg ~= "No Discord set.")then
		self:Print("Your Discordmessage:")
		self:Print("\[Discord\] "..self.db.profile.discordmsg)
	end
end

function GuildAssist:TestSendGZTruck()
	self:Print("l\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*l ll\_")
	self:Print("l\_\_\_\_GZ\_\_\_TRUCK\_\_l ll'''''l'''''\_\_\_")
	self:Print("l\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_l lll\_l\_l\_l\_\_\_l)")
	self:Print("l\(\@\)\*\(\@\)\*\*\*\*\*\*\*\*\(\@\)\*\*\(\@\)\*\*\*\*\(\@\)")
end

function GuildAssist:TestSendGZHeart()
	self:Print("\(\¯\`v\´\¯\)\.\. Alles")
	self:Print("\`\•\.\¸\.\•\. Gute zu")
	self:Print("\¸\.\•\´\.\.\.\.\. deinen Erfolg!")
	self:Print("\(\¸\¸\.\•\¨\¯\`\•\»")
end

function GuildAssist:OpenHelpFrame()
	self.ui.help = GA_CreateHelpFrame()
end

function GuildAssist:ToggleShowHelpOnStart(info, value)
	self.db.profile.showHelpOnStart = value
	self:Print("Show Help Window on Start set to: ", value)
end

function GuildAssist:IsShowHelpOnStart(info)
	return self.db.profile.showHelpOnStart
end



function GuildAssist:SendGZTruck()
    C_Timer.After(0.1, function()
        SendChatMessage("l\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*l ll\_", "GUILD");
    end)
    C_Timer.After(0.2, function()
        SendChatMessage("l\_\_\_\_GZ\_\_\_TRUCK\_\_l ll'''''l'''''\_\_\_", "GUILD");
    end)
    C_Timer.After(0.3, function()
        SendChatMessage("l\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_l lll\_l\_l\_l\_\_\_l)", "GUILD");
    end)
    C_Timer.After(0.4, function()
        SendChatMessage("l\(\@\)\*\(\@\)\*\*\*\*\*\*\*\*\(\@\)\*\*\(\@\)\*\*\*\*\(\@\)", "GUILD");
    end)
end

function GuildAssist:SendGZHeart()
    C_Timer.After(0.1, function()
        SendChatMessage("\(\¯\`v\´\¯\)\.\. Alles", "GUILD")
    end)
    C_Timer.After(0.2, function()
        SendChatMessage("\`\•\.\¸\.\•\. Gute zu", "GUILD")
    end)
    C_Timer.After(0.3, function()
        SendChatMessage("\¸\.\•\´\.\.\.\.\. deinen Erfolg!", "GUILD")
    end)
    C_Timer.After(0.4, function()
        SendChatMessage("\(\¸\¸\.\•\¨\¯\`\•\»", "GUILD")
    end)
end


-- toggle ascii heart
function GuildAssist:IsSendAsciiHeart(info)
	return self.db.profile.sendAsciiHeart
end

function GuildAssist:ToggleSendAsciiHeart(info, value)
	if (value == true and GuildAssist:IsSendAsciiTruck() == true) then
		GuildAssist:ToggleSendAsciiTruck(false)
	end
	self.db.profile.sendAsciiHeart = value
	self:Print("Use ASCii Heart set to: ", value)
end

-- toggle ascii truck
function GuildAssist:IsSendAsciiTruck(info)
	return self.db.profile.sendAsciiTruck
end

function GuildAssist:ToggleSendAsciiTruck(info, value)
	if (value == true and GuildAssist:IsSendAsciiHeart() == true) then
		GuildAssist:ToggleSendAsciiHeart(false)
	end
	self.db.profile.sendAsciiTruck = value
	self:Print("Use ASCii Truck set to: ", value)
end

-- set wait time before gratulation
function GuildAssist:GetWaitTimeAutoGratulation(info)
	return self.db.profile.waitTimeGratulation
end

function GuildAssist:SetWaitTimeAutoGratulation(info, value)
	self.db.profile.waitTimeGratulation = value
	self:Print("Set Gratulation Waittime: ", value)
end


-- set wait time before send discord link
function GuildAssist:GetWaitTimeAutoDiscord(info)
	return self.db.profile.waitTimeDiscord
end

function GuildAssist:SetWaitTimeAutoDiscord(info, value)
	self.db.profile.waitTimeDiscord = value
	self:Print("Set Discord Waittime: ", value)
end


-- toggle auto gratulationMessage
function GuildAssist:IsSendAutoGratulation(info)
	return self.db.profile.sendAutoGratulation
end

function GuildAssist:ToggleAutoGratulation(info, value)
	self.db.profile.sendAutoGratulation = value
	self:Print("Set Gratulation Automatic: ", value)
end


-- toggle auto discord
function GuildAssist:IsAutoDiscord(info)
	return self.db.profile.sendAutoDiscord
end

function GuildAssist:ToggleSendAutoDiscord(info, value)
	self.db.profile.sendAutoDiscord = value
	self:Print("Set Discord Automatic: ", value)
end


-- toggle show options on start
function GuildAssist:IsShowOptionOnStart(info)
	return self.db.profile.showOptionsOnStart
end

function GuildAssist:ToggleShowOptionMenuOnStart(info, value)
	self.db.profile.showOptionsOnStart = value
	self:Print("Show Optionwindow on start: ", value)
end


-- set discord Link
function GuildAssist:GetDiscordMessage(info)
	return self.db.profile.discordmsg
end

function GuildAssist:SetDiscordMessage(info, newValue)
	if (newValue == "") then
		newValue = "No Discord set."
	end
	self.db.profile.discordmsg = newValue
	self:Print("Set Discord Message to: ", newValue)
end


-- set custom gratulationMessage
function GuildAssist:GetGratulationMessage(info)
	return self.db.profile.gratulationMessage
end

function GuildAssist:SetGratulationMessage(info, newValue)
	if (newValue == "") then
		newValue = "No Gratulation set."
	end
	self.db.profile.gratulationMessage = newValue
	self:Print("Set Gratulation Message to: ", newValue)
end


-- toggle show addon menu on start
function GuildAssist:IsShowMenuOnStart(info)
	return self.db.profile.showMenuOnStart
end

function GuildAssist:ToggleShowMenuOnStart(info, value)
	self.db.profile.showMenuOnStart = value
	self:Print("Show menu on start: ", value)
end



function GuildAssist:IsShowInChat(info)
    return self.db.profile.showInChat
end

function GuildAssist:ToggleShowInChat(info, value)
    self.db.profile.showInChat = value
	self:Print("Show in chat: ", value)
end

function GuildAssist:IsShowOnScreen(info)
    return self.db.profile.showOnScreen
end

function GuildAssist:ToggleShowOnScreen(info, value)
    self.db.profile.showOnScreen = value
	self:Print("Show on screen: ", value)
end


function GuildAssist:OnInitialize()
	-- Called when the addon is loaded
	-- Print a message to the chat frame
	self:Print("Initialize GuildAssist ...")


	-- register DB
	self.db = LibStub("AceDB-3.0"):New("GuildAssistDB", defaults, true)

	-- register Options menu
	AConfig:RegisterOptionsTable("GuildAssist_options", options)
	self.optionsFrame = AConfigDialog:AddToBlizOptions("GuildAssist_options", "GuildAssist3")

	-- add profiles 	
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	AConfig:RegisterOptionsTable("GuildAssist_Profiles", profiles)
	AConfigDialog:AddToBlizOptions("GuildAssist_Profiles", "Profiles", "GuildAssist3")

	-- register chat commands
	self:RegisterChatCommand("guildassist","ChatCommand")
	self:RegisterChatCommand("ga", "ChatCommand")
	
	-- Create all UI frames
	self.ui = GA_CreateMenu()

	self.ui.tracker = GA_CreateInstanceTracker()
	GA_ColorTextDungeon(self.ui.tracker)
	
	self.ui.help = GA_CreateHelpFrame()
	
	if (self.db.profile.showMenuOnStart == false) then	
		self.ui:Hide()
	end
	
	if(not self.db.profile.showHelpOnStart) then
		self.ui.help:Hide()
	end
	if (self.db.profile.showOptionsOnStart) then
		InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
		InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
	end
	
	if (self.db.profile.firstStart) then
		--self.db.profile.firstStart = true;
		self.ui.welcomeFrame = GA_CreateWelcomeFrame()
	end

end

function GuildAssist:OnEnable()
	-- Called when the addon is enabled / Game is started and loaded
	local player, realm = UnitFullName("player")
	local full_name = player.."-"..realm
	self.db:SetProfile(full_name)
	self:Print("GuildAssist successfully loaded!")
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
	self:RegisterEvent("CHAT_MSG_GUILD")


	    
end

function GuildAssist:OnDisable()
	-- called when addon is diabled
end

function GuildAssist:SendDiscordLink()
	local value = "\[Discord\] "
	value = value..self.db.profile.discordmsg
	C_Timer.After(self.db.profile.waitTimeDiscord, function ()
		SendChatMessage(value, "GUILD")
	end)
end

function GuildAssist:CHAT_MSG_GUILD(arg1,arg2,...)
	local _ = ...;
	if (arg1 == "!discord" and not discordSend) then
		if(self.db.profile.discordmsg ~= "No Discord set." and self.db.profile.sendAutoDiscord) then
			discordSend = true
			C_Timer.After(self.db.profile.waitTimeDiscord, function ()
				GuildAssist:SendDiscordLink()
			end)
			C_Timer.After(2, function ()
				discordSend = false
			end)
		end
	else
		return
	end
end


function GuildAssist:CHAT_MSG_GUILD_ACHIEVEMENT(args, ...)
	local arg1, arg2  = ...;
	if (self.db.profile.IsSendAutoGratulation and not gratulationSend )then
		if(self.db.profile.sendAsciiTruck or self.db.profile.sendAsciiHeart)then
			if (self.db.profile.sendAsciiHeart )then
				gratulationSend = true
				C_Timer.After(self.db.profile.waitTimeGratulation, function ()
					GuildAssist:SendGZHeart()
				end)
				C_Timer.After(2, function ()
					gratulationSend = false
				end)
			elseif (self.db.profile.sendAsciiTruck) then
				gratulationSend = true
				C_Timer.After(self.db.profile.waitTimeGratulation, function ()
					GuildAssist:SendGZTruck()
				end)
				C_Timer.After(2, function ()
					gratulationSend = false
				end)
			end
		elseif (( not self.db.profile.sendAsciiHeart and not self.db.profile.sendAsciiTruck ) and self.db.profile.gratulationMessage ~= "No Gratulation set.")then
			gratulationSend = true
			C_Timer.After(self.db.profile.waitTimeGratulation, function ()
				SendChatMessage(GuildAssist:GetGratulationMessage(), "GUILD")
			end)
			C_Timer.After(2, function ()
				gratulationSend = false
			end)
		else
			return
		end
	else
		return
	end
end



function GuildAssist:ZONE_CHANGED()
	if GetBindLocation() == GetSubZoneText() then
		if self.db.profile.showInChat then
            self:Print(self.db.profile.message);
        end
		if self.db.profile.showOnScreen then
			UIErrorsFrame:AddMessage(self.db.profile.message, 1, 1, 1)
		else
			self:Print(self.db.profile.message)
		end
	end
end

-- SlashCommand handler
function GuildAssist:ChatCommand(input)
    if not input or input:trim() == "" then
		if self.ui:IsShown() then
			self.ui:Hide()
		else
			self.ui = GA_CreateMenu()
		end
	elseif input:trim() == "show" and (self.db.profile.showInChat or self.db.profile.showOnScreen) then
		-- show test message
		if self.db.profile.showOnScreen then
			UIErrorsFrame:AddMessage(self.db.profile.message, 1.0, 1.0, 1.0, 5.0)
		end
		if self.db.profile.showInChat then
			self:Print(self.db.profile.message)
		end
	elseif input:trim() == "help" then
		if self.ui.help:IsShown() then
			self.ui.help:Hide()
		else
			self.ui.help = GA_CreateHelpFrame()
		end
	elseif input:trim() == "tracker" then
		if self.ui.tracker:IsShown() then
			self.ui.tracker:Hide()
		else
			self.ui.tracker = GA_CreateInstanceTracker()
		end
	elseif input:trim() == "config" then
		if InterfaceOptionsFrame:IsShown() then
			InterfaceOptionsFrame:Hide()
		else
			InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
			InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
		end
	else
        LibStub("AceConfigCmd-3.0"):HandleCommand("ga", "GuildAssist_options", input)
    end
end
