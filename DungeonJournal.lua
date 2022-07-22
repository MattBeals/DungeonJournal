DungeonJournal = {}

-- TO DO:
-- Fix Checkboxes in the LAM  - Not important yet
-- Figure out why it in game backs up when accessing tab
-- Fix tab to have data
-- Install some debugging stuff, since manually looking is crap
-- Figure out XML and don't just steal 
-- Images from LFG tool? /esoui/art/lfg/lfg_bgscrypt_of_hearts_tooltip.dds


-- local vars here v
DungeonJournal.name = "DungeonJournal"
DungeonJournal.version = "0.0.1"

local LAM = LibAddonMenu2

function DungeonJournal.CreateConfigMenu()
    -- LAM Settings and Configuration - Displays Currently, no function yet. 
    -- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    local panelData = {
        type                = "panel",
        name                = DungeonJournal.name,
        displayName         = "Dungeon Journal",
        author              = "DuckNamedPhil",
        version             = DungeonJournal.version,
        slashCommand        = nil,
        registerForRefresh  = true,
        registerForDefaults = true,
    }
    local ConfigPanel = LAM:RegisterAddonPanel(panelData.name.."Config", panelData)

    local ConfigData = {
        {   type = "checkbox",
            name = "A Checkbox",
            getFunc = function() return saveData.myValue end,
            setFunc = function(value) saveData.myValue = value end,
        },
    }
    LAM:RegisterOptionControls(panelData.name.."Config", ConfigData)	
end



function DungeonJournal.initialize()
    --init LAM Settings code
    DungeonJournal.CreateConfigMenu()

    -- From Votan on the Forum responding to Enodoc --
    DungeonJournal.control=GetControl

    local sceneName = "DungeonJournal"
    DUNGEON_JOURNAL_FRAGMENT = ZO_HUDFadeSceneFragment:New(DUNGEON_JOURNAL_Window)
    DUNGEON_JOURNAL_SCENE = ZO_Scene:New(sceneName, SCENE_MANAGER)
    DUNGEON_JOURNAL_SCENE:AddFragmentGroup(FRAGMENT_GROUP.PLAYER_PROGRESS_BAR_KEYBOARD_CURRENT)
    DUNGEON_JOURNAL_SCENE:AddFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
    DUNGEON_JOURNAL_SCENE:AddFragmentGroup(FRAGMENT_GROUP.MOUSE_DRIVEN_UI_WINDOW)
    DUNGEON_JOURNAL_SCENE:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
    DUNGEON_JOURNAL_SCENE:AddFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
    DUNGEON_JOURNAL_SCENE:AddFragment(RIGHT_BG_FRAGMENT)
    DUNGEON_JOURNAL_SCENE:AddFragment(TITLE_FRAGMENT)
    DUNGEON_JOURNAL_SCENE:AddFragment(JOURNAL_TITLE_FRAGMENT)
    DUNGEON_JOURNAL_SCENE:AddFragment(TREE_UNDERLAY_FRAGMENT)
    DUNGEON_JOURNAL_SCENE:AddFragment(CODEX_WINDOW_SOUNDS)
    DUNGEON_JOURNAL_SCENE:AddFragment(DUNGEON_JOURNAL_FRAGMENT)
    
    SYSTEMS:RegisterKeyboardRootScene(sceneName, DUNGEON_JOURNAL_SCENE)
    
    local sceneGroupInfo = MAIN_MENU_KEYBOARD.sceneGroupInfo["journalSceneGroup"]
    local iconData = sceneGroupInfo.menuBarIconData
    -- SI_JOURNAL_QUEST_LOG_MENU_QUESTS


    -- Creates text to the left of the icons in Journal tab
    iconData[1] = {
        categoryName = SI_DUNGEON_JOURNAL_MENU_QUESTS,
        descriptor = "dungeonJournal",
        normal = "EsoUI/Art/Journal/journal_tabIcon_quest_up.dds",
        pressed = "EsoUI/Art/Journal/journal_tabIcon_quest_down.dds",
        highlight = "EsoUI/Art/Journal/journal_tabIcon_quest_over.dds",
    }

    -- Header Icon in Journal
    iconData[#iconData + 1] = {
        categoryName = SI_DUNGEON_JOURNAL_MENU_HEADER,
        descriptor = sceneName,
        normal = "/esoui/art/lfg/lfg_indexicon_dungeon_up.dds",
		pressed = "/esoui/art/lfg/lfg_indexicon_dungeon_down.dds",
		highlight = "/esoui/art/lfg/lfg_indexicon_dungeon_over.dds",
    }

    local sceneGroupBarFragment = sceneGroupInfo.sceneGroupBarFragment
    DUNGEON_JOURNAL_SCENE:AddFragment(sceneGroupBarFragment)
    
    local scenegroup = SCENE_MANAGER:GetSceneGroup("journalSceneGroup")
    scenegroup:AddScene(sceneName)
    MAIN_MENU_KEYBOARD:AddRawScene(sceneName, MENU_CATEGORY_JOURNAL, MAIN_MENU_KEYBOARD.categoryInfo[MENU_CATEGORY_JOURNAL], "journalSceneGroup")
    
    DUNGEON_JOURNAL_SCENE:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWING then
            -- do stuff
        elseif newState == SCENE_HIDING then
            -- do stuff
        end
    end )

end

DungeonJournal.initialize()