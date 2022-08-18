DungeonJournal = {}

-- TO DO:
-- Fix Checkboxes in the LAM  - Not important yet
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
        { 
            type = "header",
            name = "Arby's",
        },
        {
            type = "description",
            text = "~~~ We have the Meats~~~",
        },
        {
			type = "checkbox",
			name = "TODO Checkbox",
			tooltip = "TODO Tooltip",
			getFunc = function() return JournalQuestLog.vars.showMissed end,
			setFunc = function(newValue) JournalQuestLog.vars.showMissed = newValue end,
			requiresReload = true,
		},
    }
    LAM:RegisterOptionControls(panelData.name.."Config", ConfigData)	
end



function DungeonJournal.Initialize()
      
    
    
    -- From Votan on the Forum responding to Enodoc --
    DungeonJournal.control=GetControl
    control=DungeonJournal.control

    local function InitializeRow(control, data)
		control:SetText(data.questName)--(zo_strformat(GetString(SI_JOURNAL_QUEST_LOG_ROW_ENTRY), data.questName))
	end

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
    -- Messing with Sidebar here
    --DUNGEON_JOURNAL_SCENE:AddFragment(GAMEPAD_NAV_QUADRANT_1_BACKGROUND_FRAGMENT)
    --DUNGEON_JOURNAL_SCENE:AddFragment(GAMEPAD_NAV_QUADRANT_2_3_BACKGROUND_FRAGMENT)

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

    -- Sub Category testing --------------
    -- DungeonJournal.InitializeCategoryList(control)
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

    --Calling INIT
    DungeonJournal.InitializeCategoryList(control)

end



function DungeonJournal.InitializeCategoryList(control)

--    DungeonJournal.navigationTree = ZO_Tree:New(control:GetNamedChild("NavigationContainerScrollChild"), 40, -10, 385)

--    local function TreeHeaderSetup(node, control, completionState, open)
--        control:SetModifyTextType(MODIFY_TEXT_TYPE_UPPERCASE)
--        control:SetText(GetString("SI_DUNGEON_JOURNAL_NAVIGATION1", completionState))
        
--      ZO_LabelHeader_Setup(control, open)
--   end

--    local function TreeHeaderEquality(left, right)
--        return left.completionState == right.completionState
--    end
--	
--   DungeonJournal.navigationTree:AddTemplate("ZO_LabelHeader", TreeHeaderSetup, nil, TreeHeaderEquality, nil, 0)
--
--    local function TreeEntrySetup(node, control, data, open)
--        control:SetText(zo_strformat("<<1>>", data.name))
--        local counter = control:GetNamedChild("CounterText")
--		counter:SetText(zo_strformat("<<2>>/<<1>>", #data.quests-data.missed, data.completed))
--		GetControl(control, "CompletedIcon"):SetHidden(not data.allCompleted)
--        control:SetSelected(false)
--    end
--    local function TreeEntryOnSelected(control, data, selected, reselectingDuringRebuild)
--     control:SetSelected(selected)
--       if selected and not reselectingDuringRebuild then
--            DungeonJournal.RefreshCategory()
--        end
--    end
--    local function TreeEntryEquality(left, right)
--        return left.name == right.name
--    end
--    DungeonJournal.navigationTree:AddTemplate("JQL_NavigationEntry", TreeEntrySetup, TreeEntryOnSelected, TreeEntryEquality)
--
--    DungeonJournal.navigationTree:SetExclusive(true)
--    DungeonJournal.navigationTree:SetOpenAnimation("ZO_TreeOpenAnimation")
    
    -- Print vvv
    d("DJ Navigation Initialized")
    
end

DungeonJournal.Initialize()
--init LAM Settings code
DungeonJournal.CreateConfigMenu()  