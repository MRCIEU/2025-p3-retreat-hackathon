import random
from pathlib import Path
from pprint import pprint, pformat

import yaml
from pydash import py_

PATH_TO_SETTINGS = Path(".") / "settings.yml"
PATH_TO_ALLOCATION = Path(".") / "allocation.txt"


def allocate_people_to_groups(people, num_groups):
    # Shuffle the list of people to ensure random distribution
    random.shuffle(people)

    # Create empty groups
    groups = [[] for _ in range(num_groups)]

    # Distribute people into groups
    for i, person in enumerate(people):
        groups[i % num_groups].append(person)

    return groups


def main():
    # load settings
    assert PATH_TO_SETTINGS.exists(), f"Settings file not found at {PATH_TO_SETTINGS}"

    with open(PATH_TO_SETTINGS, "r") as f:
        settings = yaml.safe_load(f)

    num_groups = settings["params"]["num_groups"]
    seed = settings["params"]["seed"]
    random.seed(seed)

    # allocate group 1
    group1 = allocate_people_to_groups(settings["attendee_group1"], num_groups)

    # allocate group 2
    group2 = allocate_people_to_groups(settings["attendee_group2"], num_groups)

    # allocate projects
    projects = allocate_people_to_groups(settings["projects"], num_groups)

    # combine allocation
    alloc = []
    for _ in zip(group1, group2, projects):
        team = py_.flatten(_[:2])
        proj = _[2]
        item = {
            "team": team,
            "proj": proj,
        }
        alloc.append(item)
    pprint(alloc)

    # write allocation to file
    with PATH_TO_ALLOCATION.open("w") as f:
        f.write(pformat(alloc))


if __name__ == "__main__":
    main()
