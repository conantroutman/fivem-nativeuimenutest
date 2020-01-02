_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Main menu", "~b~this is the description")
_menuPool:Add(mainMenu)

bool = false
function FirstItem(menu)
    local checkbox = NativeUI.CreateCheckboxItem("Click Me", bool, "Toggle this item")
    menu:AddItem(checkbox)
    menu.OnCheckBoxChange = function(sender, item, checked_)
        if item == checkbox then
            bool = checked_
            notify(tostring(bool))
        end
    end
end

function SecondItem(menu)
    local click = NativeUI.CreateItem("Heal", "~g~Heal yourself")
    menu:AddItem(click)
    menu.OnItemSelect = function(sender,item,index)
        if item == click then
            SetEntityHealth(PlayerPedId(), 200)
            notify("~g~Healed...")
        end
    end
end

weapons = {
    "weapon_sniperrifle",
    "weapon_pistol",
    "weapon_rpg"
}

function ThirdItem(menu)
    local gunList = NativeUI.CreateListItem("Get Guns", weapons, 1)
    menu:AddItem(gunList)
    menu.onListSelect = function(sender,item,index)
        if item == gunList then
            local selectedGun = item:IndexToItem(index)
            giveWeapon(selectedGun)
            notify("Spawned in a ~b~".. selectedGun)
        end
    end
end

seats = {-1,0,1,2}
function FourthItem(menu)
    local submenu = _menuPool:AddSubMenu(menu, "~b~Sub Menu")
    local carItem = NativeUI.CreateItem("Spawn car", "Spawn a car in a sub menu")
    carItem.Activated = function(sender,item)
        if item == carItem then
            spawnCar("valkyrie")
        end
    end    
    local seat = NativeUI.CreateSliderItem("Change Seat", seats, 1)
    submenu.OnSliderChange = function (sender,item,index)
        if item == seat then
            vehSeat = item:IndexToItem(index)
            local pedCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            setPedIntoVehicle(PlayerPedId(), pedCar, vehSeat)
        end
    end
    submenu:AddItem(carItem)
    submenu:AddItem(seat)
end

FirstItem(mainMenu)
SecondItem(mainMenu)
ThirdItem(mainMenu)
FourthItem(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1,51) then
            mainMenu:Visible(not mainMenu:Visible())
        end
    end

end)

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function giveWeapon(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, true)
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
    
end