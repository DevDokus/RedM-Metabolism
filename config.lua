--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------
-- Temperature Settings
Temperature = {
  Format         = 'C',    -- C or F
  Max            = 5,
  Min            = -5,
  ColdDamage     = 3,
  HotDamage      = 3,
  DamagePerSec   = 5,
}

-- Food Settings
Food = {
  DrainIdle    = 0.01,
  DrainRunning = 0.2,
  DrainWalking = 0.02,
  LossTempHot  = 1.5,
  LossTempCold = 1,
  LoseWhen     = 10,
  DamagePerSec = 1,
}

-- Water Settings
Water = {
  DrainIdle    = 0.01,
  DrainRunning = 1.0,
  DrainWalking = 0.05,
  LossTempHot  = 1.5,
  LossTempCold = 1,
  LoseWhen     = 10,
  DamagePerSec = 1,
}
