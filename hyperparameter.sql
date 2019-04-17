create database if not exists hyperparameter;
use hyperparameter;
#

# a table store the id and the name of each dataset
drop table if exists data_repository;
create table if not exists data_repository(
	dataset_id int primary key auto_increment,
    dataset_name text not null
);

# each dataset have a metadate file
drop table if exists metadata;
create table if not exists metadata(
	dataset_id int not null,
    method text not null,
    target text not null ,
    #predictor_id int not null,
    metadata_columns int not null,
    metadata_rows int not null,
    runtime_id int primary key,
    constraint metadata_fk foreign key (dataset_id) references data_repository(dataset_id)
);

# for each predictor_id, we will have several predictors
drop table if exists predictors;
create table if not exists predictors(
	dataset_id int not null,
    predictor_name varchar(255) not null,
    constraint predictor_pk primary key (dataset_id,predictor_name),
    constraint predictor_fk foreign key (dataset_id) references metadata(dataset_id)
);
# mid_table, to link runtime with model_id. each runtime have several models

/*drop table if exists run_models;
create table run_models(
	runtime_id int not null,
	model_id int not null,
    constraint run_models_pk primary key (runtime_id,model_id),
    constraint run_models_fk foreign key (model_id) references models(model_id)
);    */


# for each run_id, we will generate several models.

drop table if exists models;
create table models(
	runtime_id int not null,
	model_id int not null,
    model_name text NOT NULL,
    constraint models primary key (runtime_id,model_id),
    constraint runtime_fk foreign key (runtime_id) references metadata(runtime_id)
);    

# create a table to store the measurement
drop table if exists measurement;
create table measurement(
	runtime_id int not null,
    measurement_name varchar(255) NOT NULL,
    measurement_value double not null,
	constraint measurement_pk primary key (runtime_id,measurement_name),
    constraint measure_fk foreign key (runtime_id) references models(runtime_id)
);

drop table if exists hyperparameters;
create table hyperparameters(
	runtime_id int not null,
    hyperparameters_name varchar(255) NOT NULL,
    hyperparamter_default double not null,
    hyperparameter_actual double not null,
	constraint hyperparameters_pk primary key (runtime_id,hyperparameters_name),
    constraint hyper_fk foreign key (runtime_id) references models(runtime_id)
);
/*
#ALTER TABLE iteration2_500
#drop dataset_id;

ALTER TABLE iteration2_500
ADD dataset_id text;

UPDATE iteration2_500
SET dataset_id = 1;

select * from iteration2_500;
describe iteration2_500;
insert into models(model_name,mrd,rmse,mse,mae,rmsle,dataset_id)
select * from iteration2_500;
select * from models;
##*/


