local _, GuildAssist = ...; 
local AceGUI = LibStub("AceGUI-3.0")
local addOnVersion = "4.1.6"
local branding = "GuildAssist3 v"..addOnVersion.." | Addon Design & Development © S3R43o3 2022"

local menuButton = "GameMenuButtonTemplate";
local basicFrame = "BasicFrameTemplateWithInset";
local largeGameFont = "GameFontNormalLarge";
local largeHighlightFont = "GameFontHighlightLarge";
local transparentFrame = "TooltipBackdropTemplate";

-- function that draws the widgets for the first tab
local function DrawGroup1(container)
    local desc = AceGUI:Create("Label")
    desc:SetText("This is Tab 1")
    desc:SetFullWidth(true)
    container:AddChild(desc)
    
    local button = AceGUI:Create("Button")
    button:SetText("Tab 1 Button")
    button:SetWidth(200)
    container:AddChild(button)
    end

-- function that draws the widgets for the second tab
local function DrawGroup2(container)
    local desc = AceGUI:Create("Label")
    desc:SetText("This is Tab 2")
    desc:SetFullWidth(true)
    container:AddChild(desc)

    local button = AceGUI:Create("Button")
    button:SetText("Tab 2 Button")
    button:SetWidth(200)
    container:AddChild(button)
end

-- Callback function for OnGroupSelected
local function SelectGroup(container, event, group)
    container:ReleaseChildren()
    if group == "tab1" then
        DrawGroup1(container)
    elseif group == "tab2" then
        DrawGroup2(container)
    end
end

-- Create Help frame
function GA_CreateHelpFrame()
    --local testString = "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Voluptatibus quas dolore adipisci quibusdam fuga tempora, ducimus quo aperiam hic aliquid, provident magnam, tenetur esse vitae. Atque tenetur consectetur minima. Totam saepe rerum sed, ipsa magnam eaque, architecto beatae distinctio sequi atque dicta eum alias id nam, similique maxime accusantium velit."
    local rootFrame = AceGUI:Create("Frame")
    rootFrame:SetTitle("GuildAssist3 - Help")
    rootFrame:SetStatusText(branding)
    rootFrame:SetCallback("OnClose", function (widget) AceGUI:Release(widget) end)
    rootFrame:SetLayout("Flow")
    rootFrame:SetHeight(500)
    rootFrame:SetWidth(600)

    local scrollcontainer = AceGUI:Create("SimpleGroup") -- "InlineGroup" is also good
    scrollcontainer:SetFullWidth(true)
    scrollcontainer:SetFullHeight(true) -- probably?
    scrollcontainer:SetLayout("Fill") -- important!

    rootFrame:AddChild(scrollcontainer)

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow") -- probably?
    scrollcontainer:AddChild(scroll)

    
    --  add widgets to "scroll"
    -- chat command help
    local commandContainer = AceGUI:Create("InlineGroup")
    commandContainer:SetLayout("List")
    local commandHeader = AceGUI:Create("Label")
    commandHeader:SetFullWidth(true)
    commandHeader:SetFont("Fonts\\MORPHEUS.TTF", 22, "THICKOUTLINE")
    commandHeader:SetColor(195, 0, 0);
    commandHeader:SetText("Chat Commands")
    commandContainer:SetFullWidth(true)

    commandContainer:AddChild(commandHeader)

    for k,v in pairs(GA_HelpStringTable) do
        --print("| k: ",k ,"| v: ", v.text)

        local helpText = AceGUI:Create("Label")
        helpText:SetFontObject("GameFontNormal")

        helpText:SetFullWidth(true)
        helpText:SetText(v.header.." - "..v.text)

        commandContainer:AddChild(helpText)

    end
    scroll:AddChild(commandContainer)

    -- gratulation automatic help
    local gratulationContainer = AceGUI:Create("InlineGroup")
    gratulationContainer:SetFullWidth(true)
    gratulationContainer:SetLayout("Flow")

    local gratulationHeader = AceGUI:Create("Label")
    gratulationHeader:SetPoint("CENTER")
    gratulationHeader:SetFont("Fonts\\MORPHEUS.TTF", 22, "THICKOUTLINE")
    gratulationHeader:SetColor(195, 0, 0);
    gratulationHeader:SetText("Gratulation Automatic")
    gratulationHeader:SetFullWidth(true)
    
    gratulationContainer:AddChild(gratulationHeader)
    for k, v in pairs(GA_HelpGratulation) do
        local helpText = AceGUI:Create("Label")
        helpText:SetFontObject("GameFontNormal")
        helpText:SetFullWidth(true)
        helpText:SetText(v)
        
        gratulationContainer:AddChild(helpText)
    end
    scroll:AddChild(gratulationContainer)

    -- discord automatic help
    local discordContainer = AceGUI:Create("InlineGroup")
    discordContainer:SetFullWidth(true)
    discordContainer:SetLayout("Flow")

    local discordHeader = AceGUI:Create("Label")
    discordHeader:SetFullWidth(true)
    discordHeader:SetPoint("CENTER")
    discordHeader:SetFont("Fonts\\MORPHEUS.TTF", 22, "THICKOUTLINE")
    discordHeader:SetColor(195, 0, 0);
    discordHeader:SetText("Discord/Teamspeak Automatic")

    discordContainer:AddChild(discordHeader)
    for k, v in pairs(GA_HelpDiscord) do
        local helpText = AceGUI:Create("Label")
        helpText:SetFontObject("GameFontNormal")
        helpText:SetFullWidth(true)
        helpText:SetText(v)
        
        discordContainer:AddChild(helpText)
    end
    scroll:AddChild(discordContainer)

    -- dungeon id tracker help
    local trackerContainer = AceGUI:Create("InlineGroup")
    trackerContainer:SetFullWidth(true)
    trackerContainer:SetLayout("Flow")

    local trackerHeader = AceGUI:Create("Label")
    trackerHeader:SetFullWidth(true)
    trackerHeader:SetPoint("CENTER")
    trackerHeader:SetFont("Fonts\\MORPHEUS.TTF", 22, "THICKOUTLINE")
    trackerHeader:SetColor(195, 0, 0);
    trackerHeader:SetText("Dungeon Tracker")

    trackerContainer:AddChild(trackerHeader)
    for k, v in pairs(GA_HelpDiscord) do
        local helpText = AceGUI:Create("Label")
        helpText:SetFontObject("GameFontNormal")
        helpText:SetFullWidth(true)
        helpText:SetText(v)
        
        trackerContainer:AddChild(helpText)
    end
    scroll:AddChild(trackerContainer)



    -- general help
    local generalhelpContainer = AceGUI:Create("InlineGroup")
    generalhelpContainer:SetFullWidth(true)
    generalhelpContainer:SetLayout("Flow")

    local generalhelpHeader = AceGUI:Create("Label")
    generalhelpHeader:SetFullWidth(true)
    generalhelpHeader:SetPoint("CENTER")
    generalhelpHeader:SetFont("Fonts\\MORPHEUS.TTF", 22, "THICKOUTLINE")
    generalhelpHeader:SetColor(195, 0, 0);
    generalhelpHeader:SetText("General Help")

    generalhelpContainer:AddChild(generalhelpHeader)
    for k, v in pairs(GA_HelpCustom) do
        local helpText = AceGUI:Create("Label")
        helpText:SetFontObject("GameFontNormal")
        helpText:SetFullWidth(true)
        helpText:SetText(v)
        
        generalhelpContainer:AddChild(helpText)
    end
    scroll:AddChild(generalhelpContainer)

    --[[

        local i = 1
        repeat
            local container = AceGUI:Create("InlineGroup")
            container:SetFullWidth(true)
            
            
            local headingFrame = AceGUI:Create("Label")
            headingFrame:SetText("Header No. "..tostring(i))
            headingFrame:SetFullWidth(true)
            
            local helpText = AceGUI:Create("Label")
            helpText:SetFontObject("GameFontNormal")
            helpText:SetText(tostring(i).." "..testString)
            helpText:SetFullWidth(true)
            
            container:AddChild(headingFrame)
            container:AddChild(helpText)
            scroll:AddChild(container)
            print("Frame Number "..tostring(i).." created!")
            i = i + 1
        until i == 10
        
    ]]
    return rootFrame
end


function GA_CreateWelcomeFrame()
    local rootFrame = AceGUI:Create("Frame")
    rootFrame:SetTitle("Welcome to GuildAssist3")
    rootFrame:SetStatusText(branding)
    rootFrame:SetWidth(700)
    rootFrame:SetHeight(250)
    rootFrame:SetLayout("Flow")
    rootFrame:SetFullWidth(true)
    rootFrame:SetCallback("OnClose", function (widget) 
        AceGUI:Release(widget)
    end)



    local header = AceGUI:Create("Label")

    header:SetFont("Fonts\\MORPHEUS.TTF", 32, "THICKOUTLINE")
    header:SetColor(195, 0, 0);
    header:SetText("Welcome")
    header:SetFullWidth(true)
    header:SetPoint("CENTER")
    rootFrame:AddChild(header)
    
    
    for k, v in pairs(GA_WelcomeStringTable) do
        local text = AceGUI:Create("Label")
        text:SetFont("Fonts\\ARIALN.TTF", 16, "OUTLINE")
        text:SetColor(255, 205, 0)
        text:SetFullWidth(true)
        text:SetText(v)
        text:SetPoint("CENTER")
        rootFrame:AddChild(text)
    end
    return rootFrame
end


function GA_CreateMenu()
    -- create ui frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("GuildAssist3")
    frame:SetStatusText(branding)
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("Fill")

    -- Create the TabGroup
    local tab =  AceGUI:Create("TabGroup")
    tab:SetLayout("Flow")
    -- Setup which tabs to show
    tab:SetTabs({{text="Gratulation Options", value="tab1"}, {text="Discord Options", value="tab2"}})
    -- Register callback
    tab:SetCallback("OnGroupSelected", SelectGroup)
    -- Set initial Tab (this will fire the OnGroupSelected callback)
    tab:SelectTab("tab1")
    -- add to the frame container
    frame:AddChild(tab)
    --[[
        local editbox = AceGUI:Create("EditBox")
        editbox:SetLabel("Insert text:")
        editbox:SetWidth(200)
        frame:AddChild(editbox)
        
        local button = AceGUI:Create("Button")
        button:SetText("Click Me!")
        button:SetWidth(200)
        frame:AddChild(button)
        ]]


    return frame
end

function GA_CreateInstanceTracker()
    -- base frame
    local uiFrame = CreateFrame("Frame", "GA_CreateInstanceTracker", PVEFrame, "UIPanelDialogTemplate");
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
    uiFrame.title:SetPoint("TOPLEFT", GA_CreateInstanceTrackerDialogBG, "TOPLEFT", 10, 15);
    uiFrame.title:SetText("Guild Assist - Instance Tracker");
    uiFrame.title:SetTextColor(255, 0, 0);

    -- inner Title
    uiFrame.innerTitle = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.innerTitle:SetFontObject("GameFontNormal");
    uiFrame.innerTitle:SetPoint("CENTER", GA_CreateInstanceTrackerDialogBG, "CENTER", 0, 35);
    uiFrame.innerTitle:SetText("Your free mythic instance are:");
    -- DUNGEON STRINGS
    -- de other side
    uiFrame.otherSide = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.otherSide:SetFontObject("GameFontHighlight");
    uiFrame.otherSide:SetPoint("TOPLEFT", GA_CreateInstanceTrackerDialogBG, "TOPLEFT", 15, -20);
    -- halls of atonement
    uiFrame.hallsOfAtonement = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.hallsOfAtonement:SetFontObject("GameFontHighlight");
    uiFrame.hallsOfAtonement:SetPoint("TOPLEFT", GA_CreateInstanceTrackerDialogBG, "TOPLEFT", 15, -35);
    --	Mists of Tirna Scithe
    uiFrame.mistOfTirneScithe = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.mistOfTirneScithe:SetFontObject("GameFontHighlight");
    uiFrame.mistOfTirneScithe:SetPoint("TOPLEFT", GA_CreateInstanceTrackerDialogBG, "TOPLEFT", 15, -50);

    uiFrame.plaguefall = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.plaguefall:SetFontObject("GameFontHighlight");
    uiFrame.plaguefall:SetPoint("TOPLEFT", GA_CreateInstanceTrackerDialogBG, "TOPLEFT", 15, -65);

    uiFrame.sanguineDepths = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.sanguineDepths:SetFontObject("GameFontHighlight");
    uiFrame.sanguineDepths:SetPoint("TOPRIGHT", GA_CreateInstanceTrackerDialogBG, "TOPRIGHT", -15, -20);

    uiFrame.spiresOfAscension = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.spiresOfAscension:SetFontObject("GameFontHighlight");
    uiFrame.spiresOfAscension:SetPoint("TOPRIGHT", GA_CreateInstanceTrackerDialogBG, "TOPRIGHT", -15, -35);

    uiFrame.theNecroticWake = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.theNecroticWake:SetFontObject("GameFontHighlight");
    uiFrame.theNecroticWake:SetPoint("TOPRIGHT", GA_CreateInstanceTrackerDialogBG, "TOPRIGHT", -15, -50);

    uiFrame.theaterOfPain = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.theaterOfPain:SetFontObject("GameFontHighlight");
    uiFrame.theaterOfPain:SetPoint("TOPRIGHT", GA_CreateInstanceTrackerDialogBG, "TOPRIGHT", -15, -65);

    uiFrame.tazavesh = uiFrame:CreateFontString(nil, "OVERLAY");
    uiFrame.tazavesh:SetFontObject("GameFontHighlight");
    uiFrame.tazavesh:SetPoint("TOP", GA_CreateInstanceTrackerDialogBG, "TOP", 0, -78);


    uiFrame.otherSide:SetText(DungeonNamesDE[5]);
    uiFrame.hallsOfAtonement:SetText(DungeonNamesDE[3]);
    uiFrame.mistOfTirneScithe:SetText(DungeonNamesDE[1]);
    uiFrame.plaguefall:SetText(DungeonNamesDE[4]);
    uiFrame.sanguineDepths:SetText(DungeonNamesDE[7]);
    uiFrame.spiresOfAscension:SetText(DungeonNamesDE[6]);
    uiFrame.theNecroticWake:SetText(DungeonNamesDE[2]);
    uiFrame.theaterOfPain:SetText(DungeonNamesDE[8]);
    uiFrame.tazavesh:SetText(DungeonNamesDE[9]);
    uiFrame.mistOfTirneScithe:SetTextColor(0, 155, 0);
    uiFrame.theNecroticWake:SetTextColor(0, 155, 0);
    uiFrame.hallsOfAtonement:SetTextColor(0, 155, 0);
    uiFrame.theaterOfPain:SetTextColor(0, 155, 0);
    uiFrame.plaguefall:SetTextColor(0, 155, 0);
    uiFrame.tazavesh:SetTextColor(0, 155, 0);
    uiFrame.sanguineDepths:SetTextColor(0, 155, 0);
    uiFrame.otherSide:SetTextColor(0, 155, 0);
    uiFrame.mistOfTirneScithe:SetTextColor(0, 155, 0);
    uiFrame.spiresOfAscension:SetTextColor(0, 155, 0);

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
