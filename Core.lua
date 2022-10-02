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
		newAddonPatch3 = true,
		playerName = UnitName("player"),
		message = "Welcome to GuildAssist3",
		showOnScreen = false,
		showInChat = false,
		showMenuOnStart = false,
		showOptionsOnStart = false,
		showHelpOnStart = false,
		showWelcomeOnStart = false,
		showDungeontracker = true,
		isAutoInvite = false,
		isSendInviteMessage = false,
		isSendWhisperMessage = false,
		inviteGrpSize = 5,
		inviteWakeword = "|cffff0000No Wakeword set.|r",
		inviteWakewordPrefix = "!",
		inviteMessageStart = "|cffff0000No Startmessage set.|r",
		inviteMessageStop = "|cffff0000No Stopmessage set.|r",
		inviteWhisperMessage = "|cffff0000No Whispermessage set.|r",
		
		discordmsg = "|cffff0000No Discord set.|r",
		gratulationMessage = "|cffff0000No Gratulation set.|r",
		sendAutoGratulation = false,
		sendAutoDiscord = false,
		waitTimeDiscord = 2,
		waitTimeGratulation = 3,
		sendAsciiTruck = false,
		sendAsciiHeart = false,
		minimap = { 
			hide = false,
		},
		minimap2 = {
			hide = false,
		}
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
		generalSection = {
			type ="group",
			width = "full",
			name = "Common Options",
			inline = true,
			args ={
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
			},
		},
		helpSection = {
			width = "full",
			name = "General Help",
			type = "group",
			inline = true,
			args = {
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
	}
}

local trackerSettings = {
	order = 4,
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
		},
		trackerToggle = {
			name = "Show Dungeontracker",
			desc = "Toggle the Dungeontracker ",
			order = 2,
			type = "toggle",
			set = "ToggleShowDungeontracker",
			get = "IsShowDungeonTracker",
			width = "full"
		}
	}
}

local inviteSettings = {
	order = 3,
	name ="Auto-Invite Settings",
	handler = GuildAssist,
	desc = "Here you can setup the Auto-Invite settings.",
	type = "group",
	width = "full",
	args = {
		inviteSection = {
			name ="Automatic Invite",
			type = "group",
			width = "full",
			inline = true,
			order = 1,
			args = {
				inviteHeader ={
					name = "Auto-Invite Settings",
					order = 0,
					type = "header",
					width = "full"
				},
				inviteDesc = {
					name = "Here you can adjust all settings for the Auto-Invite plugin.",
					order = 1,
					type = "description",
					fontSize = "medium",
					width = "full"
				},
				inviteToggle = {
					name = "Toggle Auto-Invite",
					desc = "Toggle the Auto-Invite plugin",
					order = 3,
					type = "toggle",
					set = "ToggleAutoInvite",
					get = "IsAutoInvite",
					width = "full"
				},
			}
		},

		wakewordSection = {
			name ="Invite Wakeword",
			type = "group",
			width = "full",
			inline = true,
			order = 2,
			args = {
				wakewordDesc = {
					name = "Please Notice:\nThe wakeword will have |cffff0000ALLWAYS|r the prefix \"!\"\nAs example: \"!example\"",
					order = 1,
					type = "description",
					fontSize = "medium",
					width = "full"
				},
				wakeWord = {
					name = "Enter your wakeword here",
					order = 2,
					type = "input",
					set = "SetInviteWakeword",
					get = "GetInviteWakeword",
					width = "full"
				},
			}
		},

		groupSizeSection = {
			name = "Invite Group/Party",
			type = "group",
			width = "full",
			inline = true,
			order = 3,
			args = {
				groupSizeDescription = {
					name = "Set the maxium players to invite before the Addon stop invite players.",
					order = 0,
					type = "description",
					width = "full",
					fontSize = "medium"
				},
				groupSize = {
					name = "Max number of player",
					values = {
						[5] = "5 man",
						[10] = "10 man",
						[20] = "20 man",
						[25] = "25 man",
						[40] = "40 man",
					 },
					set = "SetAutoInviteGrpSize",
					get = "GetAutoInviteGrpSize",
					style = "dropdown",
					type ="select",
					order = 1,
					width = "full"
				},

			}
		},

		inviteMessageSection = {
			name = "Invite Messages",
			type = "group",
			width = "full",
			order = 4,
			inline = true,
			args = {		
				inviteStart = {
					name = "Enter your start announcement message here",
					order = 1,
					type = "input",
					set = "SetInviteStartMsg",
					get = "GetInviteStartMsg",
					width = "full"
				},
				inviteStop = {
					name = "Enter your stop announcement message here",
					order = 2,
					type = "input",
					set = "SetInviteStopMsg",
					get = "GetInviteStopMsg",
					width = "full"
				},
				iniviteWhisperMsg = {
					name = "Enter a Message that will be send to the player you invite in your group.",
					order = 3,
					type = "input",
					set = "SetInviteWhisperMessage",
					get = "GetInviteWhisperMessage",
					width = "full"
				},
				inviteSpacer1 = {
					name = " ",
					order = 4,
					type = "description",
					fontSize = "medium",
					width = "full"
				},
				inviteAnnounceToggle = {
					name = "Toggle Send Announcement",
					desc = "Toggle send Announcement to guildchatchannel",
					order = 5,
					type = "toggle",
					set = "ToggleSendInviteMsg",
					get = "IsSendInviteMsg",
					width = "full"
				},
				inviteSendWhisperMsg = {
					name = "Toggle send Whispermessage",
					desc = "Enable/Disable whisper your Whispermessage to the player you invite",
					order = 7,
					type = "toggle",
					get = "IsSendWhisperMessage",
					set = "ToggleSendWhisperMessage",
					width = "full"
				}

			}

		},
		inviteSpacer2 = {
			name = " ",
			order = 5,
			type = "description",
			fontSize = "medium",
			width = "full"
		},



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
		inviteSetting = inviteSettings,
		trackerSetting = trackerSettings,
	},
}
	--:UI-Achievement-WoodBorder
-- setter and getter functions for options


function GuildAssist:ToggleSendWhisperMessage(info, value)
	self.db.profile.isSendWhisperMessage = value
	self:print("Auto-Invite send Whispermessage set to: ", value)
end

function GuildAssist:IsSendWhisperMessage(info)
	return self.db.profile.isSendWhisperMessage
	
end

function GuildAssist:SetInviteWhisperMessage(info, value)
	if value == "" then
		value = "|cffff0000No Whispermessage set.|r"
	end
	if (value == "No Whispermessage set.") then
		value = "|cffff0000"..value.."|r"
	end
	self.db.profile.inviteWhisperMessage = value
	self:Print("Auto-Invite Whispermessage set to:|n|cff00ff22"..tostring(value).."|r")
end

function GuildAssist:GetInviteWhisperMessage(info)
	return self.db.profile.inviteWhisperMessage
end

function GuildAssist:SetInviteStartMsg(info, value)
	if (value == "") then
		value = "No Startmessage set."
	end
	if (value == "No Startmessage set.") then
		value = "|cffff0000"..value.."|r"
	end
	self.db.profile.inviteMessageStart = value
	self:Print("Auto-Invite Startmessage set to :", tostring(value))
end

function GuildAssist:GetInviteStartMsg(info)
	return self.db.profile.inviteMessageStart
end

function GuildAssist:SetInviteStopMsg(info, value)
	if (value == "") then
		value = "No Stopmessage set."
	end
	if (value == "No Stopmessage set.") then
		value = "|cffff0000"..value.."|r"
	end
	self.db.profile.inviteMessageStop = value
	self:Print("Auto-Invite Stopmessage set to :", tostring(value))
end

function GuildAssist:GetInviteStopMsg(info)
	return self.db.profile.inviteMessageStop
end

function GuildAssist:IsSendInviteMsg(info)
	return self.db.profile.isSendInviteMessage
end

function GuildAssist:ToggleSendInviteMsg(info, value)
	self.db.profile.isSendInviteMessage = value
	self:Print("Send Auto-Invite message set to :", value)
end

function GuildAssist:SetAutoInviteGrpSize(info, value)
	self.db.profile.inviteGrpSize = tonumber(value)
	self:Print("Auto-Invite max groupsize set to :",value)
end

function GuildAssist:GetAutoInviteGrpSize(info)
	return self.db.profile.inviteGrpSize
end

function GuildAssist:SetInviteWakeword(info, value)
	if (value == "") then
		value = "No Wakeword set."
	end
	if (value == "No Wakeword set.") then
		value = "|cffff0000"..value.."|r"
	end
	self.db.profile.inviteWakeword = value
	self:Print("Auto-Invite Wakeword is set to: ", value)
	
end

function GuildAssist:GetInviteWakeword(info)
	return self.db.profile.inviteWakeword
end

function GuildAssist:IsAutoInvite(info)
	return self.db.profile.isAutoInvite
end

function GuildAssist:ToggleAutoInvite(info, value)
	self.db.profile.isAutoInvite = value
	self:Print("Auto-Invite is set to: ", value)
	if (self.db.profile.isSendInviteMessage and self.db.profile.inviteMessageStart ~= "No Startmessage set.") and value == true then
		SendChatMessage(self.db.profile.inviteMessageStart, "GUILD")
	end
	if (self.db.profile.isSendInviteMessage and self.db.profile.inviteMessageStop ~= "No Stopmessage set.") and value == false then
		SendChatMessage(self.db.profile.inviteMessageStop, "GUILD")
	end

end

function GuildAssist:ToggleShowDungeontracker(info, value)
	self.db.profile.showDungeontracker = value
	self:Print("Show Dungeontracker set to: ", value)
end

function GuildAssist:IsShowDungeonTracker(info)
	return self.db.profile.showDungeontracker
end

function GuildAssist:ToggleShowWelcomeOnStart(info, value)
	self.db.profile.showWelcomeOnStart = value
	self:Print("Show Welcomemessage at Start set to: ", value)
end

function GuildAssist:IsShowWelcomeOnStart(info)
	return self.db.profile.showWelcomeOnStart
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
	if (newValue == "No Discord set.") then
		newValue = "|cffff0000"..newValue.."|r"
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
		newValue = "No Startmessage set."
	end
	if (newValue == "No Startmessage set.") then
		newValue = "|cffff0000"..newValue.."|r"
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
---------------------------------------------------------

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
				tt:AddLine("|cffb00000GuildAssist3|r")
				tt:AddLine("|cff2c6ac7LeftClick|r to open the GuildAssist Settings.")
				tt:AddLine("|cff2c6ac7RightClick|r to open the GuildAssist Help.")
				tt:AddLine("|cff2c6ac7LeftClick + [Shift]|r to enable/disable Auto-Gratulation.")
				tt:AddLine("|cff2c6ac7RightClick + [Shift]|r to enable/disable Auto-Discord.")
			end})
		local icon2 = LDB:NewDataObject("GuildAssistDB2",{
			type = "launcher",
			text = "GuildAssist Calender",
			icon = "Interface\\Icons\\priest_icon_chakra_blue",
			OnClick = function(_,button)
				if button == "LeftButton" then
					if GuildAssist.ui.calendar:IsShown() then
						GuildAssist.ui.calendar:Hide()
					else	
						GuildAssist.ui.calendar = GA_CreateCalender()
					end
				end
			end,
			OnTooltipShow = function(tt)
				tt:AddLine("|cffb00000GuildAssist Calender|r")
				tt:AddLine("|cff2c6ac7LeftClick|r Show GuildAssist Calender")
			end})
		if LDBIcon then
			--LDBIcon:Register("GuildAssist3calender", icon2, self.db.profile.minimap2)
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
	if (not self.db.profile.showWelcomeOnStart) then
		self.ui.welcomeFrame:Hide()
	end
	-- enable dungeon tracker on LFG frame show
	_G.PVEFrame:SetScript("OnShow",function (self, ...)
		if not GuildAssist.ui.tracker:IsShown() and GuildAssist.db.profile.showDungeontracker then
			GuildAssist.ui.tracker:Show()
		end
	end)
	_G.PVEFrame:SetScript("OnHide", function (self, ...)
		if GuildAssist.ui.tracker:IsShown() then
			GuildAssist.ui.tracker:Hide()
		end
	end)

	if (self.db.profile.newAddonPatch3) then
		self.ui.patchnotes = GA_CreateUpdateFrame()
		--self.db.profile.newAddonPatch3 = false
	end

	if self.db.profile.isAutoInvite then
		self.db.profile.isAutoInvite = false
		GuildAssist:ToggleAutoInvite(_, false)
	end
	------------ Debugge Development Settings -----------
--
	--self.ui.calendar = GA_CreateCalender()
end

function GuildAssist:OnEnable()
	-- Called when the addon is enabled / Game is started and loaded
	local player, realm = UnitFullName("player")
	local full_name = player.."-"..realm
	self:Print("GuildAssist |cff00ff00successfully|r loaded!\n\r Welcome back |cffb620e8"..UnitName("player").."|r|n")
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
	self:RegisterEvent("CHAT_MSG_GUILD")
	self:RegisterEvent("CHAT_MSG_WHISPER")
	--self:Print(roster)
	--SendChatMessage("!inv", "WHISPER",nil, UnitName("player"))
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

function GuildAssist:CHAT_MSG_WHISPER(arg1, arg2, arg3,...)
	local _ = ...;
	local msg = arg2
	local whisperPlayerName = arg3
	if (msg == "!"..self.db.profile.inviteWakeword and self.db.profile.inviteWakeword ~= "No Wakeword set.") then
		--print("Invite player command recieved from ", whisperPlayerName)
		if(self.db.profile.isAutoInvite) then
			GuildAssist:AutoInvitePlayer(whisperPlayerName)
		else
			return
		end
	end
end

-- check if whisperer is in your guild
function GuildAssist:IsInGuild(playername)
	local t, m, _ = GetNumGuildMembers()
	local isInGuild = false
	for i = 1, t do
		local n, _, _ , _, _ = GetGuildRosterInfo(i)
		if n == playername then
			isInGuild = true
			break
		end
	end
	return isInGuild
end

-- auto invite player
function GuildAssist:AutoInvitePlayer(player)
	local isGuild = GuildAssist:IsInGuild(player)
	if (isGuild and self.db.profile.isAutoInvite) then
		local grpSize = GetNumGroupMembers()
		--print(grpSize)
		if grpSize <= tonumber(self.db.profile.inviteGrpSize) then
			--print("invite player")
			if self.db.isSendWhisperMessage and not self.db.profile.inviteWhisperMessage == "No Whispermessage set." then
				SendChatMessage(tostring(self.db.inviteWhisperMessage), "WHISPER", nil, player)
			end
			C_Timer.After(1.5, function ()
				C_PartyInfo.InviteUnit(player)
			end)

			if grpSize == tonumber(self.db.profile.inviteGrpSize) then
				GuildAssist:ToggleAutoInvite(_, false)
			end
		else
			GuildAssist:ToggleAutoInvite(_, false)--print("max grp size reached turn off")
		end

	else
		print("dont invite player")
	end
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

function GuildAssist:CHAT_MSG_GUILD_ACHIEVEMENT(text, playerName, ...)
	local arg4, arg5,_  = ...;
	local player = arg4
	local myChar, myrealm = UnitFullName('player')
	myChar = myChar.."-"..myrealm
	if player == myChar then
		return
	end
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
