from pathlib import Path
from pprint import pprint, pformat
from pydash import py_
import pandas as pd

PATH_PROJECTS = Path(".") / "projects.csv"
PATH_ATTENDEES = Path(".") / "attendees.txt"
PATH_OUTPUT = Path(".") / ".." / "allocation_results.txt"
NUM_GROUPS = 4


def main():
    assert PATH_PROJECTS.exists()
    assert PATH_ATTENDEES.exists()

    print("Start allocation")

    project_df = pd.read_csv(PATH_PROJECTS)
    print(project_df)
    project_df = project_df.reset_index(drop=False)
    with PATH_ATTENDEES.open() as f:
        people = [_ for _ in f.read().strip().split("\n") if not _.startswith("#")]
    print(f"Number of people today {len(people)}")

    nominators = project_df["nominator"].drop_duplicates().sample(frac=1).tolist()
    people1 = (
        py_.chain(people)
        .filter(lambda e: e not in nominators)
        .shuffle()
        .thru(lambda l: [l[i::NUM_GROUPS] for i in range(NUM_GROUPS)])
        .value()
    )

    people_nested = []
    for idx in range(len(nominators)):
        new_group = (
            py_.chain(people1[idx])
            .thru(lambda l: l + [nominators[idx]])
            .shuffle()
            .value()
        )
        people_nested.append(new_group)

    proj_pool = project_df["index"].tolist()
    project_list = project_df.drop(columns=["index"]).to_dict(orient="records")
    fixed_proj = []
    for nominator in nominators:
        proj = (
            project_df[project_df["nominator"] == nominator]["index"]
            .sample(frac=1)
            .tolist()[0]
        )
        fixed_proj.append(proj)

    additional_proj = []
    for nominator in nominators:
        avail_proj = [
            _ for _ in proj_pool if _ not in fixed_proj and _ not in additional_proj
        ]
        proj = py_.chain(avail_proj).shuffle().value()[0]
        additional_proj.append(proj)

    allocation = []
    for idx in range(NUM_GROUPS):
        group = {
            "group": idx + 1,
            "initial_members": people_nested[idx],
            "project_option_1": project_list[fixed_proj[idx]],
            "project_option_2": project_list[additional_proj[idx]],
        }
        allocation.append(group)
    pprint(allocation)

    output_res = pformat(allocation)
    with PATH_OUTPUT.open("w") as f:
        f.write(output_res)

    print("Done allocation")


if __name__ == "__main__":
    main()
