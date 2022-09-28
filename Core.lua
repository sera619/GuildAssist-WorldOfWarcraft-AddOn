
local _, GuildAssist = ...;
local gratulationSend = false
local discordSend = false
local AConfig = LibStub("AceConfig-3.0")
local AConfigDialog = LibStub("AceConfigDialog-3.0")
local AceGUI = LibStub("AceGUI-3.0")

GuildAssist = LibStub("AceAddon-3.0"):NewAddon("GuildAssist3", "AceConsole-3.0", "AceEvent-3.0" );
-- enable alt and arrowkeys to chat 
for i = 1, _G.NUM_CHAT_WINDOWS do
	_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end
if GuildAssist then
	SLASH_RELOAD1 = "/rl";
	_G.SlashCmdList.RELOAD = _G.ReloadUI;
	
	-- faster show framestack command
	SLASH_FRAMESTK1 = "/fs";
	_G.SlashCmdList.FRAMESTK = function ()
		LoadAddOn('Blizzard_DebugTools')
		_G.FrameStackTooltip_Toggle()
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
		showWelcomeOnStart = false,
		discordmsg = "No Discord set.",
		gratulationMessage = "No Gratulation set.",
		sendAutoGratulation = false,
		sendAutoDiscord = false,
		waitTimeDiscord = 2,
		waitTimeGratulation = 3,
		sendAsciiTruck = false,
		sendAsciiHeart = false,
		minimap = { 
			hide = false,
		},
	},
}

local generalSettings = {
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
		--[[
		showMenuOnStart = {
			type ="toggle",
			name ="Show menu on Start",
			desc = "Toggle to show addon menu at start.",
			get = "IsShowMenuOnStart",
			set = "ToggleShowMenuOnStart",
			order = 2,
			width = "full"
		}, 
		]]
		showWelcomeOnStart ={
			type = "toggle",
			name = "Show Welcome at Start",
			desc = "Toggle to show Welcomewindow at start.",
			get = "IsShowWelcomeOnStart",
			set = "ToggleShowWelcomeOnStart",
			width = "full",
			order = 2,
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
	}
}


local options = {
	name ="GuildAssist3 Options",
	handler = GuildAssist,
	type = "group",
	args = {
		generalSetting = generalSettings,
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
	--:UI-Achievement-WoodBorder
-- setter and getter functions for options
function GuildAssist:ToggleShowWelcomeOnStart(info, value)
	self.db.profile.showWelcomeOnStart = value
	self:Print("Show Welcomemessage at Start set to: ", value)
end

function GuildAssist:IsShowWelcomeOnStart(info)
	return self.db.profile.showWelcomeOnStart
end
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
		self:Print("[Discord] "..self.db.profile.discordmsg)
	end
end

function GuildAssist:TestSendGZTruck()
	self:Print("l*********************l ll_")
	self:Print("l____GZ___TRUCK__l ll\'\'\'\'\'l\'\'\'\'\'___")
	self:Print("l_________________l lll_l_l_l___l)")
	self:Print("l(@)*(@)********(@)**(@)****(@)")
end

function GuildAssist:TestSendGZHeart()
	self:Print("(¯`v´¯).. Alles")
	self:Print(" `•.¸.•´. Gute zu")
	self:Print(" ¸.•´..... deinen Erfolg!")
	self:Print("(¸¸.•¨¯`•»")
end

function GuildAssist:SendGZTruck()
    C_Timer.After(0.15, function()
        SendChatMessage("l*********************l ll_", "GUILD");
    end)
    C_Timer.After(0.2, function()
        SendChatMessage("l____GZ___TRUCK__l ll\'\'\'\'\'l\'\'\'\'\'___", "GUILD");
    end)

    C_Timer.After(0.25, function()
        SendChatMessage("l_________________l lll_l_l_l___l)", "GUILD");
    end)
    C_Timer.After(0.3, function()
        SendChatMessage("l(@)*(@)********(@)**(@)****(@)","GUILD");
    end)
end

function GuildAssist:SendGZHeart()
    C_Timer.After(0.1, function()
        SendChatMessage("(¯`v´¯).. Alles", "GUILD")
    end)
    C_Timer.After(0.2, function()
        SendChatMessage(" `•.¸.•´. Gute zu", "GUILD")
    end)
    C_Timer.After(0.3, function()
        SendChatMessage(" ¸.•´..... deinen Erfolg!", "GUILD")
    end)
    C_Timer.After(0.4, function()
        SendChatMessage("(¸¸.•¨¯`•»", "GUILD")
    end)
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


local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)

function GuildAssist:OnInitialize()
	-- Called when the addon is loaded
	-- Print a message to the chat frame
	self:Print("Initialize GuildAssist ...")
    
	-- register DB
	self.db = LibStub("AceDB-3.0"):New("GuildAssistDB", defaults, true)
	
	-- register Options menu
	AConfig:RegisterOptionsTable("GuildAssist_options", options)
	self.optionsFrame = AConfigDialog:AddToBlizOptions("GuildAssist_options", "GuildAssist3")

	-- register minimapbutton 
	if LDB then
		local icon = LDB:NewDataObject("GuildAssistDB", {
		type = "launcher",
		text = "GuildAssist",
		icon = "Interface\\Icons\\inv_misc_enggizmos_27",
		OnClick = function(_, button)
			if button == "RightButton" and not IsShiftKeyDown() then
				if (GuildAssist.ui.help:IsShown() == false) then
					GuildAssist.ui.help = GA_CreateHelpFrame()
				else
					GuildAssist.ui.help:Hide()
				end
			end
			if button == "LeftButton" and not IsShiftKeyDown() then
				if (_G.InterfaceOptionsFrame:IsShown() == false) then
					_G.InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
					_G.InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
					--GuildAssist:SendGZTruck()
				else
					_G.InterfaceOptionsFrame:Hide()
				end
			end
			if(button == "LeftButton" and IsShiftKeyDown()) then
				if (self.db.profile.sendAutoGratulation) then
					self.db.profile.sendAutoGratulation = false
					GuildAssist:ToggleAutoGratulation(_, false)
				else
					self.db.profile.sendAutoGratulation = true
					GuildAssist:ToggleAutoGratulation(_, true)
				end
			end
			if(button == "RightButton" and IsShiftKeyDown()) then
				if (self.db.profile.sendAutoDiscord) then
					self.db.profile.sendAutoDiscord = false
					GuildAssist:ToggleSendAutoDiscord(_,false)
				else
					self.db.profile.sendAutoDiscord = true
					GuildAssist:ToggleSendAutoDiscord(_,true)
				end
			end
		end,
		OnTooltipShow = function(tt)
			tt:AddLine("GuildAssist3")
			tt:AddLine("|cffffff00LeftClick|r to open the GuildAssist Settings.")
			tt:AddLine("|cffffff00RightClick|r to open the GuildAssist Help.")
			tt:AddLine("|cffffff00LeftClick + [Shift]|r to enable/disable Auto-Gratulation.")
			tt:AddLine("|cffffff00RightClick + [Shift]|r to enable/disable Auto-Discord.")
		end,
		})
		if LDBIcon then
			LDBIcon:Register("GuildAssist3", icon, self.db.profile.minimap)
		end
	end
	
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
		_G.InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
		_G.InterfaceOptionsFrame_OpenToCategory(GuildAssist.optionsFrame)
	end
	
	self.ui.welcomeFrame = GA_CreateWelcomeFrame()
	if (self.db.profile.firstStart) then
		self.db.profile.firstStart = false;
	end
	if (not self.db.profile.firstStart and not self.db.profile.showWelcomeOnStart) then
		self.ui.welcomeFrame:Hide()
	end
	------------ Debugge Development Settings -----------
	--self.ui.calendar = GA_CreateCalender()
	
	_G.PVEFrame:SetScript("OnShow",function (self, ...)
		if not GuildAssist.ui.tracker:IsShown() then
			GuildAssist.ui.tracker:Show()
		else
			return
		end
	end)
	_G.PVEFrame:SetScript("OnHide", function (self, ...)
		if GuildAssist.ui.tracker:IsShown() then
			GuildAssist.ui.tracker:Hide()
		end
	end)
end

function GuildAssist:OnEnable()
	-- Called when the addon is enabled / Game is started and loaded
	local player, realm = UnitFullName("player")
	local full_name = player.."-"..realm
	self.db:SetProfile(full_name)
	self:Print("GuildAssist |cff00ff00successfully|r loaded!\n\r Welcome back |cffb620e8"..UnitName("player").."|r")
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
	self:RegisterEvent("CHAT_MSG_GUILD")
	    
end

function GuildAssist:OnDisable()
	-- called when addon is diabled
end

function GuildAssist:SendDiscordLink()
	local value = " [Discord] "
	value = value..self.db.profile.discordmsg
	C_Timer.After(self.db.profile.waitTimeDiscord, function ()
		SendChatMessage(value, "GUILD")
	end)
end

function GuildAssist:CHAT_MSG_GUILD(arg1,arg2,...)
	local _ = ...;
	if (arg2== "!discord" and not discordSend) then
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
	if (self.db.profile.sendAutoGratulation and not gratulationSend )then
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
		elseif ( not self.db.profile.sendAsciiHeart and not self.db.profile.sendAsciiTruck ) and self.db.profile.sendAutoGratulation and not gratulationSend then
			if self.db.profile.gratulationMessage ~= "No Gratulation set." then
				gratulationSend = true
				C_Timer.After(self.db.profile.waitTimeGratulation, function ()
					SendChatMessage(GuildAssist:GetGratulationMessage(), "GUILD")
				end)
				C_Timer.After(2, function ()
					gratulationSend = false
				end)
			else
				return self:Print("Cant send a empty Gratulation, please set one or use a premade ASCii Image!")
			end
		else
			return self:Print("|cffff0000Something with Ascii or Gratulation Message went wrong!|r")
		end
	end
end



function GuildAssist:ZONE_CHANGED()
	if GetBindLocation() == GetSubZoneText() then
		if self.db.profile.showInChat then
            self:Print(self.db.profile.message);
        end
		if self.db.profile.showOnScreen then
			_G.UIErrorsFrame:AddMessage(self.db.profile.message, 1, 1, 1)
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
			_G.UIErrorsFrame:AddMessage(self.db.profile.message, 1.0, 1.0, 1.0, 5.0)
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
			GA_ColorTextDungeon(self.ui.tracker)
			self.ui.tracker:Show()
		end
	elseif input:trim() == "config" then
		if _G.InterfaceOptionsFrame:IsShown() then
			_G.InterfaceOptionsFrame:Hide()
		else
			_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
			_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
		end
	else
        LibStub("AceConfigCmd-3.0"):HandleCommand("ga", "GuildAssist_options", input)
    end
end
