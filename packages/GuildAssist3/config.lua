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