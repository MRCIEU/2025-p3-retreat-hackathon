# 2023 IEU programme 3 away day

14 June 2023, 09:00 – 17:00 

Engineers House, The Promenade, Clifton Down, Clifton, Avon, Bristol BS8 3NB 

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
- [2023 IEU programme 3 away day](#2023-ieu-programme-3-away-day)
    - [Agenda](#agenda)
    - [Under the surface: the hidden me](#under-the-surface-the-hidden-me)
    - [Hackathon (afternoon)](#hackathon-afternoon)
    - [Group projects](#group-projects)
    - [Presentation](#presentation)
    - [Project pool](#project-pool)
<!-- markdown-toc end -->


## Agenda 

| 09:00-09:30 | Arrive, tea/coffee, set-up |
| 09:30-10:45 | Under the surface: the hidden me – part 1 (see below) |
| 10:45-11:00 | Tea/coffee break |
| 11:00-12:15 | Under the surface: the hidden me – part 2 (see below) |
| 12:15-13:00 | Lunch |
| 13:00-17:00 | Hackathon (see below) |

## Under the surface: the hidden me 

Each attendee is asked to give a 4 slide, 5-minute presentation about themselves comprising: 

- **Slide 1: who I am** – *your mini-autobiography, personal and/or academic* 
- **Slide 2: my research motivations** – *what excites you about research? What would you like to do in the future?* 
- **Slide 3: my next big challenge** – *research, career and/or personal challenges* 
- **Slide 4: a haiku or other artistic summary of my research** – *summarise what you are doing at the moment in an interesting an artistic way. Think about whether this would communicate the essence of your research to a non-expert audience.* 

The purpose of these presentations is to help others to get to know you a little better, and an opportunity to boast about other achievements in your life! 

## Hackathon (afternoon) 

13:00 – 17:00 

Organisers: Yi Liu, Andrew Elmore, Hayley Wragg 

| 13:00-13:30 | Assign Groups & Group Changes |
| 13:30-14:00 | Group planning |
| 14:00-15:30 | Group Work |
| 15:30-16:00 | Finalise/ Combine ideas |
| 16:00-17:00 | Presentations |

## Group projects 

At 13:00 we will randomly allocate all attendees (including the organisers and Tom) to 4 groups with roughly equal sizes, where each group will be presented with a project randomly picked from the project pool (see below). This random allocation will be done via a script in the github repo. After the allocation, members in a group can choose to switch places with people in other groups, as long as there is a sensible switch available.  

We expect people to self-organise during the group work, in terms of the direction and division of labour.  If there is a dataset associated with a project, the dataset as well as sufficient documentation will be placed under a folder in the DMER group sharepoint site (https://uob.sharepoint.com/:f:/r/teams/grp-ieu-dmer_prog/Shared%20Documents/Social/2023-06-15-prog3-away-day/away-day-hackathon/materials?csf=1&web=1&e=gBVKHX). The organiser who suggested a specific project will be happy to offer further clarification and explanation on the project. 

We would expect the group allocation and organisation as well as the initial discussions on the project to take half an hour (13:00 – 13:30), and people can use two hours (13:30 – 15:30) for the group work, and the final half hour (15:30 – 16:00) to wrap up and finalise a presentation. Within groups there may be different members working on different tasks, this final half hour will be a good time for the members to come back together to discuss how they have all got on. We encourage the group members to be mindful of the time constraints and the outcomes they can meaningfully achieve during the hackathon. 

## Presentation 

We do not require a formal presentation. Groups can share their screen of what they’ve been doing or use slides if they prefer. The primary aim is to share ideas with the rest of the group.  

Each group will be given 15 minutes to present their work, including 10 minutes to talk and 5 minutes Q&A.  

## Project pool 

### 1. Analysis of Breast Cancer Literature Data 

Suggested by: Yi 

Data source https://huggingface.co/datasets/Gaborandi/breast_cancer_pubmed_abstracts 

Task guideline (you don’t need to follow): 

- Some exploratory data analysis 
- Some stories to tell from the data 

### 2. Analysis of Clinical Trial Literature Data 

Suggested by: Yi 

Data source: https://huggingface.co/datasets/Kira-Asimov/gender_clinical_trial/viewer/Kira-Asimov--gender_clinical_trial/train?p=0 

Task guideline (you don’t need to follow): 

- Some exploratory data analysis 
- Some stories to tell from the data 

### 3. Analysis of Alzheimer Disease and Health Aging Data 

Suggested by: Yi 

Data source: https://www.kaggle.com/datasets/ananthu19/alzheimer-disease-and-healthy-aging-data-in-us?resource=download 

Task guideline (you don’t need to follow): 

- Some exploratory data analysis 
- Some stories to tell from the data 

### 4. Analysis of Diabetes Health Indicators Data 

Suggested by: Yi 

Data source: https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset 

Task guideline (you don’t need to follow): 

- Some exploratory data analysis 
- Some stories to tell from the data 

### 5. Green Algorithms investigation 

Suggested by: Hayley 

https://www.green-algorithms.org/ 

Task ideas: 

- Compare the carbon footprint across common MR implementations using small test datasets. 
- Forecast the carbon footprint for a larger scale. 

### 6. Reproducible and Reusable Pipelines 

Suggested by: Andrew 

Let’s stop reinvesting the wheel: Create shared, reusable code and steps 

Task ideas: 

- Identify common problems we have independently have to solve 
    - Multi-Ancestry Analysis 
    - Polygenic Scores 
    - Others for future consideration: 
        - Common GWAS / Summary Stats helper functions 
        - Bias Corrections 
- Sensitivity Analyses 
- Create reusable code functions that you probably have already written for yourself, so they can be shared, upload to shared public repo. 
    - Use containers to house all packages and tools 
    - Put those steps into a pipeline (snakemake) with common inputs and outputs 
    - Document common pipeline steps, along with gotchas and pitfalls 
    - Output results automatically into a digestible document to look at 
