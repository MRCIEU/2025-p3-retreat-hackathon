#!/bin/bash
curl -L -o data/breastcancerproteomes.zip\
  https://www.kaggle.com/api/v1/datasets/download/piotrgrabo/breastcancerproteomes

unzip data/breastcancerproteomes.zip -d data/raw/

rm data/breastcancerproteomes.zip