local _, GuildAssist3 = ...;

local function debugFrame ()
    local DebugFrame = CreateFrame("Frame", "GA_DEBUGGFrame", UIParent,"TooltipBackdropTemplate")
    DebugFrame:SetPoint("CENTER", UIParent, "CENTER", 0,0)
    DebugFrame:SetSize(250, 600)
    DebugFrame:SetMovable(true)
    DebugFrame:EnableMouse()
    DebugFrame:SetMovable(true);
    DebugFrame:EnableMouse(true);
    DebugFrame:RegisterForDrag("LeftButton");
    DebugFrame:SetScript("OnDragStart", DebugFrame.StartMoving)
    DebugFrame:SetScript("OnDragStop", DebugFrame.StopMovingOrSizing)
    DebugFrame:SetToplevel(true);
    DebugFrame:SetUserPlaced(true);
    return DebugFrame
end

