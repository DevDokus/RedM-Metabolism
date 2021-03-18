--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------
-- Temperature Settings
Temperature = {
  Format         = 'C',    -- C or F
  Max            = 20,
  Min            = -20,
  ColdDamage     = 3,
  HotDamage      = 3,
  DamagePerSec   = 5,
}

-- Food Settings
Food = {
  DrainIdle    = 0.00025,
  DrainRunning = 0.0035,
  DrainWalking = 0.00085,
  LossTempHot  = 1.5,
  LossTempCold = 1,
  LoseWhen     = 10,
  DamagePerSec = 1,
}

-- Water Settings
Water = {
  DrainIdle    = 0.0005,
  DrainRunning = 0.01,
  DrainWalking = 0.0035,
  LossTempHot  = 1.5,
  LossTempCold = 1,
  LoseWhen     = 10,
  DamagePerSec = 1,
}
