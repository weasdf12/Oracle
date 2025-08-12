select * from account;
update account set acc_balance = acc_balance - 10000 where acc_no
 = '101-11-1001';
 
 update account set acc_balance = acc_balance + 10000 where acc_no
 = '101-11-1003';

commit;

update account set acc_balance = acc_balance - 10000 where acc_no
 = '101-11-1001';
 
 update account set acc_balance = acc_balance + 10000 where acc_no
 = '101-11-1003';
select * from account; 
ROLLBACK;

show autocommit;
set AUTOCOMMIT off;
