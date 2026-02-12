-- =====================================
-- Panels/QOL.lua — QOL Modules Config (TomoModMini)
-- Tabs: Cinematic Skip, Automations
-- =====================================

local W = TomoModMini_Widgets
local L = TomoModMini_L

-- =====================================
-- TAB 1: CINEMATIC SKIP
-- =====================================

local function BuildCinematicTab(parent)
    local scroll = W.CreateScrollPanel(parent)
    local c = scroll.child
    local y = -10

    local _, ny = W.CreateSectionHeader(c, L["section_cinematic"], y)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_cinematic_auto_skip"], TomoModMiniDB.cinematicSkip.enabled, y, function(v)
        TomoModMiniDB.cinematicSkip.enabled = v
        if v and TomoModMini_CinematicSkip then TomoModMini_CinematicSkip.Initialize() end
    end)
    y = ny

    local viewedStr = "0"
    if TomoModMini_CinematicSkip and TomoModMini_CinematicSkip.GetViewedCount then
        viewedStr = tostring(TomoModMini_CinematicSkip.GetViewedCount())
    end
    local _, ny = W.CreateInfoText(c, string.format(L["info_cinematic_viewed"], viewedStr), y)
    y = ny

    local _, ny = W.CreateButton(c, L["btn_clear_history"], 180, y, function()
        if TomoModMini_CinematicSkip then TomoModMini_CinematicSkip.ClearHistory() end
    end)
    y = ny

    c:SetHeight(math.abs(y) + 40)
    return scroll
end

-- =====================================
-- TAB 2: AUTOMATIONS (castbar, invite, summon, fill delete, skip role)
-- =====================================

local function BuildAutomationsTab(parent)
    local scroll = W.CreateScrollPanel(parent)
    local c = scroll.child
    local y = -10

    local _, ny = W.CreateSectionHeader(c, L["section_automations"], y)
    y = ny

    -- Hide Blizzard Castbar
    local _, ny = W.CreateCheckbox(c, L["opt_hide_blizzard_castbar"], TomoModMiniDB.hideCastBar.enabled, y, function(v)
        if TomoModMini_HideCastBar then TomoModMini_HideCastBar.SetEnabled(v) end
    end)
    y = ny

    -- Auto Accept Invite
    local _, ny = W.CreateSeparator(c, y)
    y = ny
    local _, ny = W.CreateSubLabel(c, L["sublabel_auto_accept_invite"], y)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_enable"], TomoModMiniDB.autoAcceptInvite.enabled, y, function(v)
        TomoModMiniDB.autoAcceptInvite.enabled = v
    end)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_accept_friends"], TomoModMiniDB.autoAcceptInvite.acceptFriends, y, function(v)
        TomoModMiniDB.autoAcceptInvite.acceptFriends = v
    end)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_accept_guild"], TomoModMiniDB.autoAcceptInvite.acceptGuild, y, function(v)
        TomoModMiniDB.autoAcceptInvite.acceptGuild = v
    end)
    y = ny

    -- Auto Skip Role
    local _, ny = W.CreateSeparator(c, y)
    y = ny
    local _, ny = W.CreateSubLabel(c, L["sublabel_auto_skip_role"], y)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_enable"], TomoModMiniDB.autoSkipRole.enabled, y, function(v)
        TomoModMiniDB.autoSkipRole.enabled = v
        if TomoModMini_AutoSkipRole then TomoModMini_AutoSkipRole.SetEnabled(v) end
    end)
    y = ny

    -- Auto Summon
    local _, ny = W.CreateSeparator(c, y)
    y = ny
    local _, ny = W.CreateSubLabel(c, L["sublabel_auto_summon"], y)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_enable"], TomoModMiniDB.autoSummon.enabled, y, function(v)
        TomoModMiniDB.autoSummon.enabled = v
    end)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_accept_friends"], TomoModMiniDB.autoSummon.acceptFriends, y, function(v)
        TomoModMiniDB.autoSummon.acceptFriends = v
    end)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_accept_guild"], TomoModMiniDB.autoSummon.acceptGuild, y, function(v)
        TomoModMiniDB.autoSummon.acceptGuild = v
    end)
    y = ny

    local _, ny = W.CreateSlider(c, L["opt_summon_delay"], TomoModMiniDB.autoSummon.delaySec, 0, 10, 1, y, function(v)
        TomoModMiniDB.autoSummon.delaySec = v
    end)
    y = ny

    -- Auto Fill Delete
    local _, ny = W.CreateSeparator(c, y)
    y = ny
    local _, ny = W.CreateSubLabel(c, L["sublabel_auto_fill_delete"], y)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_enable"], TomoModMiniDB.autoFillDelete.enabled, y, function(v)
        TomoModMiniDB.autoFillDelete.enabled = v
    end)
    y = ny

    local _, ny = W.CreateCheckbox(c, L["opt_focus_ok_button"], TomoModMiniDB.autoFillDelete.focusButton, y, function(v)
        TomoModMiniDB.autoFillDelete.focusButton = v
    end)
    y = ny

    c:SetHeight(math.abs(y) + 40)
    return scroll
end

-- =====================================
-- MAIN PANEL ENTRY POINT
-- =====================================

function TomoModMini_ConfigPanel_QOL(parent)
    local tabs = {
        { key = "cinematic",    label = L["tab_qol_cinematic"],    builder = function(p) return BuildCinematicTab(p) end },
        { key = "automations",  label = L["tab_qol_automations"],  builder = function(p) return BuildAutomationsTab(p) end },
    }

    return W.CreateTabPanel(parent, tabs)
end
