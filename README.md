# WBIT detection by XGBoost

A research model for wrong blood in tube error detection based on complete blood count results using the extreme gradient boosting algorithm

## Description
This project makes available an xgboost model to facilitate further research into the use of machine learning for for WBIT error detection. 

The model requires patients' current CBC results as well as previous CBC results (collected up to 6 days prior). 


## Getting Started
The file 'example_data.rds' provides a small data set of simulated values formatted as expected by the pre-processing recipe and with parameters in the order 
expected by the model.

The file 'prepped_imputation_recipe.rds' provides the pre-processing imputation recipe ready for 'baking' with the 'recipes' package.

'run_model.R' example R script for running the model identification of possible WBIT errors .

### Dependencies
The following libraries are used: tidyverse, recipes, xgboost

### Data

The following inputs, all formatted as numeric values, are used by the model:

- 'male': 1 if patient is male, 0 if patient is female
- 'age': patient age in years
- 'current_hb': hemoglobin (units: g/L) result in current sample 
- 'current_wcc': white cell count (10^9^/L) in current sample
- 'current_plt': platelet count (10^9^/L) in current sample
- 'current_rcc': red cell count (10^12^/L) in current sample
- 'current_hct': hematocrit (L/L) in current sample
- 'current_mcv': mean cell volume (fL) in current sample
- 'current_mch': mean cell hemoglobin (pg) in current sample
- 'current_rdw': red cell distribution width (%) in current sample
- 'current_lym': lymphocyte count (10^9^/L) in current sample
- 'current_eos': eosinophil count (10^9^/L) in current sample
- 'current_mpv': mean platelet volume (fL) in current sample
- 'current_plt': platelet distribution width (%) in current sample
- 'last_hb': hemoglobin (units: g/L) result in previous sample 
- 'last_wcc': white cell count (10^9^/L) in previous sample
- 'last_plt': platelet count (10^9^/L) in previous sample
- 'last_rcc': red cell count (10^12^/L) in previous sample
- 'last_hct': hematocrit (L/L) in previous sample
- 'last_mcv': mean cell volume (fL) in previous sample
- 'last_mch': mean cell hemoglobin (pg) in previous sample
- 'last_rdw': red cell distribution width (%) in previous sample
- 'last_lym': lymphocyte count (10^9^/L) in previous sample
- 'last_eos': eosinophil count (10^9^/L) in previous sample
- 'last_mpv': mean platelet volume (fL) in previous sample
- 'last_plt': platelet distribution width (%) in previous sample

### Preprocessing

Mean imputation of missing values for the CBC parameters is suggested. This can be performed using 'prepped_imputation_recipe.rds', which will impute the mean
values from the data used to train the model.The recipe expects the parameter names above to be used, it also expects patient sex and age to be available and 
will not impute values for these parameters. 

The model uses calculated delta values for all CBC parameters. It is recommended that the script provided in 'run_model.R' is used for these calculations to ensure
that the parameters are provided to the model in the expected order. As occurs in the 'run_model.R' script, delta values should be calculated after imputation to avoid
missing values among the deltas parameters.


### Running the model

The model can then be used to generate predicted probability of WBIT error for the preprocessed data by simply calling the function predict(). See 'run_model.R'. 


## Acknowledgements

The author wishes to acknowledge the valuable assistance of the Transfusion and Haematalogy departments at Nepean Hospital Sydney, in the preliminary evaluation of this model. In particular, Charles Makuni, John Giannoutsos, Aaron Keenan, Ellena Maeder and Gareth Davies.


## Author

Chris Farrell

christopherjohn.farrell@health.nsw.gov.au 
