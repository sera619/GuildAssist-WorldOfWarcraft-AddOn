---@diagnostic disable: undefined-field, param-type-mismatch

-- modify chat window to be able use arrowkeys with [alt] modifier
for i = 1, NUM_CHAT_WINDOWS do
    _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end
----------------------------------------------------------------------------


---------------- GUI configuration ----------------
-- General Vars
local addonVersion = "Version: 3.3.3";
local branding = "AddOn Design \& Development 2022 \© S3R43o3";


-- GUI vars
local isGUIshow = true;
local isHelpshow = false;
local GZMessageSended = false;
local isDiscordAutoOn = false;
local isGZAutoOn = false;
local sendHeart = false;
local sendTruck = false;
local showAtStart = true;

local DefaultWaitTime = 3;
local DefaultGZMessage = "Herzlichen Glückwunsch";

local CurrentWaitTime = 0;
local CurrentDiscordLink = "";
local CurrentGZMessage = "";


-- Template strings
local menuButton = "GameMenuButtonTemplate";
local basicFrame = "BasicFrameTemplateWithInset";
local largeGameFont = "GameFontNormalLarge";
local largeHighlightFont = "GameFontHighlightLarge";


-- default vars
local defaults = {
    theme = {
        r = 0,
        g = 0.8,
        b = 1,
        hex = '00ccff'
    }
}

--------------- create Root frame ----------------------

--[[
    CreateFrame arguments:
    1. Type of the frame
    2. name of the frame
    3. parent of the frame
    4. class inerhits as string-list:
                "example1, example2"

]]


GA_UIConfig  = CreateFrame("Frame", "GA_UIFrame", UIParent, basicFrame);
----------------create events---------------------





-- sizing and position of UI Frame
GA_UIConfig:SetSize(800, 650);
GA_UIConfig:SetPoint("CENTER", UIParent, "CENTER"); -- point to set, relative frame, relative Point from rl frame

-- make UI Frame moveable
GA_UIConfig:SetMovable(true);
GA_UIConfig:EnableMouse(true);
GA_UIConfig:RegisterForDrag("LeftButton");
GA_UIConfig:SetScript("OnDragStart", GA_UIConfig.StartMoving)
GA_UIConfig:SetScript("OnDragStop", GA_UIConfig.StopMovingOrSizing)
GA_UIConfig:SetToplevel(true);
GA_UIConfig:SetUserPlaced(true);

------ childframes / regions ------
-- main title string
GA_UIConfig.title = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.title:SetFontObject("GameFontHighlight");
GA_UIConfig.title:SetPoint("LEFT", GA_UIConfig.TitleBg, "LEFT", 10, 0);
GA_UIConfig.title:SetText("Guild Assist - Menu");
GA_UIConfig.title:SetTextColor(255, 0, 0);





----------------- help frame -----------------
GA_HelpFrame = CreateFrame("Frame", "GA_HelpFrame", GA_UIConfig, basicFrame);
GA_HelpFrame:SetSize(400, 650);
GA_HelpFrame:SetPoint("CENTER", GA_UIConfig, "RIGHT", 210, 0);
--GA_HelpFrame:SetMovable(true);
--GA_HelpFrame:EnableMouse(true);
--GA_HelpFrame:RegisterForDrag("LeftButton");
--GA_HelpFrame:SetScript("OnDragStart", GA_HelpFrame.StartMoving)
--GA_HelpFrame:SetScript("OnDragStop", GA_HelpFrame.StopMovingOrSizing)

-- Help frame title

GA_HelpFrame.title = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.title:SetFontObject("GameFontHighlight");
GA_HelpFrame.title:SetPoint("LEFT", GA_HelpFrame.TitleBg, "LEFT", 10, 0);
GA_HelpFrame.title:SetText("Guild Assist - Help");
GA_HelpFrame.title:SetTextColor(255, 0, 0);

-- help frame strings
GA_HelpFrame.innerTitle = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.innerTitle:SetPoint("CENTER", GA_HelpFrame, "TOP", 0, -40);
GA_HelpFrame.innerTitle:SetFont("Fonts\\MORPHEUS.TTF", 27,"THICKOUTLINE");
GA_HelpFrame.innerTitle:SetTextColor(195, 0, 0);
GA_HelpFrame.innerTitle:SetText("Help");

GA_HelpFrame.help_01 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.help_01:SetFontObject(largeGameFont);
GA_HelpFrame.help_01:SetPoint("CENTER", GA_HelpFrame.innerTitle, "CENTER", 0, -30);
GA_HelpFrame.help_01:SetText("Commands");

GA_HelpFrame.help_02 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.help_02:SetFontObject("GameFontHighlight");
GA_HelpFrame.help_02:SetPoint("LEFT", GA_HelpFrame.help_01, "BOTTOM", -150,-25);
GA_HelpFrame.help_02:SetText("Type the follow commands in chat:");


GA_HelpFrame.command_01 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.command_01:SetFontObject("GameFontHighlight");
GA_HelpFrame.command_01:SetPoint("LEFT", GA_HelpFrame.help_02, "TOP", -100,-30);
GA_HelpFrame.command_01:SetText("'/ga' - show the menu");

GA_HelpFrame.command_02 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.command_02:SetFontObject("GameFontHighlight");
GA_HelpFrame.command_02:SetPoint("LEFT", GA_HelpFrame.help_02, "TOP", -100,-50);
GA_HelpFrame.command_02:SetText("'/rl' - a faster and simpler /reload");

GA_HelpFrame.command_03 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.command_03:SetFontObject("GameFontHighlight");
GA_HelpFrame.command_03:SetPoint("LEFT", GA_HelpFrame.help_02, "TOP", -100,-70);
GA_HelpFrame.command_03:SetText("'/fs' - shorthand debug framestack");

GA_HelpFrame.command_04 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.command_04:SetFontObject("GameFontHighlight");
GA_HelpFrame.command_04:SetPoint("LEFT", GA_HelpFrame.help_02, "TOP", -100,-90);
GA_HelpFrame.command_04:SetText("'/gahelp' - shows the helpmenu");

GA_HelpFrame.help_03 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.help_03:SetFontObject(largeGameFont);
GA_HelpFrame.help_03:SetPoint("CENTER", GA_HelpFrame.innerTitle, "TOP", 0, -210);
GA_HelpFrame.help_03:SetText("How to");


GA_HelpFrame.howTo_01 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.howTo_01:SetFontObject("GameFontHighlight");
GA_HelpFrame.howTo_01:SetPoint("CENTER", GA_HelpFrame.help_03, "BOTTOM", 0, -35)
GA_HelpFrame.howTo_01:SetText("To set your custom gratulation message just enter a message in the textbox in the GZ-Message Auto Options section and press 'Set New Gratulation'.")
GA_HelpFrame.howTo_01:SetWidth(350)

GA_HelpFrame.howTo_02 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.howTo_02:SetFontObject("GameFontHighlight");
GA_HelpFrame.howTo_02:SetPoint("CENTER", GA_HelpFrame.howTo_01, "BOTTOM", 0, -40)
GA_HelpFrame.howTo_02:SetText("If you check 'Use ASCii Truck' or 'Use ASCii Heart' the Addon will send a predefined ASCii Art instead of your custom Message.")
GA_HelpFrame.howTo_02:SetWidth(350)

GA_HelpFrame.howTo_03 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.howTo_03:SetFontObject("GameFontHighlight");
GA_HelpFrame.howTo_03:SetPoint("CENTER", GA_HelpFrame.howTo_02, "BOTTOM", 0, -40)
GA_HelpFrame.howTo_03:SetText("You can change the time between achievment earned and send the gratulation message. This is limited to 1 sec minimum and 10 sec maximum.")
GA_HelpFrame.howTo_03:SetWidth(350)


GA_HelpFrame.howTo_04 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.howTo_04:SetFontObject("GameFontHighlight");
GA_HelpFrame.howTo_04:SetPoint("CENTER", GA_HelpFrame.howTo_03, "BOTTOM", 0, -40)
GA_HelpFrame.howTo_04:SetText("To set a Discord link just enter a link in the textbox int the Discord Auto Options section and press 'Set New Discord'.")
GA_HelpFrame.howTo_04:SetWidth(350)

GA_HelpFrame.howTo_05 = GA_HelpFrame:CreateFontString(nil, "OVERLAY");
GA_HelpFrame.howTo_05:SetFontObject("GameFontHighlight");
GA_HelpFrame.howTo_05:SetPoint("CENTER", GA_HelpFrame.howTo_04, "BOTTOM", 0, -40)
GA_HelpFrame.howTo_05:SetText("You can also show a preview of your discordlink and gratulation message if you press the 'Test GZ' or 'Test Discord' button.")
GA_HelpFrame.howTo_05:SetWidth(350)



-- Help UI buttons
GA_HelpFrame.okayButton = CreateFrame("Button", nil, GA_HelpFrame, menuButton);
GA_HelpFrame.okayButton:SetPoint("CENTER", GA_HelpFrame, "BOTTOM", 0, 30);
GA_HelpFrame.okayButton:SetScale(0.8);
GA_HelpFrame.okayButton:SetSize(100, 25);
GA_HelpFrame.okayButton:SetText("Okay");
GA_HelpFrame.okayButton:SetNormalFontObject(largeGameFont);
GA_HelpFrame.okayButton:SetHighlightFontObject(largeHighlightFont);
GA_HelpFrame.okayButton:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    if (isHelpshow == true) then
        GA_HelpFrame:Hide()
        isHelpshow = false
    else
        GA_HelpFrame:Show()
        isHelpshow = true
    end
    PlaySound(888);
end)


--------------------------------------------------------------------------------

function GA_UIConfig:SetGZMessage(text)
	CurrentGZMessage = text;
	SavedMessage = CurrentGZMessage;
	if(sendHeart == false and sendTruck == false) then
        GA_UIConfig.currentMessageText:SetText("\""..text.."\"");
    end
    C_Timer.After(2, function ()
        GA_UIConfig:Print("New GZ Message set to: ",text.."!")
	end)
end
function GA_UIConfig:SetDiscordLink(link)
    if(link == nil) then
        GA_UIConfig.currentDiscordText:SetText("NO Discord set.")
    end
    CurrentDiscordLink = link;
    SavedDiscord = CurrentDiscordLink;
        GA_UIConfig.currentDiscordText:SetText("\""..link.."\"");

        C_Timer.After(2, function ()
        GA_UIConfig:Print("New Discord-Link set to: ",link.."!")
	end)
end




------------ UI ELEMENTS ------------
-- Main ui inner title
GA_UIConfig.innerTitle = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.innerTitle:SetFont("Fonts\\MORPHEUS.TTF", 32,"THICKOUTLINE");
GA_UIConfig.innerTitle:SetTextColor(195, 0, 0);
GA_UIConfig.innerTitle:SetPoint("CENTER", GA_UIConfig, "TOP", 0, -50);
--GA_UIConfig.innerTitle:SetScale(1.2);
GA_UIConfig.innerTitle:SetText("Guild Assist 3");

-- addon Brand and version string

GA_UIConfig.brandingString = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.brandingString:SetPoint("CENTER", GA_UIConfig.innerTitle, "CENTER", 0, -30);
GA_UIConfig.brandingString:SetFontObject("GameFontNormal");
GA_UIConfig.brandingString:SetTextColor(1, 1, 1, .8);
GA_UIConfig.brandingString:SetText(addonVersion.. "\n" .. branding);

GA_UIConfig.welcomeString = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.welcomeString:SetPoint("CENTER", GA_UIConfig.brandingString, "CENTER", 0, -90);
GA_UIConfig.welcomeString:SetFont("Fonts\\FRIZQT__.TTF", 16);
GA_UIConfig.welcomeString:SetHeight(200);
GA_UIConfig.welcomeString:SetWidth(750)



local welcome1 = "Hello and welcome to Guild Assist! |nThis is my very first World of Warcraft Addon that I code at all. So dont be that hard to me!";
local welcome2 = "This Addon currently havent much features but in future it is planned to be a interactive raid/dungeon calender with discordbot synchronization.";
local welcome3 = "For this it also exist a Discord Bot that is coded by my own too. |n|nThis is a very early Version at all if you facing any bugs or some other trouble.";
local welcome4 = "Please contact me \"TrickOnFlick#2943\" on Battle.net, Thank you!"
local welcomeText = welcome1..welcome2..welcome3..welcome4
GA_UIConfig.welcomeString:SetText(welcomeText);




-- Start Checkbox
GA_UIConfig.checkBoxShowStart = CreateFrame("CheckButton","GA_checkBoxShowStart", GA_UIConfig, "UICheckButtonTemplate");
GA_UIConfig.checkBoxShowStart:SetPoint("CENTER", GA_UIConfig ,"TOPLEFT", 25, -35);
GA_UIConfig.checkBoxShowStart.text:SetText("Show Window on Start");


------------------------ GZ MESSAGE FRAME ------------------------
-- gz message frame title
GA_UIConfig.GZtitle = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.GZtitle:SetPoint("TOP", GA_UIConfig, "TOPLEFT", 190,-280);
GA_UIConfig.GZtitle:SetFont("Fonts\\MORPHEUS.TTF", 24,"THICKOUTLINE");
--GA_UIConfig.GZtitle:SetScale(0.8);
GA_UIConfig.GZtitle:SetTextColor(195, 0, 0);
GA_UIConfig.GZtitle:SetText("GZ-Message Auto Options");


-- CURRENT MESSAGE TEXT
GA_UIConfig.currentMessageHeaderText = GA_UIConfig:CreateFontString(nil,"OVERLAY");
GA_UIConfig.currentMessageHeaderText:SetPoint("CENTER",GA_UIConfig.GZtitle, "CENTER", 0, -35);
GA_UIConfig.currentMessageHeaderText:SetFontObject(largeGameFont);
GA_UIConfig.currentMessageHeaderText:SetText("Current Gratulation: ");


GA_UIConfig.currentMessageText = GA_UIConfig:CreateFontString(nil, "OVERLAY")
GA_UIConfig.currentMessageText:SetPoint("CENTER", GA_UIConfig.currentMessageHeaderText, "CENTER", 0, -20);
GA_UIConfig.currentMessageText:SetFontObject("GameFontNormal");
GA_UIConfig.currentMessageText:SetText("No Gratulation Set!");
GA_UIConfig.currentMessageText:SetTextColor(0, 1, 0);
-----------------------------------

----- UI editbox
GA_UIConfig.GZEditBox = CreateFrame("EDITBOX", nil, GA_UIConfig, "InputBoxTemplate");
GA_UIConfig.GZEditBox:SetPoint("CENTER", GA_UIConfig.currentMessageText, "CENTER", 0, -20);
GA_UIConfig.GZEditBox:SetSize(260, 25);
GA_UIConfig.GZEditBox:SetAutoFocus(false);

GA_UIConfig.WaitSliderInfo = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.WaitSliderInfo:SetPoint("CENTER", GA_UIConfig.GZEditBox, "CENTER", 0, -30);
GA_UIConfig.WaitSliderInfo:SetFontObject("GameFontNormal");
GA_UIConfig.WaitSliderInfo:SetText("Time to wait before send GZ Message (1sec - 10sec)")

GA_UIConfig.WaitTimeString = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.WaitTimeString:SetPoint("CENTER", GA_UIConfig.WaitSliderInfo, "CENTER", 0, -30);
GA_UIConfig.WaitTimeString:SetFontObject("GameFontNormal");
GA_UIConfig.WaitTimeString:SetTextColor(0, 1, 0);
GA_UIConfig.WaitTimeString:SetText("Time: ")

----- UI sliders -----
-- time to wait before send message slider
GA_UIConfig.sliderMessageWait = CreateFrame("SLIDER", nil, GA_UIConfig ,"OptionsSliderTemplate");
GA_UIConfig.sliderMessageWait:SetPoint("CENTER", GA_UIConfig.WaitTimeString, "CENTER", 0, -30);
GA_UIConfig.sliderMessageWait:SetMinMaxValues(1, 10);
GA_UIConfig.sliderMessageWait:SetValue(3);
GA_UIConfig.sliderMessageWait:SetValueStep(1); -- does not work 
GA_UIConfig.sliderMessageWait:SetObeyStepOnDrag(true); --- SetValueStep ONLY works with that line
GA_UIConfig.sliderMessageWait:SetScript("OnValueChanged", function (self, arg1, ...)
    local value = ...;
    CurrentWaitTime = arg1;
    GA_UIConfig.WaitTimeString:SetText("Time: "..arg1.." second\(s\)");
end)

-- ASCII check buttons
GA_UIConfig.checkBoxTruck = CreateFrame("CHECKBUTTON", nil, GA_UIConfig, "UICheckButtonTemplate");
GA_UIConfig.checkBoxTruck:SetPoint("TOPLEFT", GA_UIConfig.sliderMessageWait, "BOTTOMLEFT", 0, -15);
GA_UIConfig.checkBoxTruck.text:SetText("Use ASCII Truck");

GA_UIConfig.checkBoxHeart = CreateFrame("CHECKBUTTON", nil, GA_UIConfig, "UICheckButtonTemplate");
GA_UIConfig.checkBoxHeart:SetPoint("TOPLEFT", GA_UIConfig.sliderMessageWait, "BOTTOMLEFT", 0, -40);
GA_UIConfig.checkBoxHeart.text:SetText("Use ASCII Heart");



-- Message checkbox
GA_UIConfig.checkBoxMessage = CreateFrame("CHECKBUTTON", nil, GA_UIConfig, "UICheckButtonTemplate");
GA_UIConfig.checkBoxMessage:SetPoint("TOPLEFT", GA_UIConfig.sliderMessageWait, "BOTTOMLEFT", -5, -70);
GA_UIConfig.checkBoxMessage.text:SetText("Auto GZ Message");
--- set GZ Message Button
GA_UIConfig.GZSetButton = CreateFrame("BUTTON",nil,GA_UIConfig, menuButton);
GA_UIConfig.GZSetButton:SetPoint("CENTER", GA_UIConfig, "BOTTOM", -270, 80);
GA_UIConfig.GZSetButton:SetScale(0.8)
GA_UIConfig.GZSetButton:SetSize(260, 25);
GA_UIConfig.GZSetButton:SetText("Set new Gratulation")
GA_UIConfig.GZSetButton:SetNormalFontObject(largeGameFont);
GA_UIConfig.GZSetButton:SetHighlightFontObject(largeHighlightFont);
GA_UIConfig.GZSetButton:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    local text = GA_UIConfig.GZEditBox:GetText();
    if (text == nil or text == "" )then
        GA_UIConfig:Print("ERROR - No Message set!");
        return;
    else
        GA_UIConfig:SetGZMessage("\""..text.."\"");
        PlaySound(888);
    end
end)
------------------------------------------------------------------------

------------------------ DISCORD MESSAGE FRAME ------------------------
-- gz message frame title
GA_UIConfig.DiscordTitle = GA_UIConfig:CreateFontString(nil, "OVERLAY");
GA_UIConfig.DiscordTitle:SetPoint("TOP", GA_UIConfig, "TOPRIGHT", -190,-280);
GA_UIConfig.DiscordTitle:SetFont("Fonts\\MORPHEUS.TTF", 24,"THICKOUTLINE");
GA_UIConfig.DiscordTitle:SetTextColor(195, 0, 0);
GA_UIConfig.DiscordTitle:SetText("Discord Auto Options");

GA_UIConfig.currentDiscordHeaderText = GA_UIConfig:CreateFontString(nil,"OVERLAY");
GA_UIConfig.currentDiscordHeaderText:SetPoint("CENTER",GA_UIConfig.DiscordTitle, "CENTER", 0, -35);
GA_UIConfig.currentDiscordHeaderText:SetFontObject(largeGameFont);
GA_UIConfig.currentDiscordHeaderText:SetText("Current Discord-Link: ");



GA_UIConfig.currentDiscordText = GA_UIConfig:CreateFontString(nil, "OVERLAY")
GA_UIConfig.currentDiscordText:SetPoint("CENTER", GA_UIConfig.currentDiscordHeaderText, "CENTER", 0, -20);
GA_UIConfig.currentDiscordText:SetFontObject("GameFontNormal");
GA_UIConfig.currentDiscordText:SetText("No Discordlink Set!");
GA_UIConfig.currentDiscordText:SetTextColor(0, 1, 0);

----- UI editbox
GA_UIConfig.DiscordEditBox = CreateFrame("EDITBOX", nil, GA_UIConfig, "InputBoxTemplate");
GA_UIConfig.DiscordEditBox:SetPoint("CENTER", GA_UIConfig.currentDiscordText, "CENTER", 0, -20);
GA_UIConfig.DiscordEditBox:SetSize(260, 25);
GA_UIConfig.DiscordEditBox:SetAutoFocus(false);

-- user input box
GA_UIConfig.checkBoxDiscord = CreateFrame("CHECKBUTTON", nil, GA_UIConfig, "UICheckButtonTemplate");
GA_UIConfig.checkBoxDiscord:SetPoint("TOPRIGHT", GA_UIConfig.DiscordEditBox, "CENTER", -35, -160);
GA_UIConfig.checkBoxDiscord.text:SetText("Auto Discord Link");
--- set GZ Message 
GA_UIConfig.DiscordSetButton = CreateFrame("BUTTON",nil,GA_UIConfig, menuButton);
GA_UIConfig.DiscordSetButton:SetPoint("CENTER", GA_UIConfig, "BOTTOM", 270, 80);
GA_UIConfig.DiscordSetButton:SetScale(0.8)
GA_UIConfig.DiscordSetButton:SetSize(260, 25);
GA_UIConfig.DiscordSetButton:SetText("Set new Discord")
GA_UIConfig.DiscordSetButton:SetNormalFontObject(largeGameFont);
GA_UIConfig.DiscordSetButton:SetHighlightFontObject(largeHighlightFont);
GA_UIConfig.DiscordSetButton:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    local text = GA_UIConfig.DiscordEditBox:GetText();
    if (text == nil or text == "") then
        GA_UIConfig:Print("ERROR - No Discord set!");
        return;
    else
        GA_UIConfig:SetDiscordLink(text);
        PlaySound(888);
    end
end)

function GA_UIConfig:GetThemeColor()
    local c = defaults.theme;
    return c.r, c.g, c.b, c.hex;
end

function GA_UIConfig:Print(...)
    local hex = select(4, GA_UIConfig:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Guild Assist: ");	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end


function SetDiscordAutomatic(boolean)
    if (boolean == true) then
        isDiscordAutoOn =true;
        DiscordAutoToggle = isDiscordAutoOn;
        GA_UIConfig:Print("Discord Automatic ON");
        GA_UIConfig.checkBoxDiscord:SetChecked(isDiscordAutoOn);

    elseif (boolean == false) then
        isDiscordAutoOn = false;
        DiscordAutoToggle = isDiscordAutoOn;
        GA_UIConfig:Print("Discord Automatic OFF");
        GA_UIConfig.checkBoxDiscord:SetChecked(isDiscordAutoOn);
        
    end
    return isDiscordAutoOn
end

function SetGZAutomatic(boolean)
    if (boolean == true) then
        isGZAutoOn = true;
        MessageAutoToggle = isGZAutoOn;
        GA_UIConfig.checkBoxMessage:SetChecked(isGZAutoOn);
        GA_UIConfig:Print("GZ Automatic ON");
    elseif (boolean == false) then
        isGZAutoOn = false;
        MessageAutoToggle = isGZAutoOn;
        GA_UIConfig.checkBoxMessage:SetChecked(isGZAutoOn);
        GA_UIConfig:Print("GZ Automatic OFF");
        
    end
    return isGZAutoOn
end

function SetSendHeart(boolean)
    if (boolean == true) then
        if (sendTruck == true)then
            SetSendTruck(false)
        end
        sendHeart = true;
        GA_UIConfig.checkBoxHeart:SetChecked(sendHeart);
        GA_UIConfig.currentMessageText:SetText("\[ASCii ART\] \"Heart\"");
        GA_UIConfig:Print("Send Heart ASCii ON");
    elseif(boolean == false) then
        sendHeart= false;
        GA_UIConfig.checkBoxHeart:SetChecked(sendHeart)
        GA_UIConfig:Print("Send Heart ASCii OFF");
        if (sendTruck == false) then
            GA_UIConfig.currentMessageText:SetText("\"" .. CurrentGZMessage.."\"");
        end
    end
end

function SetSendTruck(boolean)
    if (boolean == true) then
        if(sendHeart == true) then
            SetSendHeart(false);
        end
        sendTruck = true;
        GA_UIConfig.checkBoxTruck:SetChecked(sendTruck)
        GA_UIConfig:Print("Send Truck ASCii ON");
        GA_UIConfig.currentMessageText:SetText("\[ASCii ART\] \"Truck\"");

    elseif(boolean == false) then
        sendTruck = false;
        GA_UIConfig.checkBoxTruck:SetChecked(sendTruck)
        GA_UIConfig:Print("Send Truck ASCii OFF");
        if (sendHeart == false) then
            GA_UIConfig.currentMessageText:SetText("\"" .. CurrentGZMessage.."\"");
        end
    end
end

function SetShowStart(boolean)
    if (boolean == true) then
        GA_UIConfig.checkBoxShowStart:SetChecked(boolean);
        showAtStart = true;
        SavedShowMenuStart = showAtStart;
        GA_UIConfig:Print("Show Window at Start ON")
    elseif(boolean == false) then
        GA_UIConfig.checkBoxShowStart:SetChecked(boolean);
        showAtStart = false;
        SavedShowMenuStart = showAtStart;
        GA_UIConfig:Print("Show Window at Start OFF")

    end
end

function GA_UIConfig:SendGZTrain()
    C_Timer.After(0.1, function ()
        SendChatMessage("l\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*l ll\_","GUILD");
    end)
    C_Timer.After(0.2, function ()
        SendChatMessage("l\_\_\_\_GZ\_\_\_TRUCK\_\_l ll'''''l'''''\_\_\_","GUILD");
    end)
    C_Timer.After(0.3, function ()
        SendChatMessage("l\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_l lll\_l\_l\_l\_\_\_l)","GUILD");
    end)
    C_Timer.After(0.4, function ()
        SendChatMessage("l\(\@\)\*\(\@\)\*\*\*\*\*\*\*\*\(\@\)\*\*\(\@\)\*\*\*\*\(\@\)","GUILD");
    end)
end

function GA_UIConfig:SendGZHeart()
    C_Timer.After(0.1, function ()
        SendChatMessage("\(\¯\`v\´\¯\)\.\. Alles", "GUILD")
    end)
    C_Timer.After(0.2, function ()
        SendChatMessage("\`\•\.\¸\.\•\. Gute zu", "GUILD")
    end)
    C_Timer.After(0.3, function ()
        SendChatMessage("\¸\.\•\´\.\.\.\.\. deinen Erfolg!", "GUILD")
    end)
    C_Timer.After(0.4, function ()
        SendChatMessage("\(\¸\¸\.\•\¨\¯\`\•\»", "GUILD")
    end)
end

GA_UIConfig.checkBoxShowStart:SetScript("OnClick", function (self, arg1, ...)
    local arg2 = ...;
    PlaySound(888);
    if(GA_UIConfig.checkBoxShowStart:GetChecked() == true) then
        SetShowStart(true);
    elseif (GA_UIConfig.checkBoxShowStart:GetChecked() == false) then
        SetShowStart(false);
    end
end)



GA_UIConfig.checkBoxHeart:SetScript("OnClick", function (self, arg1, ...)
    local arg2 = ...;
    PlaySound(888);
    if(GA_UIConfig.checkBoxHeart:GetChecked() == false)then
        SetSendHeart(false);
    elseif (GA_UIConfig.checkBoxHeart:GetChecked() == true) then
        SetSendHeart(true);
    end
end)

GA_UIConfig.checkBoxTruck:SetScript("OnClick", function (self, arg1, ...)
    local arg2 = ...;
    PlaySound(888);
    if(GA_UIConfig.checkBoxTruck:GetChecked() == false)then
        SetSendTruck(false);
    elseif (GA_UIConfig.checkBoxTruck:GetChecked() == true) then
        SetSendTruck(true);
    end
end)

GA_UIConfig.checkBoxDiscord:SetScript("OnClick", function (self, arg1, ...)
    local arg2 = ...;
    --print(arg1, arg2)
    if (GA_UIConfig.checkBoxDiscord:GetChecked() == true)then
        PlaySound(888);
        SetDiscordAutomatic(true)
    elseif(GA_UIConfig.checkBoxDiscord:GetChecked() == false)then
        SetDiscordAutomatic(false);
    end
end)


GA_UIConfig.checkBoxMessage:SetScript("OnClick", function (self, arg1, ...)
    local arg2 = ...;
    --print(arg1, arg2)
    PlaySound(888);
    if (GA_UIConfig.checkBoxMessage:GetChecked() == true)then
        SetGZAutomatic(true);
    elseif(GA_UIConfig.checkBoxMessage:GetChecked() == false)then
        SetGZAutomatic(false);
    end
end)

------------------------------------------------------------------------


----- UI buttons -----
-- UI okay button
GA_UIConfig.okayButton = CreateFrame("Button", nil, GA_UIConfig, menuButton);
GA_UIConfig.okayButton:SetScale(0.8);
GA_UIConfig.okayButton:SetPoint("CENTER", GA_UIConfig, "TOP", 230, -630*1.24);
GA_UIConfig.okayButton:SetSize(100, 25);
GA_UIConfig.okayButton:SetText("Okay");
GA_UIConfig.okayButton:SetNormalFontObject(largeGameFont);
GA_UIConfig.okayButton:SetHighlightFontObject(largeHighlightFont);
GA_UIConfig.okayButton:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    ReloadUI();
end)

-- UI cancel button
GA_UIConfig.cancelButton = CreateFrame("Button", nil, GA_UIConfig.okayButton, menuButton);
GA_UIConfig.cancelButton:SetPoint("CENTER",GA_UIConfig.okayButton, "RIGHT", 50,0);
GA_UIConfig.cancelButton:SetSize(100, 25);
GA_UIConfig.cancelButton:SetText("Cancel");
GA_UIConfig.cancelButton:SetNormalFontObject(largeGameFont);
GA_UIConfig.cancelButton:SetHighlightFontObject(largeHighlightFont);
GA_UIConfig.cancelButton:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    --print("args: ", _);
    GA_UIConfig:Hide();
    isGUIshow = false;
    GA_HelpFrame:Hide();
    isHelpshow = false;
    GA_UIConfig:Print("Frame closed type '/ga' to show again.")
    --GA_UIConfig:SendGZTrain();
    --GA_UIConfig:SendGZHeart();
end)

-- UI help button
GA_UIConfig.helpButton = CreateFrame("Button", nil, GA_UIConfig.cancelButton, menuButton);
GA_UIConfig.helpButton:SetPoint("CENTER",GA_UIConfig.cancelButton, "RIGHT", 50,0);
GA_UIConfig.helpButton:SetSize(100, 25);
GA_UIConfig.helpButton:SetText("Help");
GA_UIConfig.helpButton:SetNormalFontObject(largeGameFont);
GA_UIConfig.helpButton:SetHighlightFontObject(largeHighlightFont);
GA_UIConfig.helpButton:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    if (isHelpshow == false) then
        GA_HelpFrame:Show()
        isHelpshow = true
    else
        GA_HelpFrame:Hide()
        isHelpshow = false
    end
end)

GA_HelpFrame:Hide()


--[[
    ]]

GA_UIConfig.sendTestGZ = CreateFrame("Button", nil, GA_UIConfig, menuButton);
GA_UIConfig.sendTestGZ:SetScale(0.8);
GA_UIConfig.sendTestGZ:SetPoint("LEFT", GA_UIConfig, "BOTTOM", -360 , 30);
GA_UIConfig.sendTestGZ:SetSize(140, 30);
GA_UIConfig.sendTestGZ:SetText("Test GZ");
GA_UIConfig.sendTestGZ:SetNormalFontObject(largeGameFont);
GA_UIConfig.sendTestGZ:SetHighlightFontObject(largeHighlightFont);
GA_UIConfig.sendTestGZ:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    if (sendHeart == true or sendTruck == true) then
        if (sendTruck == true) then
            GA_UIConfig:Print("Sending Current GZ Message (ASCII ART 'Truck'):");
            GA_UIConfig:Print("l\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*l ll\_");
            GA_UIConfig:Print("l\_\_\_\_GZ\_\_\_TRUCK\_\_l ll'''''l'''''\_\_\_");
            GA_UIConfig:Print("l\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_l lll\_l\_l\_l\_\_\_l)");
            GA_UIConfig:Print("l\(\@\)\*\(\@\)\*\*\*\*\*\*\*\*\(\@\)\*\*\(\@\)\*\*\*\*\(\@\)");
            PlaySound(888);
            return
        end
        if (sendHeart == true) then
            GA_UIConfig:Print("Sending Current GZ Message (ASCII ART 'Heart'):");
            GA_UIConfig:Print("\(\¯\`v\´\¯\)\.\. Alles")
            GA_UIConfig:Print("\`\•\.\¸\.\•\. Gute zu")
            GA_UIConfig:Print("\¸\.\•\´\.\.\.\.\. deinen Erfolg!")
            GA_UIConfig:Print("\(\¸\¸\.\•\¨\¯\`\•\»")
            PlaySound(888);
            return
        end

    else
        GA_UIConfig:Print("Sending Current GZ Message");
        GA_UIConfig:Print(CurrentGZMessage)
        PlaySound(888);
        return
    end
end)


GA_UIConfig.sendTestDiscord = CreateFrame("Button", nil, GA_UIConfig, menuButton);
GA_UIConfig.sendTestDiscord:SetScale(0.8);
GA_UIConfig.sendTestDiscord:SetPoint("CENTER", GA_UIConfig.sendTestGZ, "RIGHT", 150 , 0);
GA_UIConfig.sendTestDiscord:SetSize(140, 30);
GA_UIConfig.sendTestDiscord:SetText("Test Discord");
GA_UIConfig.sendTestDiscord:SetNormalFontObject(largeGameFont);
GA_UIConfig.sendTestDiscord:SetHighlightFontObject(largeHighlightFont);
GA_UIConfig.sendTestDiscord:SetScript("OnClick", function (self, arg1, ...)
    local _ = ...;
    if ( not CurrentDiscordLink == "") then
        PlaySound(888);
        GA_UIConfig:Print("Unser Discord: "..CurrentDiscordLink)
    end
end)

--- MINIMAP BUTTON 

GA_UIConfig.mapButton = CreateFrame("Button", "GA_MinimapButton", Minimap, menuButton)
GA_UIConfig.mapButton:SetPoint("RIGHT", Minimap, "BOTTOMLEFT", -10, 0)
GA_UIConfig.mapButton:SetSize(20,20)
GA_UIConfig.mapButton:SetNormalTexture("Interface\\Icons\\inv_misc_enggizmos_27")

GA_UIConfig.mapButton:SetScript("OnClick", function ()
    if (isGUIshow == false) then
        GA_UIConfig:Show()
        isGUIshow = true;
    elseif(isGUIshow == true) then
        GA_UIConfig:Hide()
        isGUIshow = false;
    end
end)


-------------------------------------



GA_UIConfig:RegisterEvent("ADDON_LOADED")
GA_UIConfig:RegisterEvent("CHAT_MSG_GUILD")
GA_UIConfig:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
GA_UIConfig:RegisterEvent('CHAT_MSG_SAY')
GA_UIConfig:RegisterEvent('PLAYER_LOGOUT')

------------------------------------------------------
--------------- START / INIT ADDON -------------------

GA_UIConfig:SetScript("OnEvent", function (self, event, ...)
    local arg1 = ...;
    if (event == 'ADDON_LOADED' and arg1 == 'GuildAssist3') then
        GA_UIConfig:Print("Welcome back", UnitName("player").. "!");
        
        
        if (SavedShowMenuStart == nil) then
            SavedShowMenuStart = showAtStart;
            
            SetShowStart(showAtStart);
        else
            showAtStart = SavedShowMenuStart;
            SetShowStart(showAtStart);
        end
        
        if(SavedWaitTime == nil) then
            CurrentWaitTime = DefaultWaitTime;
            SavedWaitTime = CurrentWaitTime;
            GA_UIConfig.WaitTimeString:SetText("Time: "..tostring(CurrentWaitTime).." second\(s\)");
            GA_UIConfig.sliderMessageWait:SetValue(CurrentWaitTime);
        else
            CurrentWaitTime = SavedWaitTime;
            GA_UIConfig.WaitTimeString:SetText("Time: "..tostring(CurrentWaitTime).." second\(s\)");
            GA_UIConfig.sliderMessageWait:SetValue(CurrentWaitTime);
        end
        if(GZSendHeart == nil) then
            GZSendHeart = sendHeart;
            SetSendHeart(sendHeart);
        else
            sendHeart = GZSendHeart;
            SetSendHeart(sendHeart);
        end
        if(GZSendTruck == nil) then
            GZSendTruck = sendTruck;
            SetSendTruck(GZSendTruck);
        else 
            sendTruck = GZSendTruck;
            SetSendTruck(GZSendTruck);
        end
        
        
        if(SavedMessage == nil or SavedMessage == "") then
            GA_UIConfig:SetGZMessage(DefaultGZMessage)
            if ( sendHeart == false and sendTruck == false) then
                GA_UIConfig.currentMessageText:SetText("\""..CurrentGZMessage.."\"");
            end
        else
            CurrentGZMessage = SavedMessage;
            GA_UIConfig:SetGZMessage(CurrentGZMessage)
            if ( sendHeart == false and sendTruck == false) then
                GA_UIConfig.currentMessageText:SetText("\""..CurrentGZMessage.."\"");
            end
        end
        
        if(SavedDiscordLink== "" or SavedDiscordLink == nil )then
            GA_UIConfig:SetDiscordLink(CurrentDiscordLink)
            GA_UIConfig.currentDiscordText:SetText("\""..CurrentDiscordLink.."\"")
        else
            GA_UIConfig:SetDiscordLink(SavedDiscordLink)
            GA_UIConfig.currentDiscordText:SetText("\""..CurrentDiscordLink.."\"")
        end
        
        if(DiscordAutoToggle == nil) then
            DiscordAutoToggle = isDiscordAutoOn;
        else
            isDiscordAutoOn = DiscordAutoToggle;
            SetDiscordAutomatic(isDiscordAutoOn);
        end
        
        if(MessageAutoToggle == nil) then
            MessageAutoToggle = isGZAutoOn;
        else
            isGZAutoOn= MessageAutoToggle;
            SetGZAutomatic(isGZAutoOn);
        end
        
        if(showAtStart == false) then
            GA_UIConfig:Hide()
            isGUIshow = false;
        end
    end
    
    if (event == "CHAT_MSG_GUILD" and isDiscordAutoOn == true and not CurrentDiscordLink == "" ) then --and (not CurrentDiscordLink == "" or CurrentDiscordLink ==nil)) then
        local text, name = ...;
        local player = UnitName("player").."-Blackhand";
        if (name == player)then
            return
        end
        if (text == "!discord") then
            SendChatMessage("Unser Discord: "..CurrentDiscordLink)
            return
        end
    end
    
    if (event == "CHAT_MSG_GUILD_ACHIEVEMENT" and isGZAutoOn == true and GZMessageSended == false) then
        GZMessageSended = true;
        
        C_Timer.After(CurrentWaitTime, function ()
            if(sendHeart == true) then
                GA_UIConfig:SendGZHeart();
            end 
            if(sendTruck == true) then
                GA_UIConfig:SendGZTrain();
            end
            
            if (sendHeart == false and sendTruck == false) then
                SendChatMessage(CurrentGZMessage, "GUILD");
            end
            --GA_UIConfig:SendGZHeart();
            C_Timer.After(2, function ()
                GZMessageSended = false;
            end)
        end)
    end
    if(event == "PLAYER_LOGOUT") then
        SavedMessage = CurrentGZMessage;
        SavedDiscord = CurrentDiscordLink;
        DiscordAutoToggle = isDiscordAutoOn;
        MessageAutoToggle = isGZAutoOn;
        GZSendHeart = sendHeart;
        GZSendTruck = sendTruck;
        SavedWaitTime = CurrentWaitTime;
    end
end)


-- ShowUp
GA_UIConfig:Show();

------------------------------------------------------


---------------- create slashcommands ----------------
-- show up GUI command
SLASH_GASHOW1 = "/ga";
SlashCmdList.GASHOW = function ()
    if (isGUIshow == true) then
        GA_UIConfig:Hide();
        isGUIshow = false;
    else
        GA_UIConfig:Show();
        isGUIshow = true;
    end
end

-- faster reload command
SLASH_RELOAD1 = "/rl";
SlashCmdList.RELOAD = ReloadUI;

-- faster show framestack command
SLASH_FRAMESTK1 = "/fs";
SlashCmdList.FRAMESTK = function ()
    LoadAddOn('Blizzard_DebugTools')
    FrameStackTooltip_Toggle()
end
-- show help
SLASH_GAHELP1 = "/gahelp";
SlashCmdList.GAHELP = function ()
    if (isHelpshow == true) then
        GA_HelpFrame:Hide();
        isHelpshow = false;
    else
        GA_HelpFrame:Show();
        isHelpshow = true;
    end
end

----------------------------------------------------------------------------
