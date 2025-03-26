--create and load the data from bigquery public dataset stackoverflow. size - 29gb

create table if not exists pavankumar123.partition_sales as select * FROM bigquery-public-data.iowa_liquor_sales.sales
   

--creating new table with partition  with creation_date cloumn.  
 CREATE TABLE
 pavankumar123.stack_data_partition ( 
 id INTEGER,
 title STRING,
 body STRING,
 accepted_answer_id INTEGER,
 answer_count INTEGER,                       
 comment_count INTEGER,
 community_owned_date TIMESTAMP,
 creation_date TIMESTAMP,
 favorite_count INTEGER,
 last_activity_date TIMESTAMP,
 last_edit_date TIMESTAMP,
 last_editor_display_name STRING,
 last_editor_user_id INTEGER,
 owner_display_name STRING,
 owner_user_id INTEGER,
 parent_id INTEGER,
 post_type_id INTEGER,
 score INTEGER,
 tags STRING,
 view_count INTEGER )
PARTITION BY date(creation_date)
  cluster by id,title,body;
  
  
 -- PARTITION 
 --date(creation_date);
  
--load data from non partition table to new partition table   
insert into 'partition_sales.stack_data_partition' select * from partition_sales.sales;
  
  
-- bellow select queries will show the diff b/w partition and non parition table

select * from  pavankumar123.stack_data where date(creation_date) = '2013-11-19';

select * from pavankumar123.stack_data_partition where date(creation_date) = '2013-11-19';

