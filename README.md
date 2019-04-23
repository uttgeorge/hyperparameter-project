# Hyperparameter Project on Mushroom Dataset



## Left:
4. ER diagrams
5. Normalization(till 3NF)
6. Physical model
7. 10 use cases per person
8. 5 views per person
9. 5 procedures per person
10. 5 functions per person
11. 5 indexes per person
12. Analytics
13. Conclusion
14. Professionalism and Report
15. Citations and References
16. License

## 1. Abstract
The project is a part of skunksworks hyperparameters project. First part is to create a database that stores the gilled mushrooms in the Agaricus and Lepiota Family, and second part is to store evalutions and hyperparameters that used to perform algorithms on mushroom data in part one.

## 2. Explain Data Source
This dataset is from UCI Machine Learning Repository, including descriptions of hypothetical samples corresponding to 23 species of gilled mushrooms in the Agaricus and Lepiota Family Mushroom drawn from The Audubon Society Field Guide to North American Mushrooms (1981). Each species is identified as definitely edible, definitely poisonous, or of unknown edibility and not recommended. This latter class was combined with the poisonous one. The Guide clearly states that there is no simple rule for determining the edibility of a mushroom; no rule like "leaflets three, let it be'' for Poisonous Oak and Ivy.

## 3. Conceptual Schema
The conceptual schema [ERD](https://github.com/uttgeorge/hyperparameter-project/blob/master/SQL/Conceptual_Model/ERD.pdf) is in SQL folder.\
This schema have five major parts:\
**1.** data_repository: It stores dataset ids and names;\
**2.** predictors: It stores all predictors for each dataset;\
**3.** metadata: It stores data like run_id, run_time and others that models are based on;\
**4.** models: For each run_id, there are several different models, each model has an unique performance;\
**5.** Hyper Parameters: In this database, we store hyper parameter not in a single table, but in several different tables separated by their algorithms.

## 4. ER diagrams
Mentioned in 3. Conceptual Schema.

## 5. Normalization(till 3NF)
