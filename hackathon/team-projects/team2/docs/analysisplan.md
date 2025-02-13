# Analysis plan

## Initial planning/brainstorming

1. Descriptive statistics
2. Defining the research question
3. Set up a research protocol
4. Which variables are important
5. Definition of cut off under the 55 and over 55 year olds
6. Heart attack among the under 55 vs over 55 years

## Repo structure and task list

- [x] Readme file
- [x] License
- [x] Docs folder
	- [] Analysis plan
	- [] Presentation
- []scripts
- [] data -raw and derived
- [] Figures
- [] Merge scripts at the end of it

## Research questions

1. What are the most predictive features of heart attack, and how do these differ between young and old people in South Africa?
2. Is an age-specific heart attack predictor necessary to take into account potential aetiological differences in heart attacks between old and young people in South Africa?

## Analyses

The team agreed to split into two sub-groups that would carry out different analyses in parallel. The first of these considers the associations between variables and heart attack whilst the second attempts to build effective prediction models. Due to time constraints, the feature selection in the second of these projects and the regression analyses in the first of these projects are not intended to inform each other.

### Observational analyses

Each analysis below will be conducted in people less than 55 years old (*young*), people 55 years and older (*old*) and the overall (*overall*) dataset.

1. Analyse and visualize pairwise correlation across all potential risk factors
2. Univariable regression analysis for each risk factor to identify those that are associated with heart attack outcome
3. Multivariable regression analysis of all associated risk factors from step 2 to estimate the magnitude of their association with heart attack
4. Evaluate difference in "effect sizes" of risk factors between *old*, *young* and *overall*  

### Prediction modeling

1. Split data into people under 55, and those 55 and older, and split each of these into a training and test dataset
2. Develop a prediction model (*youngpredict*) using LASSO regression for people less than 55 years old (*young*)
3. Develop a prediction model (*oldpredict*) using LASSO regression for people 55 years and older (*old*)
4. Test *youngpredict* in the *young* test dataset
5. Test *youngpredict* in the *old* test dataset
6. Test *oldpredict* in the *old* test dataset
7. Test *oldpredict in the *young* test dataset
8. Evaluate differences in predictive performance between these models to determine whether age-specific predictors are necessary

