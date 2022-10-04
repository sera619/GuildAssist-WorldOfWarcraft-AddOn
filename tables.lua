local _, GuildAssist = ...;

_G.GA_HelpStringTable = {
    help2 = {
        header = "/fs",
        text = "A simple and faster wrapper command for the buildin \"/framestack\" command."
    },
    help3 = {
        header = "/ga help",
        text = "Shows/Hide the GuildAssist Addon Helpframe."
    },
    help4 = {
        header = "/ga tracker",
        text = "Shows/Hide the GuildAssist Mythic Dungeon ID Tracker."
    },
    help5 = {
        header = "/ga config",
        text = "Shows/Hide the GuildAssist Addon optionsmenu."
    },
    help6 = {
        header = "/rl",
        text = "A simple and faster wrapper command for the buildin \"/reload\" command."
    },
    help7 = {
        header = "/ga",
        text = "Shows/Hide the GuildAssist Addon Menu Panel"
    },
}

_G.GA_Patchnotes = {
    n1 ="- fix error when toggle \"Send Whispermessage\"",
    n2 ="- add Option to set multiple gratulation messages",
    n3 ="- Add Option to toggle send random whispermessage to player your have invited",
    n4= "- Adjust Gratulation-Setting Interface",
    n5 = "- Add colors to chatinformation output for player",
    n6 = "- Add Frame to show up saved Gratulationmessages",
    n7 = "- add errorhandling for nil values in database",
    n8 = "- add new preview screenshot",
    --n9 = "- Add helperfunctions for \"EventCalendar\"",
}
_G.GA_HelpGratulation = {
    help2 = "This feature will send automaticly a gratulation message if a guildmember earn a achievment.",
    help3 = "To use the automatic Gratulation feature just enter your gratulation message into the Textbox and check the \"Send automatic Gratulation\" chechbox.",
    help4 = "If you want to use some the ASCii Textbanner just check the \"Send ASCii Truck\" or \"Send ASCii Heart\". Notice that only one of them can be active on the same time and your custom message would NOT be sended.",
    help5 = "It is also possibel to adjust the time in seconds to wait before sending gratulation into guildchatchannel. Just set the slider to the time you want, minimum required 1 second, maximum possible 10 seconds.",
    help6 = "If you want to see a preview of your gratulation message, just do your settings and click the \"Send Test Gratulation\" button, the addon will send the message in the chatframe but NOT in a chatchannel."
}
_G.GA_HelpDiscord = {
    help1 = "If you want to send your discord/teamspeak invitationlink/serverid automaticly to the guildchatchannel if a guildmember enter \"!discord\" in the guildchat, just enter your invitationlink/serverip in the textbox and enable the checkbox",
    help2 = "Like for the autogratulation you can also adjust the time to wait before sending your invitationlink/serverip to the guildchatchannel.",
    help4 = "If you want to see a preview of your invitationlink/serverip, just do your settings and click the \"Send Test Discord\" button, the addon will send the message in the chatframe but NOT in a chatchannel."
}

_G.GA_HelpTracker ={
    help2 = "The dungeontracker will keep track your dungeon ids for all mythic dungoens(not mythic plus!). The tracker will appear if you open the LFG window.",
    help3 = "Simple as it is, green dungeons have a free loot id and red havent."
}

_G.GA_HelpCustom ={
    help2 = "If you facing any bug oder have some other trouble with the addon also if you have any suggestion, please DONT BE SHY and contact me instantly, i will not bite!",
    help3 = "Any constructive feedback are welcome! This helps me to make the addon comfortable. THANK YOU!"
}

_G.GA_HelpInvite = {
    help2 = "The Auto-Invite Plugin will invite player they whisper you with the keyword automaticly in your group.",
    help3 = "To use enter a keyword in the optionsmenu and check the Auto-Invite Toggle checkbox. You can also adjust the maximum group size before the Addon stops invite player.",
    help4 = "If you want you can set a announcement message that would be sended to notice your guild when you enable/disable the auto-invite.",
    help5 = "You can choose between multiple group sizes and as limitation only guildmembers of your guild would be invited, more options are planned.",
    help6 = "Set the Whispermessage to whisper a player that your addon invite in your party/raid."
}
_G.GA_WelcomeStringTable ={
    welcome2 = "Hello and welcome to GuildAssist3! |nThis is my very first World of Warcraft Addon that I code at all. So dont be that hard to me!",
    welcome3 = "This Addon currently havent much features but in future it is planned to be a interactive raid/dungeon calender with discordbot synchronization.",
    welcome4 = "|nFor this it also exist a Discord Bot that is coded by my own too. |nThis is a very early Version at all if you facing any bugs or some other trouble.",
    welcome5 = "Please contact me \"TrickOnFlick#2943\" on Battle.net, Thank you!",
    welcome6 = "|n|cffaa0000Please check the Interface Options Menu to setup GuildAssist3.|r"
}

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
    "Halls of Atonement",
    "Theater of Pain",
    "Plaguefall",
    "De Other Side",
    "Spires of Ascension",
    "Sanguine Depths",
    "Tazavesh the Veiled Market",
}