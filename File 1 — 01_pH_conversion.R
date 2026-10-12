# ============================================================
# 01_pH_conversion.R
# pH scale conversion and temperature standardization
# NBS -> SWS -> Total scale -> Total scale at 25°C
# ============================================================

library(seacarb)

# Input data: df
# Required columns:
# pHnbs, Temperature, Salinity, Pressure_bar, TA
#
# Temperature: degrees Celsius (°C)
# Salinity: practical salinity
# Pressure_bar: bar
# TA: measured total alkalinity (mol/kg)

# 1. Convert pH from NBS to seawater scale (SWS)
df$pHsws <- pHnbs2sws(
  pHNBS = df$pHnbs,
  S = df$Salinity,
  T = df$Temperature
)

# 2. Convert pH from SWS to total scale
df$pHtot <- as.numeric(pHconv(
  flag = 1,
  pH = df$pHsws,
  S = df$Salinity,
  T = df$Temperature,
  P = df$Pressure_bar,
  ks = "d"
))

# 3. Standardize total-scale pH to 25°C
# Tlab = temperature at which pH was measured
# Tinsi = target temperature (25°C)
df$pHtot_25C <- pHinsi(
  pH = df$pHtot,
  ALK = df$TA,
  pHscale = "T",
  Tlab = df$Temperature,
  Tinsi = 25,
  S = df$Salinity,
  k1k2 = "w14"
)
