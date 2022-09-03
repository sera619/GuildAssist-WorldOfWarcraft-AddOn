-- Author      : S3R43o3
-- Create Date : 02.09.2022 07:38:15
-- external vars: SavedMessage, SavedDiscord, DiscordAutoOn, GZAutoOn, ChatBotOn
-- This small AddOn adds some small features for the guildchat 
-- include:
-- ChatBot
-- automatic gratulationmessaging if guildmate get a achievement (changeable message)


VersionText = "v2.4.7 2022 © S3R43o3"
HelpMsg1 = "GuildAssist Chat-Bot Commands"
HelpMsg2 = "'!discord' - Zeigt den Discordlink an."
HelpMsg3 = "'!hilfe' - Zeigt diese Hilfe an."
HelpMsg4 = "Development by S3R43o3 © 2022"

DefaultGZMessage = "Herzlichen Glückwunsch!"
LastMessageSend = ""
MessageSend = false

DiscordEnabled = false
GZEnabled = false
ShowedLoadinfo = false


-- init functions
function HideInterface()
    print("GuildAssist Interface closed!\n\rType '/ga' in chat to open Interface again\n ")
    UIFrame:Hide()
end

-- Congrats Automatic Boolean
function SetGZActive()
    if (GZAutoOn == false) then
        GZAutoOn = true
    else
        GZAutoOn = false
    end
    GZCheckButton:SetChecked(GZAutoOn)
    print("Set GZ automatic: ", GZAutoOn)
end

-- Disccord Automatic Boolean
function SetDiscordActive()
    if(DiscordAutoOn == false) then
        DiscordAutoOn = true
    else
        DiscordAutoOn = false
    end
    DiscordCheckButton:SetChecked(DiscordAutoOn)
    print("Set Discord automatic: ", DiscordAutoOn)
end

-- Show window on login boolean
function SetWindowActive()
    if(ShowWindowStart == false) then
        ShowWindowStart = true
    else
        ShowWindowStart = false
    end
    WindowStartCheckButton:SetChecked(ShowWindowStart)
    print("Set Show Window at start: ", ShowWindowStart)
end

-- change discord link
function SetDiscordLink()
    if (GZInput:GetText() == "") then
        -- print("No Discord entered")
    else
        SavedDiscord = GZInput:GetText()
        print("Discord Link set to:", SavedDiscord)
        DiscordStringShow:SetText(SavedDiscord)
        PlaySound(888);
    end
end


-- send commandhelp message
function SendHelp()
    C_Timer.After(0.4, function()
        SendChatMessage(HelpMsg1, "GUILD")
    end)
    C_Timer.After(0.5, function()
        SendChatMessage(HelpMsg2, "GUILD")
    end)
    C_Timer.After(0.6, function ()
        SendChatMessage(HelpMsg3, "GUILD")
    end)
    C_Timer.After(0.7, function ()
        SendChatMessage(HelpMsg4, "GUILD")
    end)
end

-- change gratulation message
function SetGZMessage()
    if(DiscordInput:GetText() == "") then
        -- print("No Message entered")
        return
    else
        SavedMessage = DiscordInput:GetText()
        print("GZ Message set to: ", SavedMessage)
        GZStringShow:SetText(SavedMessage)
        PlaySound(888);
    end
end
function ShowOptions()
    if (OptionFrame:IsVisible() == true) then
        OptionFrame:Hide()
        -- print("Option Frame closed")
    else
        OptionFrame:Show()
        -- print("Option frame open")
    end
end

-- activate ChatBot
function ActivateChatbot()
    if (ChatBotOn == true) then
        ChatBotOn = false
        BotStatusString:SetTextColor(1,0,0,1)
        BotStatusString:SetText("Chat-Bot inaktiv")
        BotButton:SetText("ChatBot AN")
        C_Timer.After(0.5, function ()
            SendChatMessage("GuildAssist Chat Bot ist jetzt inaktiv.", "GUILD")
        end)
    else
        ChatBotOn = true
        BotStatusString:SetTextColor(0,1,0,1)
        BotStatusString:SetText("Chat-Bot aktiv")
        BotButton:SetText("ChatBot AUS")
        C_Timer.After(0.5, function ()
            SendChatMessage("GuildAssist Chat Bot ist jetzt aktiv.", "GUILD")
        end)
    end
    print("Set Chat-Bot: ", ChatBotOn)
end

function OKButtonClick()
    SetGZMessage()
    SetDiscordLink()
    if (OptionFrame:IsVisible() == true) then
        OptionFrame:Hide()
    end
    print("GuildAssist Interface closed!\n\rType '/ga' in chat to open again")
    UIFrame:Hide()
end

-- init Slash Commands
SLASH_GUILDASSIST1 = "/ga";
function SlashCmdList.GUILDASSIST(msg)
    print(msg)
    UIFrame:Show();
    ActivateChatbot()
end

-- initialize AddOn
Frame = CreateFrame("Frame")
Frame:RegisterEvent("ADDON_LOADED")
Frame:RegisterEvent("CHAT_MSG_GUILD")
Frame:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
Frame:SetScript("OnEvent", function(self, event, ...)
    local arg1 = ...
    if (event == "ADDON_LOADED" and arg1 == "GuildAssist2" and ShowedLoadinfo == false) then
        -- hide option window on start
        OptionFrame:Hide()

        ShowedLoadinfo = true
        if (SavedMessage == nil) then
            SavedMessage = "Keine Message"
        end
        if (SavedDiscord == nil) then
            SavedDiscord = "Kein Discord"
        end
        --print("other vars:")
        --print(...)
        
        -- update version string
        VersionString:SetText(VersionText)
        
        -- initialize Saved variables
        if(DiscordAutoOn == nil) then
            print("Discord automatic not set, set zu false")
            DiscordAutoOn = false
        end
        if (GZAutoOn == nil) then
            print("GZAutoOn not set, set to false")
            GZAutoOn = false
        end
        if (ShowWindowStart == nil) then
            print("Show Window at start not set, set to true")
            ShowWindowStart = true
        end
        if (ChatBotOn == nil) then
            print("ChatBotOn not set, set to false")
            ChatBotOn = false
        end

        -- setup welcome message
        local playername = UnitName("player")
        WelcomeString:SetText("Willkommen " .. playername .. "!")

        -- Hide UI if option is set
        if(ShowWindowStart == false) then
            UIFrame:Hide()
        end

        -- update uiframe checkboxes
        WindowStartCheckButton:SetChecked(ShowWindowStart)
        GZCheckButton:SetChecked(GZAutoOn)
        DiscordCheckButton:SetChecked(DiscordAutoOn)
        GZStringShow:SetText(SavedMessage)
        DiscordStringShow:SetText(SavedDiscord)
        BotStatusString:SetTextColor(1,0,0,1)
        BotStatusString:SetText("Chat-Bot inaktiv")
        BotButton:SetText("ChatBot AN")

        print("GuildAssist2 geladen...\nDiscord: " .. SavedDiscord .. "\nNachricht: " .. SavedMessage .. "\nChatBot active: ", ChatBotOn)


    end
    -- Post Discord
    if (event == "CHAT_MSG_GUILD" ) then
        local text, player = ...
        if (text == "!discord" and  LastMessageSend == "" and ChatBotOn == true) then
            LastMessageSend = text
            C_Timer.After(0.8,function ()
                SendChatMessage(SavedDiscord, "GUILD")
            end)
        elseif(LastMessageSend == "!discord" or LastMessageSend == "!hilfe" or LastMessageSend == "!bot") then
            LastMessageSend = ""
            print("lastMessage resettet")
        elseif (text == "!hilfe" and LastMessageSend == "" and ChatBotOn == true) then
            LastMessageSend = text
            SendHelp()
        elseif (text == "!bot" and LastMessageSend == "") then
            LastMessageSend = text
            print(player)
            ActivateChatbot()
        else
            return
        end
    end
    -- gratulation automatic
    if (event == "CHAT_MSG_GUILD_ACHIEVEMENT" and GZAutoOn == true and MessageSend == false) then
        MessageSend = true
        C_Timer.After(2, function ()
            SendChatMessage(SavedMessage, "GUILD");
            MessageSend = false;
        end)
    end
end)