from pydriller import Git
import pandas as pd

# A working prototype of the extraction of LOC metric. This needs to be extended.
git = Git("C:/temp/repos/aries")

results = pd.DataFrame()

i = 0
for commit in git.get_list_commits(rev="a816658ea780d07f7a413f7536062a78da795ebe"):

    # Every 1000 revisions we end the window and store the metrics.
    i = i + 1
    if i % 1000 == 0:
        print(commit.hash)
        git.checkout(commit.hash)

        for file in git.files():
            if file.endswith(".java"):
                total = 0
                with open(file, encoding="latin-1") as f:
                    total = total + len(f.readlines())

                result = pd.DataFrame({
                    "metric": ["LOC"],
                    "value": [total],
                    "time": [i],
                    "sha": [commit.hash],
                    "file": [file]})

                results = pd.concat([results, result])

# Results as collected previously.
print(results)

# Changing data to conform to assignment.
results_b = results.pivot_table(index=["file", "time", "sha"], columns="metric", values="value", aggfunc="first")

print(results_b)
