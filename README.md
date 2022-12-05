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

Having set up a way to find repositories on GitHub that
fulfil a certain search criteria (in the previous lab session),
this lecture focuses on the in-depth extraction of data from repositories 
for defect prediction.
We focus on repositories with *Java* as primary programming language
and use [PyDriller](https://pydriller.readthedocs.io/) for implementing
the extraction.

In the lecture, we (students) are supposed to implement/produce the following
parts of a technical data extraction:

1. **Create a test-repository:** Create a public test repository on GitHub,
on which the implementation of the following extraction can be checked.
Create tests for the relevant technical parts, 
by faking a small Java project and committing it to the repository.
You may decide later on what you want to commit to this repository as
test cases for your data extraction.

2. **Structure the data extraction:** Defect data is often structured
according to a subject repository's artifacts (files/classes)
and the time. Hence, all your extracted metrics are specific
to a time window and an artifact.
Implement your first extraction of the LOC
metrics for Java files, for a time windows of 1 minute. Test this implementation
on your test repository.
Persist your metrics into a
CSV file, including a column for the LOC metric, the time and the artifact (file) identification.

3. **Make it scale:** Apply your processing to a bigger
[repository](https://github.com/apache/aries).
Fine granularity by computing metrics at a small time windows
might be preferred. However, this might not scale. 
Introduce a parameter that decides on
the time window for your extraction. Specify the parameter so that 
the extraction also works for such big
repository. Run the processing and extract the CSV for the repository.

4. **Plot the data:** A first and simple way to understand your data is
plotting it. Take your extracted CSV file and plot the LOC metrics over
the time in a line or scatter-plot. You may take the [matplotlib](https://matplotlib.org/) library. 
The structure of the data might
cause problems. Since showing all artifacts may be visually overwhelming, consider
alternatives, like plotting the LOC metrics for some artifacts over time, 
or using aggregation, plotting the total LOC.

5. **Identify Defects:** Implement a simplistic version
of the SZZ algorithm. Detect how many added lines, introduced by a commit in
the time window for a given artifact, are bug-inducing, and how many are not.
Use a simplistic version, just looking at the commit messages for
common natural language patterns that indicate on a fix (e.g., like a message containing fix).
Test your implementation on the test-repository. Hereafter, let it run on our real example
[repository](https://github.com/apache/aries).
Plot the number of fixes over time.

The first official assignment will be an extended version of the content of this lab session.

## Lab-Session 3 (20/12/2022)

## ...