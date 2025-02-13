## Setup

```bash
#Clone the Repo (use https if necessary)
git@github.com:MRCIEU/2025-p3-retreat-hackathon.git
cd 2025-p3-retreat-hackathon/hackathon/team-projects/team1

#Create the Conda Environment
conda env create -f environment.yml
conda activate team_1
```

## Instruction
You can run each rule one after the other or run it at once with

```bash
snakemake -c 1
```


## Data download: Execute this scriop to download the data
```bash
snakemake -c 1 download_data
```

