# Hyperparameter Project on Mushroom Dataset



## Left:
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
#### 1NF
**Requirement:**
1. No repeating groups
2. Atomic
3. Each field has a unique name
4. Primary key
#### 2NF
**Requirement:**
1. Already 1NF
2. No partial dependencies
3. No calculated data
#### 3NF
**Requirement:**
1. Already 2NF
2. No transitive dependencies

*Table 1: data_repository*
>This table have one primary key(dataset_id), and one non-key attribute.
>It is in 3NF.

*Table 2: predictors*
>This table have a primary key consist tow parts(dataset_id,predictor_name), and no non-key attribute.
>It is in 3NF.

*Table 3: metadata*
>This table have a primary key(run_id), and several non-key attributes.
>All non-key attributes are based on and only on primary key.
>It is in 3NF.

*Table 4: models*
>This table have a primary key(model_id), and several non-key attributes, eg. measurements.
>All non-key attributes are based on and only on primary key.
>It is in 3NF.

*Table 4: Hyper-parameter*
>There are 7 tables have 7 primary keys, they are all unique.
>All non-key attributes are based on and only on primary key.
>It is in 3NF.

## 6. Physical model

### *6.1 Create Tables*
##### Create Database
Database called hyperparameter
```mysql
create database if not exists hyperparameter;
use hyperparameter;
```

##### Create data_repository table 
A table to store the id and the name of each dataset

```mysql
drop table if exists data_repository;
create table if not exists data_repository(
	dataset_id int primary key auto_increment,
    dataset_name text not null
);
```
##### Create predictors table
For each predictor_id, we will have several predictors

```mysql
drop table if exists predictors;
create table if not exists predictors(
	dataset_id int not null,
    predictor_name varchar(255) not null,
    constraint predictor_pk primary key (dataset_id,predictor_name),
    constraint predictor_fk foreign key (dataset_id) references data_repository(dataset_id)
);
```

##### Create metadata table
For each dataset,there are several meta data, including run time, run id.
```mysql
drop table if exists metadata;
create table if not exists metadata(
	dataset_id int not null,
    run_id varchar(255) primary key,
    min_mem_size int not null,
    scale text not null,
    target text not null ,
...
    constraint metadata_fk foreign key (dataset_id) references data_repository(dataset_id)
);
```
##### Create models table
For each run id, we will generate several models with their performance respectively.
```mysql
drop table if exists models;
create table models(
	run_id varchar(255) not null,
	model_id varchar(255) not null,
	auc double default null,
    logloss double default null,
    mean_per_class_error double default null,
    rmse double default null,
    mse double default null,
    model_category varchar(255) not null,
    constraint models primary key (model_id(255)),
    constraint models_fk foreign key (run_id) references metadata(run_id)
);    
```
##### Create hyper parameter table.
We seperate hyper parameter table into 7 tables, each table corresponding to a algorithm. We take GBM as an example.
```mysql
drop table if exists GBM_model;
CREATE TABLE IF NOT EXISTS GBM_model (
  GBM_model_id VARCHAR(255) NOT NULL,
  # True means actual, False means default
  actual_or_default varchar(25) default false,
 
  `learn_rate` DOUBLE NULL DEFAULT NULL,
  `fold_column` TEXT NULL DEFAULT NULL,
  `col_sample_rate_per_tree` DOUBLE NULL DEFAULT NULL,
...
  `ignore_const_cols` TEXT NULL DEFAULT NULL,
  `keep_cross_validation_fold_assignment` TEXT NULL DEFAULT NULL,

  PRIMARY KEY (GBM_model_id,actual_or_default),
  CONSTRAINT GBM_model_fk FOREIGN KEY (GBM_model_id) REFERENCES models (model_id)
);
```
### *6.2 Import Data*

1. data_repository 
```mysql
INSERT INTO data_repository(dataset_name)
VALUES ( 'mushroom');
```

2. predictors
```mysql
INSERT INTO predictors
VALUES
( '1','cap-shape'),
( '1','cap-surface'),
( '1','cap-color'),
( '1','bruises'),
( '1','odor'),
( '1','gill-attachment'),
( '1','gill-spacing'),
( '1','gill-size'),
( '1','gill-color'),
( '1','stalk-shape'),
( '1','stalk-root'),
( '1','stalk-surface-above-ring'),
( '1','stalk-surface-below-ring'),
( '1','stalk-color-above-ring'),
( '1','stalk-color-below-ring'),
( '1','veil-type'),
( '1','veil-color'),
( '1','ring-number'),
( '1','ring-type'),
( '1','spore-prstring-color'),
( '1','population'),
( '1','habitat');
```
3. metadata
```mysql
INSERT INTO metadata
VALUES 
(1,'JjUS31JGhX',6,'FALSE','class','TRUE',0,1555694048,'',1555694048,1,200,100,'FALSE',0.2),
(1,'2Rr6eu3vHP',6,'FALSE','class','TRUE',0,1555747273,'',1555747273,1,400,100,'FALSE',0.2),
(1,'utthNoQEU0',6,'FALSE','class','TRUE',0,1555756193,'',1555756193,1,800,100,'FALSE',0.2),
(1,'KPiL6NvWlS',6,'FALSE','class','TRUE',0,1555749638,'',1555749638,1,600,100,'FALSE',0.2),
(1,'fICT1DYlnK',6,'FALSE','class','TRUE',0,1555757937,'',1555757937,1,1000,100,'FALSE',0.2);
```

4. models
```mysql
INSERT INTO models
VALUES 
('JjUS31JGhX','GBM_1_AutoML_20190419_130933',1,1.51e-17,0,9.1e-16,8.28e-31,'GBM'),
('JjUS31JGhX','GBM_4_AutoML_20190419_130933',1,2.09e-16,0,0.0000000000000137,1.87e-28,'GBM'),
...
('fICT1DYlnK','XRT_1_AutoML_20190420_055921',0.995574938,0.277252845,0.020705733,0.291090532,0.084733698,'XRT'),
('fICT1DYlnK','DeepLearning_grid_1_AutoML_20190420_055921_model_5',0.994419071,0.125295746,0.015346759,0.118260271,0.013985492,'DeepLearning');
```
