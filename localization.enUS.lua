ShadowUFLocals = {
	-- Errors
	["Invalid tag used %s."] = "Invalid tag used %s.",
	["Cannot register layout %s, string or table expected for data got %s."] = "Cannot register layout %s, string or table expected for data got %s.",
	["Cannot register layout, no name passed."] = "Cannot register layout, no name passed.",
	["Cannot register tag, no name passed."] = "Cannot register tag, no name passed.",
	["Cannot register tag %s, string expected got %s."] = "Cannot register tag %s, string expected got %s.",
	["Cannot register layout, configuration should be a table got %s."] = "Cannot register layout, configuration should be a table got %s.",
	["Cannot register tag, data should be passed as {help = \"help text\", events = \"EVENT_A EVENT_B\", funct = \"function(unit) return \"Foo\" end}"] = "Cannot register tag, data should be passed as {help = \"help text\", events = \"EVENT_A EVENT_B\", funct = \"function(unit) return \"Foo\" end}",
	
	-- Layout text
	["Left text"] = "Left text",
	["Right text"] = "Right text",
	["Middle text"] = "Middle text",
	
	-- Tag text
	["Dead"] = "Dead",
	["Aggro"] = "Aggro",
	["Offline"] = "Offline",
	["Male"] = "Male",
	["Female"] = "female",
	["Rare"] = "Rare",
	["Ghost"] = "Ghost",
	["Elite"] = "Elite",
	["Rare Elite"] = "Rare Elite",
	["Boss"] = "Boss",
	["(AFK)"] = "(AFK)",
	["(DND)"] = "(DND)",
	
	-- GUI
	["Tags"] = "Tags",
	["Layout"] = "Layout",
	["Layouts"] = "Layouts",
	["Units"] = "Units",
	["Error"] = "Error",
	["General"] = "General",
	["Search tag"] = "Search tag",
	["Screen"] = "Screen",
	["Party member"] = "Party member",
	["Bar texture"] = "Bar texture",
	
	-- Help
	["Help"] = "Help",
	["Select the units that you want to modify, any settings changed will change every unit you selected. If you want to anchor or change raid/party unit specific settings you will need to do that through their options.\n\nShift click a unit to select all/unselect all."] = "Select the units that you want to modify, any settings changed will change every unit you selected. If you want to anchor or change raid/party unit specific settings you will need to do that through their options.\n\nShift click a unit to select all/unselect all.",
	["In this category you can configure all of the enabled units, both what features to enable as well as tweaking the layout. Advanced settings in the general category if you want to be able to get finer control on setting options, but it's not recommended for most people.\n\nHere's what each tab does\n\nGeneral - General settings, portrait settings, combat text, anything that doesn't fit the other categories.\n\nFrame - Frame settings, scale, height, width. You can set the frame to be anchored to another here.\n\nBars - Enabling bars (health/cast/etc) as well as setting how the health bar can be colored.\n\nWidget size - Widget sizing, ordering, height.\n\nAuras - What filters to use, where to place auras.\n\nText (Advanced only) - Allows changing how the text anchors and the offset, you can set tags here as well.\n\nTag Wizard - Quickly add and remove tags to text."] = "In this category you can configure all of the enabled units, both what features to enable as well as tweaking the layout. Advanced settings in the general category if you want to be able to get finer control on setting options, but it's not recommended for most people.\n\nHere's what each tab does\n\nGeneral - General settings, portrait settings, combat text, anything that doesn't fit the other categories.\n\nFrame - Frame settings, scale, height, width. You can set the frame to be anchored to another here.\n\nBars - Enabling bars (health/cast/etc) as well as setting how the health bar can be colored.\n\nWidget size - Widget sizing, ordering, height.\n\nAuras - What filters to use, where to place auras.\n\nText (Advanced only) - Allows changing how the text anchors and the offset, you can set tags here as well.\n\nTag Wizard - Quickly add and remove tags to text.",
	
	-- Layout
	["|cffffffffActive:|r "] = "|cffffffffActive:|r ",
	["%s%s by %s"] = "%s%s by %s",
	["Activate"] = "Activate",
	["Export"] = "Export",
	["Delete"] = "Delete",
	["By activating this layout, all of your positioning, sizing and so on settings will be reset to load this layout, are you sure you want to activate this?"] = "By activating this layout, all of your positioning, sizing and so on settings will be reset to load this layout, are you sure you want to activate this?",
	["Exporting %s"] = "Exporting %s",
	["You can now give the string below to other Shadowed Unit Frames users, they can then import it through the import tab to use this layout."] = "You can now give the string below to other Shadowed Unit Frames users, they can then import it through the import tab to use this layout.",
	["Create"] = "Create",
	["Create a new layout using your current layout as a template. You must fill out all of the fields before you can create it."] = "Create a new layout using your current layout as a template. You must fill out all of the fields before you can create it.",
	["Layout name"] = "Layout name",
	["Author"] = "Author",
	["Description"] = "Description",
	["Are you sure you want to delete this layout?"] = "Are you sure you want to delete this layout?",
	["Importing"] = "Importing",
	["Data"] = "Data",
	["Import a new layout using the layout data string another user gave you."] = "Import a new layout using the layout data string another user gave you.",
	["Failed to import layout:\n\n%s"] = "Failed to import layout:\n\n%s",
	["No layout data entered."] = "No layout data entered.",
	["Layout information fields are not all set, make sure that id, name, description and author was included."] = "Layout information fields are not all set, make sure that id, name, description and author was included.",
	["You already have a layout named %s, delete it first if you want to reimport it."] = "You already have a layout named %s, delete it first if you want to reimport it.",
	
	-- Positions
	["Up"] = "Up",
	["Center"] = "Center",
	["Down"] = "Down",
	["Right Top"] = "Right Top",
	["Right Center"] = "Right Center",
	["Right Bottom"] = "Right Bottom",
	["Left Top"] = "Left Top",
	["Left Center"] = "Left Center",
	["Left Bottom"] = "Left Bottom",
	["Bottom Left"] = "Bottom Left",
	["Bottom Center"] = "Bottom Center",
	["Bottom Right"] = "Bottom Right",
	["Inside Center Left"] = "Inside Center Left",
	["Inside Center"] = "Inside Center",
	["Inside Center Right"] = "Inside Center Right",
	["Top Right"] = "Top Right",
	["Top Center"] = "Top Center",
	["Top Left"] = "Top Left",
	["Inside Top Right"] = "Inside Top Right",
	["Inside Top Left"] = "Inside Top Left",

	["Inside"] = "Inside",
	["Bottom"] = "Bottom",
	["Top"] = "Top",
	["Left"] = "Left",
	["Right"] = "Right",
	
	-- Hiding
	["Hide Blizzard"] = "Hide Blizzard",
	["Hide %s"] = "Hide %s",
	["Cast bars"] = "Cast bars",
	["You must do a /console reloadui for an object to show up again."] = "You must do a /console reloadui for an object to show up again.",

	-- Units
	["Full size"] = "Full size",
	["Ignores the portrait and uses the entire frames width, the bar will be drawn either above or below the portrait depending on the order."] = "Ignores the portrait and uses the entire frames width, the bar will be drawn either above or below the portrait depending on the order.",
	["Management"] = "Management",
	["Import"] = "Import",
	["Export"] = "Export",
	["Global"] = "Global",
	["global"] = "Global",
	["Order to use for the portrait, this only applies if you have a full sized bar."] = "Order to use for the portrait, this only applies if you have a full sized bar.",
	["Modify settings"] = "Modify settings",
	["Units to modify"] = "Units to modify",
	["Adds %s to the list of units to be modified when you change values in this tab."] = "Adds %s to the list of units to be modified when you change values in this tab.",
	["Bars"] = "Bars",
	["Color health by"] = "Color health by",
	["Reaction"] = "Reaction",
	["Class"] = "Class",
	["Static"] = "Static",
	["Health percent"] = "Health percent",
	["Color on aggro"] = "Color on aggro",
	["Threat"] = "Threat",
	["Enable %s"] = "Enable %s",
	["How many auras to show in a single row."] = "How many auras to show in a single row.",
	["Per row"] = "Per row",
	["Max rows"] = "Max rows",
	["Rows"] = "Rows",
	["How many rows total should be used, rows will be however long the per row value is set at."] = "How many rows total should be used, rows will be however long the per row value is set at.",
	["How many auras per a column for example, entering two her will create two rows that are filled up to whatever per row is set as."] = "How many auras per a column for example, entering two her will create two rows that are filled up to whatever per row is set as.",
	["Enlarge your auras"] = "Enlarge your auras",
	["If you casted the aura, then the buff icon will be increased in size to make it more visible."] = "If you casted the aura, then the buff icon will be increased in size to make it more visible.",
	["Anchor to"] = "Anchor to",
	["How you want this aura to be anchored to the unit frame."] = "How you want this aura to be anchored to the unit frame.",
	["X Offset"] = "X Offset",
	["Y Offset"] = "Y Offset",
	["Buffs"] = "Buffs",
	["Debuffs"] = "Debuffs",
	["Filters"] = "Filters",
	["Auras"] = "Auras",
	["Position"] = "Position",
	["XP/Reputation bar"] = "XP/Reputation bar",
	["This bar will automatically hide when you are at the level cap, or you do not have any reputations tracked."] = "This bar will automatically hide when you are at the level cap, or you do not have any reputations tracked.",
	["Anchor point"] = "Anchor point",
	["Where to anchor the cast time text."] = "Where to anchor the cast time text.",
	["Where to anchor the cast name text."] = "Where to anchor the cast name text.",
	["Cast time"] = "Cast time",
	["Cast name"] = "Cast name",
	["General bars"] = "General bars",
	["Height"] = "Height",
	["Width"] = "Width",
	["Buff icons"] = "Buff icons",
	["Scale"] = "Scale",
	["Portrait type"] = "Portrait type",
	["3D"] = "3D",
	["2D"] = "2D",
	["Text"] = "Text",
	["Tag wizard"] = "Tag wizard",
	["Show your auras only"] = "Show your auras only",
	["Filter out any auras that you did not cast yourself."] = "Filter out any auras that you did not cast yourself.",
	["Show curable only"] = "Show curable only",
	["Filter out any aura that you cannot cure."] = "Filter out any aura that you cannot cure.",
	["Show castable on other auras only"] = "Show castable on other auras only",
	["Filter out any auras that you cannot cast on another player, or yourself."] = "Filter out any auras that you cannot cast on another player, or yourself.",
	["Enable buffs"] = "Enable buffs",
	["Enable debuffs"] = "Enable debuffs",
	["Show player in frame"] = "Show player in frame",
	["How the frame should grow when new group members are added."] = "How the frame should grow when new group members are added.",
	["How the columns should grow when too many people are shown in a single group."] = "How the columns should grow when too many people are shown in a single group.",
	["Percentage of the frames width that this text should use."] = "Percentage of the frames width that this text should use.",
	["Group number"] = "Group number",
	["Group by"] = "Group by",
	["Sort order"] = "Sort order",
	["Max columns"] = "Max columns",
	["Units per column"] = "Units per column",
	["Column spacing"] = "Column spacing",
	["Column growth"] = "Column growth",
	["Frame growth"] = "Frame growth",
	["Groups"] = "Groups",
	["Timers for self auras only"] = "Timers for self auras only",
	["Hides the cooldown ring for any auras that you did not cast."] = "Hides the cooldown ring for any auras that you did not cast.",
	["Filter out irrelevant debuffs"] = "Filter out irrelevant debuffs",
	["Automatically filters out debuffs that you don't care about, if you're a magic class you won't see Rend/Deep Wounds, physical classes won't see Curse of the Elements and so on."] = "Automatically filters out debuffs that you don't care about, if you're a magic class you won't see Rend/Deep Wounds, physical classes won't see Curse of the Elements and so on.",
	["Combat alpha"] = "Combat alpha",
	["Alpha to use when you are in combat for this unit."] = "Alpha to use when you are in combat for this unit.",
	["Inactive alpha"] = "Inactive alpha",
	["Ascending"] = "Ascending",
	["Descending"] = "Descending",
	["Alpha to use when the unit is inactive meaning, not in combat, have no target and mana is at 100%."] = "Alpha to use when the unit is inactive meaning, not in combat, have no target and mana is at 100%.",
	["Growth"] = "Growth",
	["Spacing"] = "Spacing",
	["Prioritize buffs"] = "Prioritize buffs",
	["Show buffs before debuffs when sharing the same anchor point."] = "Show buffs before debuffs when sharing the same anchor point.",
	["Color by reaction"] = "Color by reaction",
	["If the unit is hostile, the reaction color will override any color health by options."] = "If the unit is hostile, the reaction color will override any color health by options.",
	["When showing incoming heals, include your heals in the total incoming."] = "When showing incoming heals, include your heals in the total incoming.",
	["Offsets are saved using effective scaling, this is to prevent the frame from jumping around when you reload or login."] = "Offsets are saved using effective scaling, this is to prevent the frame from jumping around when you reload or login.",
	["Per column"] = "Per column",
	["Raid groups to show"] = "Raid groups to show",
	["Group %d"] = "Group %d",
	
	-- Layout
	["Layout"] = "Layout",
	["Point"] = "Point",
	["Relative point"] = "Relative point",
	["How much of the frames total height this bar should get, this is a weighted value, the higher it is the more it gets."] = "How much of the frames total height this bar should get, this is a weighted value, the higher it is the more it gets.",
	["Anchor"] = "Anchor",
	["%s frames"] = "%s frames",
	["Offset"] = "Offset",
	["Manual position"] = "Manual position",
	["Anchor to another frame"] = "Anchor to another frame",
	["Or you can set a position manually"] = "Or you can set a position manually",
	["Widget size"] = "Widget size",
	["Width percent"] = "Width percent",
	["Percentage of width the portrait should use."] = "Percentage of width the portrait should use.",
	["Order"] = "Order",
	["Show background"] = "Show background",
	["Show a background behind the bars with the same texture/color but faded out."] = "Show a background behind the bars with the same texture/color but faded out.",
	["Alignment"] = "Alignment",
	["Show background"] = "Show background",
	
	-- General
	["Lock frames"] = "Lock frames",
	["Advanced"] = "Advanced",
	["Enabling advanced settings will allow you to further tweak settings. This is meant for people who want to tweak every single thing, and should not be enabled by default as it increases the options."] = "Enabling advanced settings will allow you to further tweak settings. This is meant for people who want to tweak every single thing, and should not be enabled by default as it increases the options.",
	["Edge size"] = "Edge size",
	["How large the edges should be."] = "How large the edges should be.",
	["Tile size"] = "Tile size",
	["How large the background should tile"] = "How large the background should tile",
	["Inset"] = "Inset",
	["How far into the frame the background will be shown"] = "How far into the frame the background will be shown",
	
	["Tag management"] = "Tag management",
	["Profiles"] = "Profiles",
	["Enable units"] = "Enable units",
	["Bar colors"] = "Bar colors",
	["Class colors"] = "Class colors",
	["Power bar"] = "Power bar",
	["Mana"] = "Mana",
	["Rage"] = "Rage",
	["Focus"] = "Focus",
	["Energy"] = "Energy",
	["Happiness"] = "Happiness",
	["Runes"] = "Runes",
	["Runic Power"] = "Runic Power",
	["Health bar"] = "Health bar",
	["Color"] = "Color",
	["Standard health bar color"] = "Standard health bar color",
	["Color to use when a mob is tapped by someone besides yourself or your group."] = "Color to use when a mob is tapped by someone besides yourself or your group.",
	["Background/border"] = "Background/border",
	["Font"] = "Font",
	["Size"] = "Size",
	["Background"] = "Background",
	["Border"] = "Border",
	["Border color"] = "Border color",
	["Background color"] = "Background color",
	["Tapped"] = "Tapped",
	["Tapped color"] = "Tapped color",
	["Health color"] = "Health color",
	["Incoming heal"] = "Incoming heal",
	["Health bar color to use to show how much healing someone is about to receive."] = "Health bar color to use to show how much healing someone is about to receive.",
	["None"] = "None",
	["Clip"] = "Clip",
	["How close the frame should clip with the border."] = "How close the frame should clip with the border.",
	["Extra"] = "Extra",
	["Aura size, this is the starting size they will resize once a row is filled up."] = "Aura size, this is the starting size they will resize once a row is filled up.",
	["Enable indicator"] = "Enable indicator",
	["Show your heals"] = "Show your heals",
	["Red health"] = "Red health",
	["Health bar color to use when health bars are showing red, hostile units, transitional color from green -> red and so on."] = "Health bar color to use when health bars are showing red, hostile units, transitional color from green -> red and so on.",
	["Yellow health"] = "Yellow health",
	["Health bar color to use when health bars are showing yellow, neutral units."] = "Health bar color to use when health bars are showing yellow, neutral units.",
	["Unattackable health"] = "Unattackable health",
	["Health bar color to use for hostile units who you cannot attack, used for reaction coloring."] = "Health bar color to use for hostile units who you cannot attack, used for reaction coloring.",
	["In range alpha"] = "In range alpha",
	["Out of range alpha"] = "Out of range alpha",
	["Fades out units who you are not in range of, this only works on people who are in your group."] = "Fades out units who you are not in range of, this only works on people who are in your group.",
	
	
	-- Tags
	["Events"] = "Events",
	["Edit"] = "Edit",
	["Events that should be used to trigger an update of this tag. Separate each event with a single space."] = "Events that should be used to trigger an update of this tag. Separate each event with a single space.",
	["You have to set the events to fire, you can only enter letters and underscores, \"FOO_BAR\" for example is valid, \"APPLE_5_ORANGE\" is not because it contains a number."] = "You have to set the events to fire, you can only enter letters and underscores, \"FOO_BAR\" for example is valid, \"APPLE_5_ORANGE\" is not because it contains a number.",
	["Add new tag"] = "Add new tag",
	["Editing %s"] = "Editing %s",
	["Edit tag"] = "Edit tag",
	["Tag list"] = "Tag list",
	["Tags"] = "Tags",
	["Tag name"] = "Tag name",
	["Tag that you will use to access this code, do not wrap it in brackets or parenthesis it's automatically done. For example, you would enter \"foobar\" and then access it with [foobar]."] = "Tag that you will use to access this code, do not wrap it in brackets or parenthesis it's automatically done. For example, you would enter \"foobar\" and then access it with [foobar].",
	["Help text"] = "Help text",
	["Help text to show that describes what this tag does."] = "Help text to show that describes what this tag does.",
	["Tag function"] = "Tag function",
	["Code"] = "Code",
	["Your code must be wrapped in a function, for example, if you were to make a tag to return the units name you would do:\n\nfunction(unit)\nreturn UnitName(unit)\nend"] = "Your code must be wrapped in a function, for example, if you were to make a tag to return the units name you would do:\n\nfunction(unit)\nreturn UnitName(unit)\nend",
	["You must wrap your code in a function."] = "You must wrap your code in a function.",
	["You cannot name a tag \"%s\", tag names should contain no brackets or parenthesis."] = "You cannot name a tag \"%s\", tag names should contain no brackets or parenthesis.",
	["The tag \"%s\" already exists."] = "The tag \"%s\" already exists.",
	["You must enter a tag name."] = "You must enter a tag name.",
	["Failed to save tag, error:\n %s"] = "Failed to save tag, error:\n %s",
	["Are you really sure you want to delete this tag?"] = "Are you really sure you want to delete this tag?",
	["You cannot edit this tag because it is one of the default ones included in this mod. This function is here to provide an example for your own custom tags."] = "You cannot edit this tag because it is one of the default ones included in this mod. This function is here to provide an example for your own custom tags.",
	["Delete"] = "Delete",
	["This tag is included by default and cannot be deleted."] = "This tag is included by default and cannot be deleted.",
	["Search"] = "Search",
	["Search tags"] = "Search tags",
	["Frame"] = "Frame",
	["Hide in raid"] = "Hide in raid",
	["Party frames are hidden while in a raid group with more than 5 people inside."] = "Party frames are hidden while in a raid group with more than 5 people inside.",
	
	-- Visibility
	["Visibility"] = "Visibility",
	["Enable %s frames"] = "Enable %s frames",
	["You can set different units to be enabled or disabled in different areas here.\nGold checked are enabled, Gray checked are disabled, Unchecked are ignored and use the current set value no matter the zone."] = "You can set different units to be enabled or disabled in different areas here.\nGold checked are enabled, Gray checked are disabled, Unchecked are ignored and use the current set value no matter the zone.",
	["Enabled in %s"] = "Enabled in %s",
	["Disabled in %s"] = "Disabled in %s",
	["Using unit settings"] = "Using unit settings",
	
	-- Indicators
	["indicators"] = {
		["status"] = "Status",
		["pvp"] = "PvP Flag",
		["leader"] = "Leader",
		["masterLoot"] = "Master looter",
		["raidTarget"] = "Raid target",
		["happiness"] = "Happiness",
	},
	
	["classes"] = {
		["HUNTER"] = "Hunter",
		["WARLOCK"] = "Warlock",
		["PRIEST"] = "Priest",
		["PALADIN"] = "Paladin",
		["MAGE"] = "Mage",
		["ROGUE"] = "Rogue",
		["DRUID"] = "Druid",
		["SHAMAN"] = "Shaman",
		["WARRIOR"] = "Warrior",
		["DEATHKNIGHT"] = "Death Knight",
		["PET"] = "Pet",
	},
	
	-- Instance types
	["areas"] = {
		["pvp"] = "Battlegrounds",
		["arena"] = "Arenas",
		["party"] = "Party instances",
		["raid"] = "Raid instances",
	},
	
	-- Unit names
	["units"] = {
		["player"] = "Player",
		["pet"] = "Pet",
		["target"] = "Target",
		["targettarget"] = "Target of Target",
		["targettargettarget"] = "Target of Target of Target",
		["focus"] = "Focus",
		["focustarget"] = "Focus target",
		["party"] = "Party",
		["partypet"] = "Party pet",
		["partytarget"] = "Party targets",
		["raid"] = "Raid",
	},
		
	-- Module names
	["Combat fader"] = "Combat fader",
	["Totems"] = "Totems",
	["Rune bar"] = "Rune bar",
	["Health bar"] = "Health bar",
	["Cast bar"] = "Cast bar",
	["XP/Rep bar"] = "XP/Rep bar",
	["Auras"] = "Auras",
	["Indicators"] = "Indicators",
	["Portrait"] = "Portrait",
	["Power bar"] = "Power bar",
	["Combat text"] = "Combat text",
	["Rune bar"] = "Rune bar",
	["Totem bar"] = "Totem bar",
	["Combo points"] = "Combo points",
	["Incoming heals"] = "Incoming heals",
	["Range indicator"] = "Range indicator",
	
	-- Tag help
	["Closes a color code, pretends colors from showing up on text that you do not want it to."] = "Closes a color code, pretends colors from showing up on text that you do not want it to.",
	["Shows the current group number of the unit."] = "Shows the current group number of the unit.",
	["Reaction color code, use [reactcolor][name][close] to color the units name by their reaction."] = "Reaction color code, use [reactcolor][name][close] to color the units name by their reaction.",
	["Class name, use [classcolor][class][close] if you want a colored class name."] = "Class name, use [classcolor][class][close] if you want a colored class name.",
	["Color code for the class, use [classcolor][class][close] if you want the class text to be colored by class"] = "Color code for the class, use [classcolor][class][close] if you want the class text to be colored by class",
	["Absolute maximum health value without any formating so 15000 is still shown as 15000."] = "Absolute maximum health value without any formating so 15000 is still shown as 15000.",
	["Absolute current health value without any formating so 15000 is still shown as 15000."] = "Absolute current health value without any formating so 15000 is still shown as 15000.",
	["Absolute maximum power value without any formating so 15000 is still shown as 15000."] = "Absolute maximum power value without any formating so 15000 is still shown as 15000.",
	["Absolute current power value without any formating so 15000 is still shown as 15000."] = "Absolute current power value without any formating so 15000 is still shown as 15000.",
	["Shows AFK or DND flags if they are toggled."] = "Shows AFK or DND flags if they are toggled.",
	["Absolute current/max health, without any formating so 17750 is still formatted as 17750."] = "Absolute current/max health, without any formating so 17750 is still formatted as 17750.",
	["Absolute current/max power, without any formating so 17750 is still formatted as 17750."] = "Absolute current/max power, without any formating so 17750 is still formatted as 17750.",
	["Unit name colored by class."] = "Unit name colored by class.",
	["Units classification, Rare, Rare Elite, Elite, Boss, nothing is shown if they aren't any of those."] = "Units classification, Rare, Rare Elite, Elite, Boss, nothing is shown if they aren't any of those.",
	["Returns Offline if the unit is offline, otherwise nothing is shown."] = "Returns Offline if the unit is offline, otherwise nothing is shown.",
	["Level without any coloring."] = "Level without any coloring.",
	["Current health, uses a short format, 11500 is formatted as 11.5k, values below 10000 are formatted as is."] = "Current health, uses a short format, 11500 is formatted as 11.5k, values below 10000 are formatted as is.",
	["Amount of health missing, if none is missing nothing is shown. Uses a short format, -18500 is shown as -18.5k, values below 10000 are formatted as is."] = "Amount of health missing, if none is missing nothing is shown. Uses a short format, -18500 is shown as -18.5k, values below 10000 are formatted as is.",
	["Unit name"] = "Unit name",
	["Amount of power missing,  if none is missing nothing is shown. Uses a short format, -13850 is shown as 13.8k, values below 10000 are formatted as is."] = "Amount of power missing,  if none is missing nothing is shown. Uses a short format, -13850 is shown as 13.8k, values below 10000 are formatted as is.",
	["Max power, uses a short format, 16000 is formatted as 16k, values below 10000 are formatted as is."] = "Max power, uses a short format, 16000 is formatted as 16k, values below 10000 are formatted as is.",
	["Current and maximum power, formatted as [curpp]/[maxpp]."] = "Current and maximum power, formatted as [curpp]/[maxpp].",
	["Unit race, for a Blood Elf then Blood Elf is returned, for a Night Elf than Night Elf is returned and so on."] = "Unit race, for a Blood Elf then Blood Elf is returned, for a Night Elf than Night Elf is returned and so on.",
	["Returns the units sex."] = "Returns the units sex.",
	["Returns + if the unit is an elite or rare elite mob."] = "Returns + if the unit is an elite or rare elite mob.",
	["Returns current health as a percentage, if the unit is dead or offline than that is shown instead."] = "Returns current health as a percentage, if the unit is dead or offline than that is shown instead.",
	["Returns Rare if the unit is a rare or rare elite mob."] = "Returns Rare if the unit is a rare or rare elite mob.",
	["Current power, uses a short format, 12750 is formatted as 12.7k, values below 10000 are formatted as is."] = "Current power, uses a short format, 12750 is formatted as 12.7k, values below 10000 are formatted as is.",
	["Current and maximum health, formatted as [curhp]/[maxhp], if the unit is dead or offline then that is shown instead."] = "Current and maximum health, formatted as [curhp]/[maxhp], if the unit is dead or offline then that is shown instead.",
	["Short classifications, R for Rare, R+ for Rare Elite, + for Elite, B for boss, nothing is shown if they aren't any of those."] = "Short classifications, R for Rare, R+ for Rare Elite, + for Elite, B for boss, nothing is shown if they aren't any of those.",
	["Total number of combo points you have on your target."] = "Total number of combo points you have on your target.",
	["If the unit is dead, returns dead, if they are a ghost then ghost is returned, if they aren't either then nothing is shown."] = "If the unit is dead, returns dead, if they are a ghost then ghost is returned, if they aren't either then nothing is shown.",
	["Units status, Dead, Ghost, Offline, nothing is shown if they aren't any of those."] = "Units status, Dead, Ghost, Offline, nothing is shown if they aren't any of those.",
	["Returns current power as a percentage."] = "Returns current power as a percentage.",
	["Smart level, returns Boss for bosses, +50 for a level 50 elite mob, or just 80 for a level 80."] = "Smart level, returns Boss for bosses, +50 for a level 50 elite mob, or just 80 for a level 80.",
	["Units alignment, Thrall will return Horde, Magni Bronzebeard will return Alliance."] = "Units alignment, Thrall will return Horde, Magni Bronzebeard will return Alliance.",
	["Colored level by difficulty, no color used if you cannot attack the unit."] = "Colored level by difficulty, no color used if you cannot attack the unit.",
	["For players, it will return a class, for mobs than it will return their creature type."] = "For players, it will return a class, for mobs than it will return their creature type.",
	["Max health, uses a short format, 17750 is formatted as 17.7k, values below 10000 are formatted as is."] = "Max health, uses a short format, 17750 is formatted as 17.7k, values below 10000 are formatted as is.",
	["Colored class, use [class] for just the class name without coloring."] = "Colored class, use [class] for just the class name without coloring.",
	["Create type, for example, if you're targeting a Felguard then this will return Felguard."] = "Create type, for example, if you're targeting a Felguard then this will return Felguard.",
	["Class, use [classcolor] if you want a colored class name."] = "Class, use [classcolor] if you want a colored class name.",
	["Shows the units health as a percentage rounded to the first decimal, meaning 61 out of 110 health is shown as 55.4%."] = "Shows the units health as a percentage rounded to the first decimal, meaning 61 out of 110 health is shown as 55.4%.",
}