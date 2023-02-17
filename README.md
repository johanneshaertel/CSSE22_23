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

| ID  | Description                                                                                                                                                             | Part of          |
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
evaluation. The deadline for the assignment is the **26th of June 2023**.

## Lab-Session 4 (14/2/2023)

In this session, we will demonstrate how to build a small classifier manually.
We will rely on a basic grid-search for parameters. We will also show some advanced methods
on how to continue from such basic classifier.
We will only use simulated data, i.e., feature and defects
produced by random number generators. This helps to assure that our
implementation is correct. As output, we will
produce a function that is capable to predict defects using the features.
Keep in mind that the function will not work in reality, since
we fitted it on simulated "fake" data. However, we can now easily
take our model fitting code and run it on real data.

We split the demonstration into three parts.

- We start implementing a simple logistic regression classifier, not using any features.
Code can already be found [here](lab4/tutorial_1.py).

- We add one features that is used as a predictor. Code can be found [here](lab4/tutorial_2.py).

- Finally, we reuse a python library to build the same classifier. Code can be found [here](lab4/tutorial_3.py).

We will also go through a series of options to implement such classifier for realistic problems.
We show a list of visual demos. The code for the demos does not need to be understood.

- We show a visual introduction to **grid-search**. It  corresponds to the solutions
that we have previously implemented in the first part of the tutorial. This solution 
is inefficient.
Code can be found [here](lab4/demo1_grid_nonlog.R) and [here](lab4/demo2_grid_log.R).

- We show a visual introduction to **maximum likelihood estimation**, and how to get
insights on the shape of the likelihood by quadratic approximation.
Code can be found [here](lab4/demo3_ml_hill_log.R), [here](lab4/demo4_ml_curvature_log.R) and
[here](lab4/demo5_ml_curvature_nonlog.R).

- We show a visual introduction to **Metropolis Hastings**.
Code can be found [here](lab4/demo6_metropolishastings_unlog.R) and [here](lab4/demo4_ml_curvature_log.R).

- We show a visual introduction to **Hamiltonian Monte Carlo**.
Code can be found [here](lab4/demo7_hamiltonian_log.R) and [here](lab4/demo8_hamiltonian_fast_log.R).

## (DRAFT) Lab-Session 5 and Assignment 2 (20/2/2023)

In the second assignment, you need to find out if *data balancing* techniques are worth the effort.
In a nutshell, you need to train a classifier on data sets and
evaluate the classifier's performance using different performance metrics. However, the classifier must be trained
on a balanced and on an unbalanced version of the data. Cross-validation practice should be followed rigorously to 
prevent over- and under-fitting. 

### Experiment:

The following steps describe the process in detail:

- Do the following for all datasets.
  - Scale the features of the data set. For each feature, apply one of the most common ways of normalization, i.e.,
    - subtracting the mean
    - and dividing by the standard deviation.
  - Split the data set into test and train set multiple times. 
    - From now on, fitting the model and evaluation of prediction
    needs to be strictly separated.
    - Explore the two alternatives (keep in mind that the test set keeps as it is):
      - Apply a class balancing technique to the train set.
      - Keep the train set as it is.
    - Train the classifiers on the train set.
    - Evaluate the classifier on the test set using the performance metrics.

The following **data sets** need to be used. The data can be found [here](lab5/data).
- There are five data set of real systems, i.e., ant, camel, jedit, log4j and lucene.
- There are three simulated data sets, one with low, one with balanced, and one with high
relative defect count.

The following **performance metrics** should be explored:
- Precision
- Recall
- Accuracy
- Matthew Correlation Coefficient (MCC)
- F-Measure
- Relative entropy or Kullback–Leibler divergence.

Keep in mind that the relative entropy is a metric between probability distributions, so
you need to use the probabilities given by the logistic regression. For sklearn's logistic regression
you may need to change `predict` to `predict_proba`.

The **balancing technique** that you should use is:
- No balancing.
- Synthetic Minority Over-sampling Technique [(SMOTE)](https://imbalanced-learn.org/stable/over_sampling.html#from-random-over-sampling-to-smote-and-adasyn)

The **classifier** that you should use is:
- Logistic Regression

### Results:

We recommend storing the results in a single dataframe, with columns storing:
- the name of the dataset,
- the name of the used balancing technique,
- the name of the performance metric 
- the value of the performance metrics
- a running index for each split in the cross-validation

### Discussion:

After producing the results, visualize it appropriately, and draw a
conclusion for the experiment, explaining if this experiment provides any
evidence for recommending balancing. Try to consider the relative number of defects
in a dataset in our interpretation.

### Deliverables

The deliverables must be uploaded to Canvas as a zip archive. 
Assure that the following artifacts are included in your submission (you may submit a notebook if you like):

- **scripts** needed to run your experiment. 
- **data** that is the result of your experiment with understandable naming as CSV
- **plots** that you created
- **interpretation** of your resulting data.

The deadline for the assignment is the 26th of June 2023.