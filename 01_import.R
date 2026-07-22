# =====================================================
# NHANES 2005-2006
# 01_import.R
# =====================================================

library(tidyverse)
library(haven)
library(janitor)
library(dplyr)
library(data.table)
library(survey)
library(hei)
# library(rnhanesdata)

#------------------------------------------------------
# directories
#------------------------------------------------------

root <- "C:/Users/Benyu/Documents/nhanes_project"

raw_dir   <- file.path(root,"data_raw")
clean_dir <- file.path(root,"data_clean")

# ==============================================================================
# 2. LOAD RAW XPT FILES
# ==============================================================================
# --- BASE BIOMARKER FILES ---
demo   <- read_xpt(file.path(raw_dir, "DEMO_D.xpt"))
bmx    <- read_xpt(file.path(raw_dir, "BMX_D.xpt"))
bpx    <- read_xpt(file.path(raw_dir, "BPX_D.xpt"))
cbc    <- read_xpt(file.path(raw_dir, "CBC_D.xpt"))
crp    <- read_xpt(file.path(raw_dir, "CRP_D.xpt"))
biopro <- read_xpt(file.path(raw_dir, "BIOPRO_D.xpt"))
ghb    <- read_xpt(file.path(raw_dir, "GHB_D.xpt"))

alb_cr <- read_xpt(file.path(raw_dir, "ALB_CR_D.xpt"))
cot    <- read_xpt(file.path(raw_dir, "COT_D.xpt"))
diq    <- read_xpt(file.path(raw_dir, "DIQ_D.xpt"))
fastqx <- read_xpt(file.path(raw_dir, "FASTQX_D.xpt"))
fertin <- read_xpt(file.path(raw_dir, "FERTIN_D.xpt"))
hcy    <- read_xpt(file.path(raw_dir, "HCY_D.xpt"))
hdl    <- read_xpt(file.path(raw_dir, "HDL_D.xpt"))
mcq    <- read_xpt(file.path(raw_dir, "MCQ_D.xpt"))
ogtt   <- read_xpt(file.path(raw_dir, "OGTT_D.xpt"))
pfq    <- read_xpt(file.path(raw_dir, "PFQ_D.xpt"))
smq    <- read_xpt(file.path(raw_dir, "SMQ_D.xpt"))
tchol  <- read_xpt(file.path(raw_dir, "TCHOL_D.xpt"))
trigly <- read_xpt(file.path(raw_dir, "TRIGLY_D.xpt"))
glu    <- read_xpt(file.path(raw_dir, "GLU_D.xpt"))
diet1  <- read_xpt(file.path(raw_dir, "DR1TOT_D.xpt"))
pax    <- readRDS(file.path(raw_dir, "nhanes-2026.rda"))




# --- Save all imported objects explicitly ---
save(
  demo, bmx, bpx, cbc, crp, biopro, ghb,
  glu, hdl, tchol, cot, pax, pfq, smq, trigly, 
  alb_cr, diq, fastqx, fertin, hcy, mcq, ogtt,
  diet1,
  file = file.path(clean_dir, "01_imported_data_f.RData")
)
