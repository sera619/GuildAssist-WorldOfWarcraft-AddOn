-- Author      : S3R43o3
-- Create Date : 15.08.2022 12:18:22

local UserGratulationMessage = "Herzlichen Glückwunsch";
local AutomaticEnabled = true;
local lastMessage;






function CongrACMCheck_OnClick()
    if(AutomaticEnabled == true) then
        AutomaticEnabled = false;
        print("-[!]- auto gratulation OFF")
    else
        AutomaticEnabled = true;
        print("-[!]- auto gratulation ON")
    end
end

function ReloadButton_OnClick()
    ReloadUI();
end

function ExitButton_OnClick()
    MainFrame:Hide();
    print("Hide GuildAssist GUI\nTippe /ga in den Chat um das Interface erneut zu öffnen.");
end

function OkButton_OnClick()
    SetGratulationMessage()
    print("Ok Button clicked");
    print(UserGratulationMessage)
    print(SavedChatMessage)
    MainFrame:Hide()
end


function SetGratulationMessage()
    local newGratulation = MessageEdit:GetText();
    if (newGratulation == "") then
        return
    else
        UserGratulationMessage = tostring(newGratulation);
        print("User Gratulation is " ..UserGratulationMessage);
        CurrentGratulationString:SetText(UserGratulationMessage);
        SavedChatMessage = UserGratulationMessage
    end
end


local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out

function frame:OnEvent(event, arg1)
    if (event == "ADDON_LOADED" and arg1 == "GuildAssist") then
        if(SavedChatMessage == nil) then
            SavedChatMessage = "HeyHo";
            print("Geladene Nachricht:".. SavedChatMessage ..", GuildAssist Addon loaded...\nUm das Optionsfenster zu öffnen tippe /ga in den Chat.");
            return
        else
            UserGratulationMessage = SavedChatMessage;
            print("Geladene Nachricht:".. SavedChatMessage ..", GuildAssist Addon loaded...\nUm das Optionsfenster zu öffnen tippe /ga in den Chat.");
            CurrentGratulationString:SetText(SavedChatMessage);
            SetGratulationMessage()
            AutomaticEnabled = SavedSendAutomatic
            return
        end
    elseif (event == "PLAYER_LOGOUT" and arg1 == "GuildAssist") then
            SavedChatMessage = UserGratulationMessage;
            SavedSendAutomatic = AutomaticEnabled
    
    end
end

frame:SetScript("OnEvent", frame.OnEvent);
SLASH_HAVEWEMET1 = "/ga";
function SlashCmdList.HAVEWEMET(msg)
    MainFrame:Show();
end
local autograts=CreateFrame('frame')
autograts:RegisterEvent('CHAT_MSG_GUILD_ACHIEVEMENT')
autograts:SetScript('OnEvent',function()
    autograts.trigger=true 
    C_Timer.After(5,function()
        if autograts.trigger and AutomaticEnabled == true then
            autograts.trigger=false
            SendChatMessage(UserGratulationMessage,'GUILD')
        end
    end)
end)



