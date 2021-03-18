--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------
function Wait(args) Citizen.Wait(args) end
function Invoke(args, bool) Citizen.InvokeNative(args, bool) end
local VORPCore = {}
Citizen.CreateThread(function()
    while not VORPCore do
        TriggerEvent("getCore", function(core)
            VORPCore = core
        end)
        Citizen.Await(200)
    end
end)
--------------------------------------------------------------------------------
-- Event Register
RegisterNetEvent('DevDokus:Metabolism:C:Hunger')
RegisterNetEvent('DevDokus:Metabolism:C:Thirst')
RegisterNetEvent('DevDokus:Metabolism:C:Stamina')
RegisterNetEvent('DevDokus:Metabolism:C:Health')
RegisterNetEvent('DevDokus:Metabolism:C:StaminaInner')
RegisterNetEvent('DevDokus:Metabolism:C:StaminaOuter')
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------
-- Variables
_Hunger     = 100
_Thirst     = 100
_Stamina    = 100
local DyingCount = 0
local WarningCount = 0
local IsDying = false
local DeathWarning = false
-- local IsStatsSet  = false
--------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
--   local run = true
--   while run do Wait(1)
--     if VORPCore ~= nil then
--       -- TriggerServerEvent('DevDokus:Metabolism:S:StartStatus')
--       run = false
--     end
--   end
-- end)
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do Wait(1)
    if VORPCore ~= nil then
      local hot     = 0
      local cold    = 0
      local User    = PlayerPedId()
      local coords  = GetEntityCoords(User)
      local temp    = math.floor(GetTemperatureAtCoords(coords))

      -- TriggerServerEvent('DevDokus:Metabolism:S:Console', _Hunger, _Thirst)

      if temp >= Temperature.Max then hot  = Temperature.HotDamage end
      if temp <= Temperature.Min then cold = Temperature.ColdDamage end

      local running = IsPedRunning(User)
      local walking = IsPedWalking(User)

      if running then
        _Hunger  = _Hunger - (Food.DrainRunning + cold)
        _Thirst  = _Thirst - (Water.DrainRunning + cold)
      elseif walking then
        _Hunger  = _Hunger - (Food.DrainWalking + cold)
        _Thirst  = _Thirst - (Water.DrainWalking + cold)
      else
        _Hunger  = _Hunger - (Food.DrainIdle + cold)
        _Thirst  = _Thirst - (Water.DrainIdle + cold)
      end

      if _Hunger < Food.LoseWhen then
        local Core = GetAttributeCoreValue(User, 0)
        local health = (Core - Food.DamagePerSec)
        Citizen.InvokeNative(0xC6258F41D86676E0, User, 0, health)
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    if VORPCore ~= nil then
      local User = PlayerPedId()
      local Core = GetAttributeCoreValue(User, 0)
      if Core == 0 then
        IsDying = true
        Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 5, false, true, true)
        TriggerEvent("vorp:TipRight", 'You\'re dying, check your vitals!', 5000)
      end
    end
    Wait(5000)
  end
end)

-- AddEventHandler('DevDokus:Metabolism:C:SetFirstStatus', function(Data)
--   _Hunger = (Data.Hunger)
--   _Thirst = (Data.Thirst)
--   IsStatsSet = true
-- end)

AddEventHandler('DevDokus:Metabolism:C:Hunger', function(value)
  _Hunger = _Hunger + tonumber(value)
  if (_Hunger <= 0) then _Hunger = 0 end
  if (_Hunger > 100) then _Hunger = 100 end
end)

AddEventHandler('DevDokus:Metabolism:C:Thirst', function(value)
  _Thirst = _Thirst + tonumber(value)
  if (_Thirst <= 0) then _Thirst = 0 end
  if (_Thirst > 100) then _Thirst = 100 end
end)

AddEventHandler('DevDokus:Metabolism:C:Stamina', function(value)
  local User     = PlayerPedId()
  local _Stamina = Citizen.InvokeNative(0x36731AC041289BB1, User, 1)
  local new      = (_Stamina + tonumber(value))
  if (new > 100) then new = 100 end
  Citizen.InvokeNative(0xC6258F41D86676E0, User, 1, new)
end)

AddEventHandler('DevDokus:Metabolism:C:Health', function(value)
  local User   = PlayerPedId()
  local health = Citizen.InvokeNative(0x36731AC041289BB1, User, 1)
  local new    = health + tonumber(value)
  if (new > 100) then new = 100 end
  Citizen.InvokeNative(0xC6258F41D86676E0, User, 0, new)
end)

AddEventHandler('DevDokus:Metabolism:C:StaminaInner', function(value)
  local User   = PlayerPedId()
  Citizen.InvokeNative(0x4AF5A4C7B9157D14, User, 1, value, true)
end)

AddEventHandler('DevDokus:Metabolism:C:StaminaOuter', function(value)
  local User   = PlayerPedId()
  Citizen.InvokeNative(0xF6A7C08DF2E28B28, User, 1, value, true)
end)

--------------------------------------------------------------------------------
