local _ , GuildAssist = ...;
local GA = GuildAssist

local AceGUI = LibStub("AceGUI-3.0")

local headFont = "Fonts\\MORPHEUS.TTF"

local DaysPerMonth = { 
    [1] = 31, -- januar
    [2] = 28, -- feb
    [3]  = 31, -- mär
    [4]  = 30, -- apr
    [5]  = 31, -- mai
    [6]  = 30,-- juni
    [7]  = 31, -- juli
    [8]  = 31, -- august
    [9]  = 30, -- september
    [10]  = 31, -- oktober
    [11]  = 30, -- november
    [12]  = 31, -- december
}


local MonthStartDayname = {

}

local function CreateCalenderDayButton(headText, maintext)
    local frame = AceGUI:Create("InlineGroup")
    frame:SetWidth(150)
    frame:SetHeight(600)
    frame:SetLayout("List")


    
    local head = AceGUI:Create("Heading")
    head:SetFullWidth(true)
    head:SetText(headText)

    local text = AceGUI:Create("Label")
    text:SetFullWidth(true)
    --text:SetFullHeight(true)
    text:SetJustifyH("CENTER")
    text:SetText(maintext)

    local eventText = AceGUI:Create("Label")
    eventText:SetFullWidth(true)
    eventText:SetText("FirstEvent|nSecondevent")

    local button = AceGUI:Create("Button")
    --button:SetFullWidth(true)
    button:SetPoint("CENTER")
    button:SetWidth(75)
    button:SetText("Show")

    frame:AddChild(head)
    frame:AddChild(text)
    frame:AddChild(eventText)
    frame:AddChild(button)
    return frame
end

function GA_CreateCalender()
    --- root frame 
    local rootFrame = AceGUI:Create("Window")
    rootFrame:SetTitle("GuildAssist - Eventcalendar")
    rootFrame:SetHeight(700)
    rootFrame:SetWidth(1200)
    rootFrame:SetLayout("Flow")
    rootFrame:EnableResize(false)

    -- head text
    local calendarHeader = AceGUI:Create("Label")
    calendarHeader:SetFont(headFont, 34, "THINOUTLINE")
    calendarHeader:SetFullWidth(true)
    calendarHeader:SetJustifyH("CENTER")
    calendarHeader:SetText("Event Calender")
    
    -- calendar day container
    local dayContainer = AceGUI:Create("InlineGroup")
    dayContainer:SetLayout("Flow")
    dayContainer:SetFullWidth(true)
    -- dayContainer:SetHeight(650)
    dayContainer:SetFullHeight(true)
    -- dayContainer:SetWidth(950)
    -- add headder    
    --dayContainer:AddChild(calendarHeader)
    rootFrame:AddChild(calendarHeader)
    rootFrame:AddChild(dayContainer)
    local date = date("%d/%m/%y %H:%M:%S")
    local mytime = C_DateAndTime.GetCurrentCalendarTime()
    local todayDayName = CALENDAR_WEEKDAY_NAMES[mytime.weekday]
    local currMonthInfo = C_Calendar.GetMonthInfo(mytime.month)
    local firstdayOfMont = CALENDAR_WEEKDAY_NAMES[currMonthInfo.firstWeekday]
    
    -- create view for month
    local currMonth = CALENDAR_FULLDATE_MONTH_NAMES[currMonthInfo.month + 2]
    local i = 1
    local f = 7
    repeat
        local dayFrame = CreateCalenderDayButton(CALENDAR_WEEKDAY_NAMES[f] , tostring(i)..". ".. currMonth.." .".. tostring(mytime.year))
        
        f = f + 1
        if f >= 8 then
            f = 1
        end
        dayContainer:AddChild(dayFrame)
        i = i + 1
    until i ==  DaysPerMonth[mytime.month] + 1


    return rootFrame
end

