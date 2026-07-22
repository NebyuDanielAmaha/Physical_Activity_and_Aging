library(dplyr)
library(purrr)

load("data_clean/01_imported_data_f.RData")


# --- Enforce uppercase for PA ---
names(pax) <- toupper(names(pax))


# --- List all datasets for merge (include hei_manual) ---
all_datasets <- list(
  demo, bmx, bpx, cbc, crp, biopro, glu, ghb, 
  hdl, tchol, cot, alb_cr, diq, fastqx, fertin, 
  hcy, mcq, ogtt, pfq, smq, trigly, pax
)

# --- Clean non-demo files ---
demo_names <- names(demo)

for (i in seq_along(all_datasets)) {
  df <- all_datasets[[i]]
  if (i == 1) next
  cols_to_keep <- setdiff(names(df), demo_names)
  if ("SEQN" %in% names(df) && !"SEQN" %in% cols_to_keep) {
    cols_to_keep <- c("SEQN", cols_to_keep)
  }
  all_datasets[[i]] <- df %>% select(all_of(cols_to_keep))
}

# --- Merge ---
analytic_merged <- all_datasets %>% reduce(left_join, by = "SEQN")

# --- Drop duplicate columns ---
if (any(grepl("\\.x$|\\.y$|\\.X$|\\.Y$", names(analytic_merged)))) {
  analytic_merged <- analytic_merged %>%
    select(-matches("\\.(x|y|X|Y)$"))
}

# --- Correct WTSAF2YR using glu file ---
demo_weights <- data.frame(
  SEQN = glu$SEQN,
  WTSAF2YR_correct = glu$WTSAF2YR
)
analytic_merged <- analytic_merged %>%
  left_join(demo_weights, by = "SEQN") %>%
  mutate(WTSAF2YR = WTSAF2YR_correct) %>%
  select(-WTSAF2YR_correct)

# --- Verify ---
summary(analytic_merged$WTSAF2YR)

# --- Save ---
saveRDS(analytic_merged, "data_clean/02_analytic_merged_f.rds")
