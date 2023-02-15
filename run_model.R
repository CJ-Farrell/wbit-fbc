# Example code for running xgboost model

# Set-up ---------------------------
rm(list = ls()) # Clear environment
library(tidyverse);library(recipes); library(xgboost)
sum_na <- function(x) sum(is.na(x)) # function used to confirm value imputation has occurred

# Import ---------------------------
new_data <- readRDS("example_data.rds") # Import data
imp_recipe_prepped <- readRDS("prepped_imputation_recipe.rds")# Recipe for data preprocessing performs mean imputation
xgb.model <-xgb.load("xgb_model")  # Import model

# Data preprocessing ---------------------------
apply(new_data, 2,  sum_na) # Confirm have no missing values for 'male' or 'age' 
new_data_imp <- imp_recipe_prepped %>% bake(new_data = new_data) # Perform mean imputation for missing values among the other parameters
apply(new_data_imp, 2,  sum_na) %>% sum # Confirm there are zero missing values after imputation

# Now there are imputate values for the current and previous results, calculate absolute and percentage delta values
new_data_imp <- new_data_imp %>% 
  mutate(
    hb_abs = current_hb - last_hb,
    wcc_abs = current_wcc - last_wcc,
    plt_abs = current_plt - last_plt, 
    rcc_abs = current_rcc - last_rcc, 
    hct_abs = current_hct - last_hct, 
    mcv_abs = current_mcv - last_mcv,
    mch_abs = current_mch - last_mch,
    rdw_abs = current_rdw - last_rdw, 
    lym_abs = current_lym - last_lym,
    eos_abs = current_eos - last_eos,
    mpv_abs = current_mpv - last_mpv, 
    pdw_abs = current_mpv - last_mpv,
    
    hb_per = hb_abs/last_hb, 
    wcc_per = wcc_abs/last_wcc,
    plt_per = plt_abs/last_plt, 
    rcc_per = rcc_abs/last_rcc, 
    hct_per = hct_abs/last_hct, 
    mcv_per = mcv_abs/last_mcv,
    mch_per = mch_abs/last_mch,
    rdw_per = rdw_abs/last_rdw, 
    lym_per = lym_abs/last_lym,
    eos_per = eos_abs/last_eos,
    mpv_per = mpv_abs/last_mpv,
    pdw_per = pdw_abs/last_pdw
  )

# Run model  ---------------------------
xgb_prob <- predict(xgb.model, as.matrix(new_data_imp)) # predictions of probability of WBIT error from the model
final_data <- new_data %>% mutate(WBIT_Prob = xgb_prob) # add these predictions to the data
final_data %>% arrange(desc(WBIT_Prob)) # see the samples most likely to be WBIT errors


