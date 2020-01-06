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
        "Clothes Store"
    }
    local locationsList = NativeUI.CreateListItem("Quick GPS", locations, 1)
    menu:AddItem(locationsList)
    menu.OnListSelect = function(sender, item, index)  
        if item == locationsList then
            local selectedLocation = item:IndexToItem(index)
            SetNewWaypoint(365.425, 131.809)
        end
    end
end

function AddMenuInventory(menu)
    local inventorySubmenu = _menuPool:AddSubMenu(menu, "Inventory")
end

function AddMenuBodyArmor(menu)
    local armorSubmenu = _menuPool:AddSubMenu(menu, "Body Armor") 
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
    local vehicleSubmenu = _menuPool:AddSubMenu(menu, "Vehicle Controls") 
    local loudRadioItem = NativeUI.CreateItem("Loud Radio", "Blast it")
    loudRadioItem.Activated = function(sender, item)
         if item == loudRadioItem then
            if isVehicleRadioLoud then
                SetVehicleRadioLoud(GetLastDrivenVehicle(), false)
            else
                SetVehicleRadioLoud(GetLastDrivenVehicle(), true)
            end
         end
    end
    vehicleSubmenu.SubMenu:AddItem(loudRadioItem)
end

function AddMenuSuicide(menu)
    local click = NativeUI.CreateItem("Kill Yourself", "Commit suicide.")
    menu:AddItem(click)
    menu.OnItemSelect = function(sender, item)
        if item == click then
            SetEntityHealth(PlayerPedId(), 0)
        end
    end
end

function openInteractionMenu()
    mainMenu = NativeUI.CreateMenu(GetPlayerName(PlayerId()), "~b~INTERACTION MENU")
    --mainMenu = NativeUI.CreateMenu(GetPlayerName(PlayerId()), "~b~INTERACTION MENU", nil, nil, "casinoui_cards_three", "casinoui_cards_three", 1)
    _menuPool:Add(mainMenu)
    AddMenuQuickGPS(mainMenu)
    AddMenuInventory(mainMenu)
    AddMenuBodyArmor(mainMenu)
    AddMenuVehicle(mainMenu)
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
        if IsControlJustPressed(1, 244) then
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
    local vehicle = CreateVehicle(car, x + 2, y + 2, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
    
    --[[ SetEntityAsMissionEntity(vehicle, true, true) ]]
end