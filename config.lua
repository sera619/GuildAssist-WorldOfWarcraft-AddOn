local menuButton = "GameMenuButtonTemplate";
local basicFrame = "BasicFrameTemplateWithInset";
local largeGameFont = "GameFontNormalLarge";
local largeHighlightFont = "GameFontHighlightLarge";


function GA_CreateButton(buttontext, yOffset, xOffset)
    local btn = CreateFrame("Button",nil, GA_UIConfig, menuButton);
    btn:SetPoint("CENTER", UIParent, "CENTER", tonumber(yOffset), tonumber(xOffset));
    btn:SetSize(120, 30);
    btn:SetNormalFontObject(largeGameFont);
    btn:SetHighlightFontObject(largeHighlightFont);
    btn:SetText(buttontext);
    return btn;
end

function GA_CreateButtonBorder(buttontext, yOffset, xOffset)
    local btn = CreateFrame("Button",nil, GA_UIConfig, "UIPanelBorderedButtonTemplate")
    btn:SetPoint("CENTER", UIParent, "CENTER", tonumber(yOffset), tonumber(xOffset));
    btn:SetSize(120, 30);
    btn:SetText(buttontext);
    return btn;
end

local function ScrollFrame_OnMouseWheel(self, delta)
    local newValue = self:GetVerticalScroll() - (delta * 20);
    if (newValue < 0) then
        newValue = 0
    elseif (newValue > self:GetVerticalScrollRange()) then
        newValue = self:GetVerticalScrollRange();
    end
    self:SetVerticalScroll(newValue);
end



--  Create tutorialFrame (SCROLLFRAME)


local function GA_CreateTutorialButton(layoutParent,parent,buttontext, yOffset, xOffset)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(120, 25);
    btn:SetPoint("CENTER", layoutParent, "TOP",tonumber(yOffset),tonumber(xOffset))
    btn:SetNormalFontObject("GameFontNormal");
    btn:SetHighlightFontObject("GameFontHighlight");
    btn:SetText(tostring(buttontext));
    return btn;
end

local function GA_CreateTutorialString(layoutParent, parent, text, yOffset, xOffset)
    local string = parent:CreateFontString(nil, "OVERLAY");
    string:SetPoint("LEFT", layoutParent, "TOPLEFT",tonumber(yOffset), tonumber(xOffset));
    string:SetFontObject("GameFontHighlight");
    string:SetText(tostring(text));
    return string;
end

function GA_CreateDungeonTutorial(parent)
    local tutorialFrame = CreateFrame("Frame", "GA_TutorialFrame", parent, "UIPanelDialogTemplate");
    tutorialFrame:SetSize(250,650);
    tutorialFrame:SetPoint("CENTER",parent,"LEFT", -135, 0);
    -- title
    
    
    
    
    tutorialFrame.scrollFrame= CreateFrame("ScrollFrame",nil, tutorialFrame, "UIPanelScrollFrameTemplate");
    tutorialFrame.scrollFrame:SetPoint("TOPLEFT", GA_TutorialFrameDialogBG, "TOPLEFT",4,-8);
    tutorialFrame.scrollFrame:SetPoint("BOTTOMRIGHT", GA_TutorialFrameDialogBG, "BOTTOMRIGHT",-3,4);
    tutorialFrame.scrollFrame:SetClipsChildren(true);
    tutorialFrame.scrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);
    
    tutorialFrame.scrollFrame.ScrollBar:ClearAllPoints();
    tutorialFrame.scrollFrame.ScrollBar:SetPoint("TOPLEFT", tutorialFrame.scrollFrame, "TOPRIGHT", -12 , -18);
    tutorialFrame.scrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", tutorialFrame.scrollFrame, "BOTTOMRIGHT", -7 , 18);
    
    local child = CreateFrame("Frame", nil, tutorialFrame.scrollFrame);
    child:SetSize(208, 550);
    
    --- SCROLL CHILDS ---
    child.innerTitle = tutorialFrame:CreateFontString(nil, "OVERLAY");
    child.innerTitle:SetFont("Fonts\\MORPHEUS.TTF", 27,"THICKOUTLINE");
    child.innerTitle:SetTextColor(195, 0, 0);
    child.innerTitle:SetPoint("CENTER", child, "TOP", 0, -20);
    child.innerTitle:SetText("Mythic+ Routes");
    
    child.dungeon_01_string = GA_CreateTutorialString(child,child,"Test text", 10, -50);
    child.testButton = GA_CreateTutorialButton(child, child, "Testbutton",0, -80)



    tutorialFrame.scrollFrame:SetScrollChild(child);

    return tutorialFrame;
end