local menuButton = "GameMenuButtonTemplate";
local basicFrame = "BasicFrameTemplateWithInset";
local largeGameFont = "GameFontNormalLarge";
local largeHighlightFont = "GameFontHighlightLarge";

_G.DungeonNamesDE = {
    "Die Nebel von Tirna Scithe",
    "Die Nekrotische Schneise",
    "Hallen der Sühne",
    "Theater der Schmerzen",
    "Seuchensturz",
    "Die Andre Seite",
    "Spitzen des Aufstiegs",
    "Die Blutigen Tiefen",
    "Tazavesh, der Verhüllte Markt",
}
_G.DungeonNamesEN = {
    "Mists of Tirna Scithe",
    "The Necrotic Wake",
    "Plaguefall",
    "Halls of Atonement",
    "Theater of Pain",
    "De Other Side",
    "Spires of Ascension",
    "Sanguine Depths",
    "Tazavesh the Veiled Market",
}

function GA_CreateButton(buttontext, yOffset, xOffset)
    local btn = CreateFrame("Button", nil, GA_UIConfig, menuButton);
    btn:SetPoint("CENTER", UIParent, "CENTER", tonumber(yOffset), tonumber(xOffset));
    btn:SetSize(120, 30);
    btn:SetNormalFontObject(largeGameFont);
    btn:SetHighlightFontObject(largeHighlightFont);
    btn:SetText(buttontext);
    return btn;
end

function GA_CreateButtonBorder(buttontext, yOffset, xOffset)
    local btn = CreateFrame("Button", nil, GA_UIConfig, "UIPanelBorderedButtonTemplate")
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
local function GA_CreateTutorialButton(layoutParent, parent, buttontext, yOffset, xOffset)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(195, 25);
    btn:SetPoint("CENTER", layoutParent, "BOTTOM", tonumber(yOffset), tonumber(xOffset))
    btn:SetNormalFontObject("GameFontNormal");
    btn:SetHighlightFontObject("GameFontHighlight");
    btn:SetText(tostring(buttontext));
    return btn;
end

function GA_CreateDungeonTutorial(parent)

    local tutorialInfo = "Here you can get the routes for the Mythic+ dungeons. Just click the button for the dungeon you like.";
    local dungeonNames = { "Upper Karazhan", "Lower Karazhan", "Mechagon:Junkyard", "Mechagon:Workshop", "Grimrail Depot",
        "Iron Docks", "Tazavesh: Streets of Wonder", "Tazavesh: So'leah's Gambit" }

    local tutorialFrame = CreateFrame("Frame", "GA_TutorialFrame", parent, "UIPanelDialogTemplate");
    tutorialFrame:SetSize(250, 650);
    tutorialFrame:SetPoint("CENTER", parent, "LEFT", -135, 0);
    tutorialFrame.scrollFrame = CreateFrame("ScrollFrame", nil, tutorialFrame, "UIPanelScrollFrameTemplate");
    tutorialFrame.scrollFrame:SetPoint("TOPLEFT", GA_TutorialFrameDialogBG, "TOPLEFT", 4, -8);
    tutorialFrame.scrollFrame:SetPoint("BOTTOMRIGHT", GA_TutorialFrameDialogBG, "BOTTOMRIGHT", -3, 4);
    tutorialFrame.scrollFrame:SetClipsChildren(true);
    tutorialFrame.scrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);
    tutorialFrame.scrollFrame.ScrollBar:ClearAllPoints();
    tutorialFrame.scrollFrame.ScrollBar:SetPoint("TOPLEFT", tutorialFrame.scrollFrame, "TOPRIGHT", -12, -18);
    tutorialFrame.scrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", tutorialFrame.scrollFrame, "BOTTOMRIGHT", -7, 18);

    local child = CreateFrame("Frame", nil, tutorialFrame.scrollFrame);
    child:SetSize(208, 550);

    --- SCROLL CHILDS ---
    child.innerTitle = child:CreateFontString(nil, "OVERLAY");
    child.innerTitle:SetFont("Fonts\\MORPHEUS.TTF", 27, "THICKOUTLINE");
    child.innerTitle:SetTextColor(195, 0, 0);
    child.innerTitle:SetPoint("CENTER", child, "TOP", 0, -20);
    child.innerTitle:SetText("Mythic+ Routes");

    child.dungeon_01_string = child:CreateFontString(nil, "OVERLAY");
    child.dungeon_01_string:SetWidth(195);
    child.dungeon_01_string:SetPoint("CENTER", child.innerTitle, "BOTTOM", 0, -30);
    child.dungeon_01_string:SetFontObject("GameFontNormal");
    child.dungeon_01_string:SetWordWrap(true);
    child.dungeon_01_string:SetText(tutorialInfo);
    child.dungeon_01_string:SetHeight(50.0);

    -- Dungeon buttons
    child.upperKaraButton = GA_CreateTutorialButton(child.dungeon_01_string, child, tostring(dungeonNames[1]), 0, -20)
    child.lowerKaraButton = GA_CreateTutorialButton(child.upperKaraButton, child, tostring(dungeonNames[2]), 0, -20)
    child.mechaJunkButton = GA_CreateTutorialButton(child.lowerKaraButton, child, tostring(dungeonNames[3]), 0, -20)
    child.mechaWorkButton = GA_CreateTutorialButton(child.mechaJunkButton, child, tostring(dungeonNames[4]), 0, -20)
    child.grimrailButton = GA_CreateTutorialButton(child.mechaWorkButton, child, tostring(dungeonNames[5]), 0, -20)
    child.irondocksButton = GA_CreateTutorialButton(child.grimrailButton, child, tostring(dungeonNames[6]), 0, -20)
    child.tazaStreets = GA_CreateTutorialButton(child.irondocksButton, child, tostring(dungeonNames[7]), 0, -20)
    child.tazaGambit = GA_CreateTutorialButton(child.tazaStreets, child, tostring(dungeonNames[8]), 0, -20)

    -- close button
    child.closeButton = CreateFrame("Button", nil, child, "UIPanelButtonTemplate");
    child.closeButton:SetPoint("CENTER", tutorialFrame, "BOTTOM", 0, 25)
    child.closeButton:SetSize(80, 20)
    child.closeButton:SetText("Close")
    child.closeButton:SetScript("OnClick", function()
        if (tutorialFrame:IsShown() == true) then
            tutorialFrame:Hide()
        else
            tutorialFrame:Show()
        end
    end)

    tutorialFrame.scrollFrame:SetScrollChild(child);

    return tutorialFrame;
end

-- mythic dungeon instance tracker

function GA_InstanceTracker(parent)
    -- base frame
    local uiFrame = CreateFrame("Frame", "GA_InstanceTracker", parent, "UIPanelDialogTemplate");
    --[[    
        2291 	De Other Side
        2287 	Halls of Atonement
        2290 	Mists of Tirna Scithe
        2289 	Plaguefall
        2284 	Sanguine Depths
        2285 	Spires of Ascension
        2286 	The Necrotic Wake
        2293 	Theater of Pain
        2441 	Tazavesh the Veiled Market
    ]]

    uiFrame:SetSize(400, 125);
    uiFrame:SetPoint("TOPRIGHT", PVEFrame, "TOPRIGHT", 0, 120);

    -- window title
    uiFrame.title = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.title:SetFontObject("GameFontHighlight");
    uiFrame.title:SetPoint("TOPLEFT", GA_InstanceTrackerDialogBG, "TOPLEFT", 10, 15);
    uiFrame.title:SetText("Guild Assist - Instance Tracker");
    uiFrame.title:SetTextColor(255, 0, 0);

    -- inner Title
    uiFrame.innerTitle = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.innerTitle:SetFontObject("GameFontNormal");
    uiFrame.innerTitle:SetPoint("CENTER", GA_InstanceTrackerDialogBG, "CENTER", 0, 35);
    uiFrame.innerTitle:SetText("Your free mythic instance are:");
    -- DUNGEON STRINGS
    -- de other side
    uiFrame.otherSide = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.otherSide:SetFontObject("GameFontHighlight");
    uiFrame.otherSide:SetPoint("TOPLEFT", GA_InstanceTrackerDialogBG, "TOPLEFT", 15, -20);
    -- halls of atonement
    uiFrame.hallsOfAtonement = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.hallsOfAtonement:SetFontObject("GameFontHighlight");
    uiFrame.hallsOfAtonement:SetPoint("TOPLEFT", GA_InstanceTrackerDialogBG, "TOPLEFT", 15, -35);
    --	Mists of Tirna Scithe
    uiFrame.mistOfTirneScithe = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.mistOfTirneScithe:SetFontObject("GameFontHighlight");
    uiFrame.mistOfTirneScithe:SetPoint("TOPLEFT", GA_InstanceTrackerDialogBG, "TOPLEFT", 15, -50);

    uiFrame.plaguefall = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.plaguefall:SetFontObject("GameFontHighlight");
    uiFrame.plaguefall:SetPoint("TOPLEFT", GA_InstanceTrackerDialogBG, "TOPLEFT", 15, -65);

    uiFrame.sanguineDepths = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.sanguineDepths:SetFontObject("GameFontHighlight");
    uiFrame.sanguineDepths:SetPoint("TOPRIGHT", GA_InstanceTrackerDialogBG, "TOPRIGHT", -15, -20);

    uiFrame.spiresOfAscension = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.spiresOfAscension:SetFontObject("GameFontHighlight");
    uiFrame.spiresOfAscension:SetPoint("TOPRIGHT", GA_InstanceTrackerDialogBG, "TOPRIGHT", -15, -35);

    uiFrame.theNecroticWake = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.theNecroticWake:SetFontObject("GameFontHighlight");
    uiFrame.theNecroticWake:SetPoint("TOPRIGHT", GA_InstanceTrackerDialogBG, "TOPRIGHT", -15, -50);

    uiFrame.theaterOfPain = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.theaterOfPain:SetFontObject("GameFontHighlight");
    uiFrame.theaterOfPain:SetPoint("TOPRIGHT", GA_InstanceTrackerDialogBG, "TOPRIGHT", -15, -65);

    uiFrame.tazavesh = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.tazavesh:SetFontObject("GameFontHighlight");
    uiFrame.tazavesh:SetPoint("TOP", GA_InstanceTrackerDialogBG, "TOP", 0, -78);


    uiFrame.otherSide:SetText(DungeonNamesDE[5]);
    uiFrame.hallsOfAtonement:SetText(DungeonNamesDE[3]);
    uiFrame.mistOfTirneScithe:SetText(DungeonNamesDE[1]);
    uiFrame.plaguefall:SetText(DungeonNamesDE[4]);
    uiFrame.sanguineDepths:SetText(DungeonNamesDE[7]);
    uiFrame.spiresOfAscension:SetText(DungeonNamesDE[6]);
    uiFrame.theNecroticWake:SetText(DungeonNamesDE[2]);
    uiFrame.theaterOfPain:SetText(DungeonNamesDE[8]);
    uiFrame.tazavesh:SetText(DungeonNamesDE[9]);
    
    GA_ColorTextDungeon(uiFrame)
    return uiFrame
end

function GA_ColorTextDungeon(frame)
    local lockDun = GA_TrackDungeons()
    for i = 1, #lockDun do
        if (lockDun[i] == DungeonNamesDE[1]) then
            frame.mistOfTirneScithe:SetTextColor(195, 0, 0);
        else
            frame.mistOfTirneScithe:SetTextColor(0, 155, 0);
        end
        if (lockDun[i] == DungeonNamesDE[2]) then
            frame.theNecroticWake:SetTextColor(195, 0, 0);
        else
            frame.theNecroticWake:SetTextColor(0, 155, 0);
        end

        if (lockDun[i] == DungeonNamesDE[3]) then
            frame.hallsOfAtonement:SetTextColor(195, 0, 0);
        else
            frame.hallsOfAtonement:SetTextColor(0, 155, 0);
        end
        
        if (lockDun[i] == DungeonNamesDE[4]) then
            frame.theaterOfPain:SetTextColor(195, 0, 0);
        else
            frame.theaterOfPain:SetTextColor(0, 155, 0);
        end
        
        if (lockDun[i] == DungeonNamesDE[5]) then
            frame.plaguefall:SetTextColor(195, 0, 0);
        else
            frame.plaguefall:SetTextColor(0, 155, 0);
        end
        
        if (lockDun[i] == DungeonNamesDE[6]) then
            frame.otherSide:SetTextColor(195, 0, 0);
        else
            frame.otherSide:SetTextColor(0, 155, 0);
        end
        
        if (lockDun[i] == DungeonNamesDE[7]) then
            frame.spiresOfAscension:SetTextColor(195, 0, 0);
        else
            frame.spiresOfAscension:SetTextColor(0, 155, 0);
        end

        if (lockDun[i] == DungeonNamesDE[8]) then
            frame.sanguineDepths:SetTextColor(195, 0, 0);
        else
            frame.sanguineDepths:SetTextColor(0, 155, 0);
        end
        
        if (lockDun[i] == DungeonNamesDE[9]) then
            frame.tazavesh:SetTextColor(195, 0, 0);
        else
            frame.tazavesh:SetTextColor(0, 155, 0);
        end
    end
end

function GA_TrackDungeons()
    local lockedDungeons = {}
    local dungeonIDs = GetNumSavedInstances()
    -- Get Locked Dungeons
    for i = 1, dungeonIDs do
        --print(dungeonIDs[i])
        local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled = GetSavedInstanceInfo(i)

        -- check german names
        for j = 1, #DungeonNamesDE do
            local dName = DungeonNamesDE[j]
            if (name == dName and difficulty == 23 and locked == true) then
                --print(name)
                table.insert(lockedDungeons, name)
            end
        end
        -- check english names
        for k = 1, #DungeonNamesEN do
            local eName = DungeonNamesEN[k]

            if (name == eName and difficulty == 23 and locked == true) then
                --print(name)
                table.insert(lockedDungeons, name)
            end
        end
    end
    return lockedDungeons;
    --print(type(id),name,difficulty,type( locked), locked, instanceIDMostSig , extended)
end
