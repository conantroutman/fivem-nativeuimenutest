player = PlayerId()
_menuPool = NativeUI.CreatePool()

function AddMenuQuickGPS(menu)
    locations = {
        "None",
        "Ammu-Nation",
        "ATM",
        "Barber Shop",
        "Tattoo Parlor",
        "Mod Shop",
        "Clothes Store",
        "Airfield"
    }

    modShops = {    
        { x = -365.425, y = -131.809, z = 37.873},
        { x = -1126.225, y = -1993.027, z = 0},
        { x = 716.413, y = -1078.057, z = 0},
        --Beeker's Garage
        { x = 116.22, y = 6606.20, z = 31.46},
        --Benny's Garage
        { x = -196.35, y = -1303.1, z = 30.65},
    }

    ATMs = {
        {x = 147.66, y = -1035.75, z = 29.34},
        {x = 146.0, y = -1035.04, z = 29.34},
        {x = 296.41, y = -894.11, z = 29.23},
        {x = 295.71, y = -896.02, z = 29.21},
        {x = 114.46, y = -776.47, z = 31.42},
        {x = 111.28, y = -775.3, z = 31.44},
        {x = 112.54, y = -819.28, z = 31.34},
        {x = -254.36, y = -692.36, z = 33.61},
        {x = -256.18, y = -715.99, z = 33.52},
        {x = -203.91, y = -861.41, z = 19.96},
        {x = -2072.46, y = -317.24, z = 263.27},
        {x = -2975.05, y = 380.19, z = 15.0},
        {x = -3144.29, y = 1127.56, z = 65.1},
        {x = -165.07, y = 232.81, z = 94.92},
        {x = -165.14, y = 234.81, z = 94.92},
    }

    airfields = {    
        {x = -1070.90, y = -2972.12, z = 13.77},
        {x = 1682.19, y = 3279.98, z = 40.64},
        {x = 2124.62, y = 4805.27, z = 40.47}
    }

    local locationsList = NativeUI.CreateListItem("Quick GPS", locations, 1, "Select to place your waypoint at a set location.")
    menu:AddItem(locationsList)
    menu.OnListSelect = function(sender, item, index)  
        if item == locationsList then
            --None
            if index == 1 then
                DeleteWaypoint()
            --ATM
            elseif index == 3 then
                SetQuickGPS(ATMs)
            --Mod Shop
            elseif index == 6 then
                SetQuickGPS(modShops)
            elseif index == 8 then
                SetQuickGPS(airfields)
            end
        end
    end
end

function AddMenuInventory(menu)
    local inventorySubmenu = _menuPool:AddSubMenu(menu, "Inventory", "Your Inventory contains carried items such as cash, weapon ammo and snacks.")

    local parachuteItem = NativeUI.CreateItem("Add Parachute", "")
    parachuteItem.Activated = function(sender, item)
         if item == parachuteItem then
            giveWeapon("gadget_parachute")
         end
    end

    local nightvisionItem = NativeUI.CreateItem("Add Nightvision", "")
    nightvisionItem.Activated = function(sender, item)
         if item == nightvisionItem then
            giveWeapon("gadget_nightvision")
         end
    end

    inventorySubmenu.SubMenu:AddItem(parachuteItem)
    inventorySubmenu.SubMenu:AddItem(nightvisionItem)
end

function AddMenuStyle(menu)
    local styleSubmenu = _menuPool:AddSubMenu(menu, "Style")

    local movementItem = NativeUI.CreateItem("Walking Style", "")
    movementItem.Activated = function(sender, item)
         if item == movementItem then
            --changePlayerMovement("MOVE_M@DRUNK@VERYDRUNK")
            ReportCrime(PlayerId(), 44, 1)
         end
    end

    styleSubmenu.SubMenu:AddItem(movementItem)
end

function AddMenuBodyArmor(menu)
    local armorSubmenu = _menuPool:AddSubMenu(menu, "Body Armor", "Use body armor or simply change your look by selecting what body armor to wear.") 
    local armorItem1 = NativeUI.CreateItem("Super Light Armor", "Refill armor")
    armorItem1.Activated = function(sender, item)
         if item == armorItem1 then
            giveBodyArmor(20, 10, 0)
         end
    end
    local armorItem2 = NativeUI.CreateItem("Light Armor", "Refill armor")
    armorItem2.Activated = function(sender, item)
         if item == armorItem2 then
            giveBodyArmor(40, 10, 4)
         end
    end
    local armorItem3 = NativeUI.CreateItem("Standard Armor", "Refill armor")
    armorItem3.Activated = function(sender, item)
         if item == armorItem3 then
            giveBodyArmor(60, 10, 1)
         end
    end
    local armorItem4 = NativeUI.CreateItem("Heavy Armor", "Refill armor")
    armorItem4.Activated = function(sender, item)
         if item == armorItem4 then
            giveBodyArmor(80, 10, 2)
         end
    end
    local armorItem5 = NativeUI.CreateItem("Super Heavy Armor", "Refill armor")
    armorItem5.Activated = function(sender, item)
         if item == armorItem5 then
            giveBodyArmor(100, 10, 3)
         end
    end
    
    armorSubmenu.SubMenu:AddItem(armorItem1)
    armorSubmenu.SubMenu:AddItem(armorItem2)
    armorSubmenu.SubMenu:AddItem(armorItem3)
    armorSubmenu.SubMenu:AddItem(armorItem4)
    armorSubmenu.SubMenu:AddItem(armorItem5)
end

function AddMenuVehicle(menu)
    local vehicleSubmenu = _menuPool:AddSubMenu(menu, "Vehicles") 
    local requestVehicleItem = NativeUI.CreateItem("Request Vehicle", "")
    local engineItem = NativeUI.CreateItem("Turn On Engine", "")
    local loudRadioItem = NativeUI.CreateItem("Loud Radio", "Blast it")
    requestVehicleItem.Activated = function(sender, item)
        spawnCar("s230")
        closeInteractionMenu()
    end
    engineItem.Activated = function(sender, item)
        SetVehicleEngineOn(GetLastDrivenVehicle(), true, true, true)
    end
    loudRadioItem.Activated = function(sender, item)
         if item == loudRadioItem then
            if isVehicleRadioLoud then
                SetVehicleRadioLoud(GetLastDrivenVehicle(), false)
            else
                SetVehicleRadioLoud(GetLastDrivenVehicle(), true)
            end
         end
    end
    vehicleSubmenu.SubMenu:AddItem(requestVehicleItem)
    vehicleSubmenu.SubMenu:AddItem(engineItem)
    vehicleSubmenu.SubMenu:AddItem(loudRadioItem)
end

function AddMenuChallenges(menu)
    local challengesSubmenu = _menuPool:AddSubMenu(menu, "Challenges")
    local carmageddonItem = NativeUI.CreateItem("Carmageddon", "Start a Carmageddon challenge.")
    local huntingItem = NativeUI.CreateItem("Hunting", "Start a hunting challenge.")
    local longestWheelieItem = NativeUI.CreateItem("Longest Wheelie", "Start a longest wheelie challenge.")
    local longestStoppieItem = NativeUI.CreateItem("Longest Stoppie", "Start a longest stoppie challenge.")
    challengesSubmenu.SubMenu:AddItem(huntingItem)
    challengesSubmenu.SubMenu:AddItem(longestWheelieItem)
end

function AddMenuSuicide(menu)
    local click = NativeUI.CreateItem("Kill Yourself", "Commit suicide.")
    menu:AddItem(click)
    menu.OnItemSelect = function(sender, item)
        if item == click then
            CommitSuicide()
        end
    end
end

function openInteractionMenu()
    mainMenu = NativeUI.CreateMenu(GetPlayerName(PlayerId()), "~b~INTERACTION MENU")
    --mainMenu = NativeUI.CreateMenu(GetPlayerName(PlayerId()), "~b~INTERACTION MENU", nil, nil, "casinoui_cards_three", "casinoui_cards_three", 1)
    _menuPool:Add(mainMenu)
    AddMenuQuickGPS(mainMenu)
    AddMenuInventory(mainMenu)
    AddMenuStyle(mainMenu)
    AddMenuBodyArmor(mainMenu)
    AddMenuVehicle(mainMenu)
    AddMenuChallenges(mainMenu)
    AddMenuSuicide(mainMenu)
    _menuPool:RefreshIndex()
    mainMenu:Visible(not mainMenu:Visible())
    _menuPool:MouseEdgeEnabled (false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        -- Open menu with M
        if IsControlJustPressed(1, 244) and not IsPlayerDead(PlayerId()) then
            openInteractionMenu()
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------

function test(menu)
    armor = {
        "Super Light Armor",
        "Light Armor",
        "Standard Armor",
        "Heavy Armor",
        "Super Heavy Armor"
    }
    armorList = NativeUI.CreateListItem("Show Armor", armor, 1)
    menu.SubMenu:AddItem(armorList)
end

function createArmorItem(menu, name, value, submenuCheck)
    local armorItem = NativeUI.CreateItem(name, "Use a " .. name .. " to refill your armor bar. You can also choose to show or hide the " .. name)
    armorItem.Activated = function(sender, item)
         if item == armorItem then
            giveBodyArmor(20)
         end
    end
    if submenuCheck then
        menu.SubMenu:AddItem(armorItem)
    else
        menu:AddItem(armorItem)
    end
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function giveWeapon(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, true)
end

function giveBodyArmor(value, model, texture)
    AddArmourToPed(PlayerPedId(), value)
    SetPedComponentVariation(PlayerPedId(), 9, model, texture, 0)
    notify(tostring(GetNumberOfPedDrawableVariations(PlayerPedId(), 9)))
end

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    --Find road
    local chk, pos, heading = GetNthClosestVehicleNodeWithHeading(x, y, z, 10, 9, 3.0, 2.5)
    local vx, vy, vz = table.unpack(pos)
    --Find roadside
    local chck2, pos2 = GetPointOnRoadSide(vx, vy, vz, 1)
    local x2, y2, z2 = table.unpack(pos2)
    local vehicle = CreateVehicle(car, x2, y2, z2, heading, true, false)
    --SetPedIntoVehicle(PlayerPedId(), vehicle, -1)

    local blip = AddBlipForEntity(vehicle)
    SetBlipSprite(blip, 225)
	SetBlipFlashes(blip, true)
    SetBlipFlashTimer(blip, 5000)
    SetBlipNameFromTextFile(blip, GetDisplayNameFromVehicleModel(car))
    
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
    
    --[[ SetEntityAsMissionEntity(vehicle, true, true) ]]
end

function closeInteractionMenu()
    _menuPool:CloseAllMenus()
end

--function changePlayerMovement(animSet)
    --if not HasAnimSetLoaded(animSet) then
        --RequestAnimSet(animSet)
        --SetPedMovementClipset(GetPlayerPed(-1), animSet, 1.0)
--end

AddEventHandler("baseevents:onPlayerDied", function()
    closeInteractionMenu()
end)
AddEventHandler("baseevents:onPlayerKilled", function()
    closeInteractionMenu()
end)


-- SetQuickGPS - Calculate the closest of a set of coordinates and set a waypoint there
function SetQuickGPS(locations)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local x2, y2, z2
    local temp = {}

    for i, location in ipairs(locations) do
         x2 = location.x
         y2 = location.y
         z2 = location.z
        table.insert(temp, CalculateTravelDistanceBetweenPoints(x, y, z, x2, y2, z2))
    end

    local key = next(temp)
    local min = temp[key]

    for k, v in pairs(temp) do
        if temp[k] < min then
            key, min = k, v
        end
    end

    SetNewWaypoint(locations[key].x, locations[key].y)
end

function HasPlayerEquippedPistol()
    local pistols = {
        "weapon_pistol",
        "weapon_pistol_mk2",
        "weapon_combatpistol",
        "weapon_appistol",
        "weapon_pistol50",
        "weapon_snspistol",
        "weapon_snspistol_mk2",
        "weapon_heavypistol",
        "weapon_vintagepistol",
        "weapon_marksmanpistol",
        "weapon_revolver",
        "weapon_revolver_mk2",
        "weapon_doubleaction",
        "weapon_raypistol",
        "weapon_ceramicpistol",
        "weapon_navyrevolver",
    }
    for i, pistol in ipairs(pistols) do
        if select(2, GetCurrentPedWeapon(PlayerPedId(), 1)) == GetHashKey(pistol) then
            return true
        end
    end
    return false
end

function CommitSuicide()
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        --Load suicide animations
        if not HasAnimDictLoaded("mp_suicide") then
            RequestAnimDict("mp_suicide");
            Wait(200)
        end

        --Check if the player has a pistol currently equipped
        if HasPlayerEquippedPistol() then
            SetPedDropsWeaponsWhenDead(PlayerPedId(), true)
            ClearPedTasks(PlayerPedId())
            TaskPlayAnim(PlayerPedId(), "MP_SUICIDE", "pistol", 8.0, -8.0, -1, 270540800, 0, false, false, false)
            --if HasAnimEventFired(PlayerPedId(), GetHashKey("Fire")) then
            local fire = false
            while not fire do
                Citizen.Wait(0)
                if HasAnimEventFired(PlayerPedId(), GetHashKey("Fire")) then
                    ClearEntityLastDamageEntity(PlayerPedId())
                    SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, false)
                    Wait(100)
                    SetEntityHealth(PlayerPedId(), 0)
                    fire = true
                end
            end
        else
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)
            ClearPedTasks(PlayerPedId())
            TaskPlayAnim(PlayerPedId(), "MP_SUICIDE", "pill", 8.0, -8.0, -1, 270540800, 0, false, false, false)
            --Wait until the player has swallowed the pill
            Wait(4000)
            ClearEntityLastDamageEntity(PlayerPedId())
            SetEntityHealth(PlayerPedId(), 0)
        end
        RemoveAnimDict("mp_suicide")
    --If the player is in a vehicle we can't play the animation, so just kill the player
    else
        SetEntityHealth(PlayerPedId(), 0)
    end
    closeInteractionMenu()
end