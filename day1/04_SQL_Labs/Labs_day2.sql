SELECT TOP 10 customer_id, full_name, phone, email, city
FROM dbo.customers;


select  * 
from orders

select TOP 10  order_id,customer_id ,order_date,total_amount
from orders
select  * 
from employees

select  * 
from customers
where email is null

select  count(*) as missing_email
from customers
where email is null
--Task 1A –: اعرض الموظفين الذين ليس لديهم رقم هاتف.
--Task 2A – : احسب عدد الموظفين الذين ليس لديهم هاتف.



select * 
from employees

select * 
from employees
where phone is  

select count(*)  as  missing_phone
from employees
where phone is  null



select  full_name ,len(full_name)
from customers
where  len(full_name) <10
--2A – : اعرض أرقام الهاتف التي طولها أقل من 10.
--Task 3B – : اعرض أرقام الهاتف التي طولها أكبر من 10 أرقام.

select  full_name ,len(phone) as missing_phone
from employees
where len(phone) <10

select  full_name ,len(phone) as missing_phone
from employees
where len(phone) >10

select  full_name ,len(phone) as missing_phone
from employees
where len(phone) <10 or  len(phone) >10


select count(*) as missing_phone
from employees
where len(phone) <10 or  len(phone) >10


select count(*)
from employees
where len(phone) >10


select  * 
from customers
where segment like'%P'


select  * 
from customers
where national_id like'%200%'

--3A –: اعرض الهواتف التي تبدأ بـ 05.
--3B – : اعرض الهواتف التي تبدأ بـ +966.
select  * 
from employees
where (phone like'05%' or  phone like'+966%')  and len(phone) >=10


(13+7+10 )/3 = 10   23

select  * 
from customers

select full_name ,city
from customers;

select full_name  +' - '+  city
from customers;

select  concat(credit_limit,'  SAR')
from customers;



select  email ,count(*)
from customers
group by  email
having  count(*) >1

select  full_name ,count(*)
from customers
group by  full_name
having  count(*) >1

select  national_id ,count(*)
from customers
group by  national_id
having  count(*) >1