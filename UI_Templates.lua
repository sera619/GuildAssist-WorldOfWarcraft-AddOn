local _ , GuildAssist = ...;
local AceGUI = LibStub("AceGUI-3.0")

local headFont = "Fonts\\MORPHEUS.TTF"

local function CreateCalenderDayButton(headText, maintext)
    local frame = AceGUI:Create("InlineGroup")
    frame:SetHeight(250)
    frame:SetWidth(150)
    frame:SetLayout("List")

    local head = AceGUI:Create("Heading")
    head:SetFullWidth(true)
    head:SetFullHeight(true)
    head:SetText(headText)

    local text = AceGUI:Create("Label")
    text:SetFullWidth(true)
    text:SetFullHeight(true)
    text:SetJustifyH("CENTER")
    text:SetText(maintext)

    local button = AceGUI:Create("Button")
    button:SetHeight(20)
    button:SetWidth(75)
    button:SetPoint("CENTER")
    button:SetText("Show")
    

    frame:AddChild(head)
    frame:AddChild(text)
    frame:AddChild(button)
    return frame
end

function GA_CreateCalender()
    --- root frame 
    local rootFrame = AceGUI:Create("Window")
    rootFrame:SetTitle("GuildAssist - Eventcalendar")
    rootFrame:SetHeight(700)
    rootFrame:SetWidth(1000)
    rootFrame:SetLayout("Flow")

    -- head text
    local calendarHeader = AceGUI:Create("Label")
    calendarHeader:SetFont(headFont, 34, "THINOUTLINE")
    calendarHeader:SetFullWidth(true)
    calendarHeader:SetJustifyH("CENTER")
    calendarHeader:SetText("Event Calender")
    -- add headder    
    
    -- calendar day container
    local dayContainer = AceGUI:Create("SimpleGroup")
    dayContainer:SetLayout("Flow")
    dayContainer:SetFullWidth(true)
    dayContainer:SetFullHeight(true)
    dayContainer:AddChild(calendarHeader)

    
    local i = 1
    repeat
        local dayFrame = CreateCalenderDayButton("Tag "..tostring(i), "Text nummer: "..tostring(i))
        
        dayContainer:AddChild(dayFrame)
        i = i + 1
    until i == 32
    
    
    rootFrame:AddChild(dayContainer)

    return rootFrame
end
