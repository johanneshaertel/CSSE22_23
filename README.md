# Capita Selecta of Software Engineering (2022/2023)

The repository hosts the supplementary
resources, developed in the lab-sessions of CSSE,
at VUB Brussels.

## Lab-Session 1 (11/22/2022)

We discuss and implement different ways of
accessing data from GitHub, using its native (search) API.
The Python scripts, developed in the session, 
can be found in this
[folder](lab1). The last python [script](lab1/github_api4.py) 
uses advanced search functionality, and requires you to
have a `config.py` file, with a variable `token` set to
one of your GitHub tokens. This is needed for reasons 
of rate limitations.

## Lab-Session 2 (6/12/2022)

Skipped.

## Lab-Session 3 & Assignment 1 (20/12/2022)

This lab-session, and the assignment introduced in the lab-session, 
requires building a data set for defect prediction.
We limit the data set to repositories with *Java* as the primary programming language,
and use [PyDriller](https://pydriller.readthedocs.io/) for implementing
the extraction.

This lab-session will start with the basics on this task.
The upcoming assignment requires extracting **additional metrics**,
and to run your extraction 
for **additional repositories**. You are **allowed to use the code developed
in the lab-session**. You need to extend it for the submitted assignment.

The following repositories need to be analyzed
(the lab-session is limited to the first repository):

| Repository                       | Part of                  |
|----------------------------------|:-------------------------|
| https://github.com/apache/aries  | Assignment + Lab-session |
| https://github.com/apache/falcon | Assignment               |
| https://github.com/apache/ranger | Assignment               |
| https://github.com/apache/sqoop  | Assignment               |
| https://github.com/apache/whirr  | Assignment               |

Extract the following set of metrics for each repository (the lab-session is limited to the first metric):

| ID  | Descripton                                                                                                                                                             | Part of          |
|-----|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------|
| LOC | Number of lines of code in artifact `a`, at the commit `c` which is closes to the end of time window `w` (before the end of `w`, but not necessarily included in `w`). | Assignment + Lab-session |
| CC  | Cyclomatic complexity (in analogy to LOC).                                                                                                                             | Assignment       |
| NC  | Number of commits changing artifact `a` over time window `w`.                                                                                                          | Assignment       |
| BUG | Number of future defects (according to SZZ) in artifact `a` detected after time window `w`.                                                                            | Assignment|
| DEV | Number of distinct developers who changed artifact `a` in time window `w`.                                                                                             | Assignment       |

You are supposed to **follow these guidelines**:

1. **Test-repository:** Create a public GitHub repository
on which your implementation of the extraction can be tested.
Create tests for the relevant technical parts of your extraction (each metric), 
by faking a small Java project in your test-repository.

2. **Structure the data:** Defect data is often structured
according to a subject repository's artifacts `a`, commits `c`,
and time windows `w`. All extracted metrics are specific
to a time window and an artifact. LOC and CC can also be associated
with the last commit before the end of a time window `c`.
Persist your metrics into a CSV file,
including a column for each metric (LOC, CC, NC ...), and a column for the time 
window `w`, the artifact path `a`, and for the last commit `c` in the
time window, give by the SHA. As an optional task, you may also
add an ID of the top contributing developer (e.g., the mail address)
within a time window to a particular artifact.

3. **Setting the window:**
Introduce a parameter that decides on
the time window for your extraction. Specify the parameter so that 
your extraction also works for big
repositories.
Fine window granularity might be accurate but slow.

5. **Plot the data (Lab-session only):** A first and simple way to understand your data is
plotting it. Take your extracted CSV file and plot the LOC metrics over
the time in a line or scatter-plot. You may take the [matplotlib](https://matplotlib.org/) library. 
The structure of the data might
cause problems. Since showing all artifacts may be visually overwhelming. Consider
alternatives, like plotting the LOC metrics for some artifacts over time, 
or using aggregation, plotting the total LOC.

6. **Identify Defects:** Implement a simplistic version
of the SZZ algorithm. Detect if a commit has been fixing an artifact 
by looking at the commit messages using
a regex like the following:

- fix(e[ds])?[ \t]*(for)[ ]*?(bugs?)?(defects?)?(pr)?[# \t]*
- patch(ed)?[ \t]*(for)[ ]*?(bugs?)?(defects?)?(pr)?[# \t]*
- (\sbugs?\s|\spr\s|\sshow_bug\.cgi\?id=)[# \t]*

The **deliverables of the assignment** include the scripts to
extract the data sets for all repositories, the
data sets for the repositories as CSV, and a README.md with
a brief documentation of your extraction.

The deliverables must be uploaded to Canvas as a **zip archive**.
Stick to the following **top-level file structure** of the zip:
- `scripts` folder (the python program run the extraction)
- `data` folder (the 5 data sets for a time window of your choice)
- `README.md` (describing your approach)

Code quality (clarity) and your tests may be considered in the 
evaluation. The deadline for the assignment is the **26th of June 2022**.

## ...
