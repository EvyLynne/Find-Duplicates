-- Pull data from table  
select * from  Employee_Dupes

-- Query 1

select name, ssn, 
count(*) duplicates
from Employee_Dupes
group by name, ssn
having count(*)>1

-- Query 2

with cte as (
select employee_id, name, ssn
 , ROW_NUMBER() OVER (partition by name, ssn order by employee_id) rn
from Employee_Dupes
) select * from cte
 where rn > 1

 -- Query 3

 select   e1.*
 from Employee_Dupes e1
 inner join Employee_Dupes e2 on e2.name = e1.name
 and e1.ssn = e2.ssn
 and e1.employee_id <> e2.employee_id
