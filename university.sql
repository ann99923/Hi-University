select * from basket;
delete from basket;
commit;
drop table basket;

create table basket(    -- ��ٱ��� DB
college,
department,
subjectNum,
subject varchar2(50),
professor varchar2(50),
score number(1),
foreign key(college) references college_list(college),
foreign key(department) references department_list(department),
foreign key(subjectNum) references subject(subjectNum)
);

DELETE FROM basket WHERE ROWID IN (SELECT ROWID FROM (SELECT * FROM (SELECT ROW_NUMBER() OVER(PARTITION BY subjectNum ORDER BY subjectNum) AS num FROM basket) WHERE num > 1));

drop table college_list;
drop table department_list;
drop table subject;
drop table grade;

drop table basket;

drop table student_info;
drop table admin;


delete subject;



drop table board;
drop table comments;
drop table eval_list;
drop table eval_score;
select * from basket;
select * from student_info;
SELECT * FROM tabs ;
SELECT * FROM user_tables ; -- ���̺� Ȯ��
--------------------------------------------------------------------------------
create table college_list(  -- ���� DB
college varchar2(50) primary key);

insert into college_list(college) values('�ι�����');
insert into college_list(college) values('��������');
insert into college_list(college) values('��ü�ɴ���');
select * from college_list;
--------------------------------------------------------------------------------
create table department_list(   -- �а� DB
college varchar2(50),
department varchar2(50));
insert into department_list values('�ι�����','��ġ�ܱ��а�');
insert into department_list values('�ι�����','�����а�');
insert into department_list values('�ι�����','ö�а�');

insert into department_list values('�ι�����','����');
insert into department_list values('��������','����');
insert into department_list values('��ü�ɴ���','����');

insert into department_list values('��������','��ǻ�Ͱ��а�');
insert into department_list values('��������','���ڰ��а�');
insert into department_list values('��������','�����а�');

insert into department_list values('��ü�ɴ���','�ǿ����ǰ�');
insert into department_list values('��ü�ɴ���','����ȭ��');
insert into department_list values('��ü�ɴ���','��ȸü���а�');

select*from department_list;
--------------------------------------------------------------------------------
create table subject(   -- ���� DB
college varchar2(50),
department varchar2(50),
subjectNum number(3) primary key,
subject varchar2(50) unique,
professor varchar2(10),
score number(1),
day1 varchar2(10),
day2 varchar2(10),
time1 char(1),
time2 char(1)
);

desc subject;
drop table subject;
commit;
insert into subject values('�ι�����','��ġ�ܱ��а�','101','��ġ�а���','���ȸ','3','��','��','A','B');
insert into subject values('��ü�ɴ���','����ȭ��','311','������ ����I','�̸���','2','��','��','C','D');
insert into subject values('�ι�����','��ġ�ܱ��а�','102','������ġ�̷�','���ÿ�','3');
insert into subject values('�ι�����','�����а�','111','�����а���','������','3');
insert into subject values('��������','��ǻ�Ͱ��а�','201','�ڷᱸ��','�賫��','2');
insert into subject values('��������','��ǻ�Ͱ��а�','202','���α׷��־��','���ö','2');
select * from subject;
commit;
--------------------------------------------------------------------------------
create table basket(    -- ��ٱ��� DB
college varchar2(50),
department varchar2(50),
subjectNum number(3),
subject varchar2(50),
professor varchar2(50),
score number(1)
);
desc basket;
commit;

--------------------------------------------------------------------------------
create table grade( -- ���� DB
id varchar2(10),
subjectNum number(3),
college varchar2(50),
department varchar2(50),
subject varchar2(50),
name varchar2(20),
grade char(1),
grade_score number(3)
);
alter table grade modify grade char(1);
desc grade;
commit;
insert into grade values(111555,'101','�ι�����','��ġ�ܱ��а�','��ġ�а���','aaa','A',50);
insert into grade values(222444,'101','�ι�����','��ġ�ܱ��а�','��ġ�а���','bbb','B',90);
delete from grade;
select * from grade;
commit;
--------------------------------------------------------------------------------
create table student_info(  -- �л����� DB
id varchar2(10) primary key,
pwd varchar2(20) not null,
name varchar2(20) not null,
status char(1),
department varchar2(50),
phone varchar2(15),
email varchar2(40),
birth varchar2(6) not null,
address varchar2(100),
nickname varchar(30)
);

select * from student_info;
drop table student_info;
desc student_info;

delete from student_info where pass='111';
drop table student_info;
desc student_info;
insert into student_info values(111555,'111','aaa', '1','����ȭ��','010','aaa@',00111, 'aaaaa',null);
insert into student_info values(222444,'222','bbb','2','��ġ�ܱ��а�','020','bb@',00555, null, '����');
insert into student_info values(111111,'333','ccc','1','�ǿ����ǰ�','030','cc@',111111, 'ccc', null);
select * from student_info;
commit;
update student_info set nickname = null where student_id='111555';

commit;
--------------------------------------------------------------------------------
create sequence board_seq start with 1 increment by 1;  -- �Խ��� �۹�ȣ ������
drop sequence board_seq;

create table board (    -- �Խ��� �� ��� DB
seq number(3) primary key,  -- �Խ��� �۹�ȣ 
id varchar2(10), -- �й�
type number(1) not null,    -- �Խ��� ����(1:���� 2:�͸� 3:�а�)
nickname varchar2(30) not null, -- ����
title varchar2(50) not null,    -- ������
pass char(4) not null,  -- �ۺ�й�ȣ
content varchar2(1000), -- �۳���
writedate date, -- �ۼ���
filename varchar2(30)  -- ��� ���ϸ�
);

select count(*) from board;
select * from board order by seq desc;
desc board;
drop table board;
drop sequence board_seq;
insert into board values(board_seq.nextval,111111,1,'aaa','����','1111','1���Դϴ�', sysdate, '1.txt');
insert into board values(board_seq.nextval,111111,2,'aaa','����','1111','2���Դϴ�', sysdate, null);

select * from board;
commit;
select pass from board where nickname='����';
select * from board1 where type=1 and title like '%c%';
select * from board1 where type=1 order by seq desc;
SELECT *  FROM (SELECT ROWNUM RNUM, board.*  FROM 
      (SELECT * FROM board1 where type=1 ORDER BY seq DESC) board) 
         WHERE rnum <= 4;
--------------------------------------------------------------------------------
create sequence comment_seq start with 1 increment by 1;  -- �Խ��� �۹�ȣ ������

create table comments (    -- ��� ��� DB
comment_seq number(3) primary key,    -- ��� �۹�ȣ
board_seq number(3),  -- �Խñ� �۹�ȣ
id varchar2(10), -- �й�
nickname varchar2(30) not null, -- ����
writedate_c date, -- �ۼ���
content_c varchar2(1000) -- �۳���
);

desc comments;
drop table comments;
drop sequence comment_seq;

--------------------------------------------------------------------------------
create table admin(  -- ������ DB
id varchar(7) primary key,
pwd varchar2(20) not null,
status char(1) not null
);

drop table admin;
desc admin;
insert into admin values(1111111, 'admin', '3');

select * from admin;

select * from board1 where type='1' order by seq desc;

--------------------------------------------------------------------------------
create table eval_list( -- �������� DB
subject varchar2(50) primary key,
professor varchar2(20) not null,
content varchar2(1000)
);

insert into eval_list values('��Ὺ��','�̼���','����1');
insert into eval_list values('���м���I','�̰濱','����2');
insert into eval_list values('�߼��� ��â�� ����','�����','����3');
insert into eval_list values('������ũ��I','������','����4');
select * from eval_list;
commit;
--------------------------------------------------------------------------------
CREATE SEQUENCE eval_seq START WITH 1 INCREMENT BY 1;

create table eval_score( -- ������ DB
num number(3) primary key,
subject varchar2(50),
id varchar2(10),
content varchar2(500), 
totalScore varchar2(10), 
score varchar2(10), 
lectureScore varchar2(10)
);

alter table eval_score add id varchar2(10);
alter table eval_score add constraint id foreign key(id) references student_info(student_id);
commit;

desc eval_score;

insert into eval_score values(eval_seq.nextval,'���м���I','����','A', 'C','B');
commit;
select * from eval_score;
drop table eval_score;
--------------------------------------------------------------------------------
create table basket( -- ������û ��ٱ��� DB

college varchar2(50),
department varchar2(50),
subjectNum number(3),
subject varchar2(50) ,
professor varchar2(10),
score number(1),
day1 varchar2(10),
time1 varchar2(30),
day2 varchar2(10),
time2 varchar2(30),
id varchar2(10)
);
drop table basket;
insert into subject values('��ü�ɴ���','����ȭ��','311','������ ����I','�̸���','2','Wed','Thr','C','D');
insert into subject values('��ü�ɴ���','����ȭ��','312','����̼���','������','2','Mon','Fri','A','B');
insert into subject values('��ü�ɴ���','����ȭ��','313','�ѱ��̼���','�Ǳ��','3','Tue','Fri','A','C');
insert into subject values('��ü�ɴ���','����ȭ��','314','ȭ���� ����','��Ű�','3','Wed','Mon','B','C');
insert into subject values('�ι�����','��ġ�ܱ��а�','101','��ġ�а���','���ȸ','3','Mon','Wed','A','B'); --��A, ��B
insert into subject values('�ι�����','��ġ�ܱ��а�','102','������ġ�̷�','���ÿ�','3','Mon','Thr','C','D'); --��C, ��D
insert into subject values('�ι�����','��ġ�ܱ��а�','103','����ġ','���汳','2','Tue','Tue','B','C'); --ȭ B,C
insert into subject values('�ι�����','��ġ�ܱ��а�','104','�����ġ���','�̻�ȯ','2','Wed','Wed','C','D'); --�� C,D
insert into subject values('�ι�����','��ġ�ܱ��а�','105','��ġ�п��������','�����','3','Thr','Thr','A','B'); --�� A,B

insert into basket values('�ι�����','��ġ�ܱ��а�','101','��ġ�а���','���ȸ','3','Mon','Wed','A','B','231001'); --��A, ��B
insert into basket values('�ι�����','��ġ�ܱ��а�','102','������ġ�̷�','���ÿ�','3','Mon','Thr','C','D','231001'); --��C, ��D
insert into basket values('�ι�����','��ġ�ܱ��а�','103','����ġ','���汳','2','Tue','Tue','B','C','231001'); --ȭ B,C
insert into basket values('�ι�����','��ġ�ܱ��а�','104','�����ġ���','�̻�ȯ','2','Wed','Wed','C','D','231001'); --�� C,D
insert into basket values('�ι�����','��ġ�ܱ��а�','105','��ġ�п��������','�����','3','Thr','Thr','A','B','231001'); --�� A,B
delete from basket;
commit;
drop table basket;
select * from basket; 
select DISTINCT * from basket;
select * from student_info;
delete from subject;
commit;

DELETE FROM basket WHERE ROWID > (SELECT MAX(ROWID) FROM basket WHERE subjectNum = subjectNum);
DELETE FROM basket WHERE ROWID IN (SELECT ROWID FROM (SELECT * FROM (SELECT ROW_NUMBER() OVER(PARTITION BY subjectNum ORDER BY subjectNum) AS num FROM basket) WHERE num > 1));
select * from subject;   
select * from subject where department='��ü�ɴ���';

select DISTINCT * from basket where id='233003';

create table subject(   -- ���� DB
college varchar2(50),
department varchar2(50),
subjectNum number(3) primary key,
subject varchar2(50) unique,
professor varchar2(10),
score number(1),
day1 varchar2(20),
time1 varchar2(20),
day2 varchar2(20),
time2 varchar2(20)
);
drop table subject;
insert into subject values('�ι�����','��ġ�ܱ��а�','101','��ġ�а���','���ȸ','3','Thr','13:00~15:00','Fri','13:00~15:00'); --thrC, friC
insert into subject values('�ι�����','��ġ�ܱ��а�','102','������ġ�̷�','���ÿ�','3','Wed','15:00~17:00','Thr','09:00~11:00'); --wedD, thrA
insert into subject values('�ι�����','��ġ�ܱ��а�','103','����ġ','���汳','2','Mon','09:00~11:00','Wed','09:00~11:00'); --monA, wedA
insert into subject values('�ι�����','��ġ�ܱ��а�','104','�����ġ���','�̻�ȯ','2','Tue','13:00~15:00','Fri','09:00~11:00'); --tueC, friA
insert into subject values('�ι�����','��ġ�ܱ��а�','105','��ġ�п��������','�����','3','Tue','11:00~13:00','Wed','13:00~15:00'); --tueB, wedC

insert into subject values('�ι�����','�����а�','111','�����а���','������','3','Mon','13:00~15:00','Thr','15:00~17:00'); --MonC, ThrD
insert into subject values('�ι�����','�����а�','112','�������η�','������','2','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('�ι�����','�����а�','113','��������','������','3','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('�ι�����','�����а�','114','������I','�輱��','3','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('�ι�����','�����а�','115','���������ʷ�','�輺��','2','Mon','11:00~13:00','Thr','11:00~13:00'); --MonB, ThrB

insert into subject values('�ι�����','ö�а�','121','�ٴ�ö�л�','�Ž�ȯ','2','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA
insert into subject values('�ι�����','ö�а�','122','�����/���̻���','��â��','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('�ι�����','ö�а�','123','������','�ڽ���','2','Mon','11:00~13:00','Thr','11:00~13:00'); --MonB, ThrB
insert into subject values('�ι�����','ö�а�','124','���ʳ���','�����','3','Thr','13:00~15:00','Fri','13:00~15:00'); --ThrC, FriC
insert into subject values('�ι�����','ö�а�','125','�м�ö��','�̺���','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC --���縯��--

insert into subject values('��������','��ǻ�Ͱ��а�','201','�ڷᱸ��','�賫��','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('��������','��ǻ�Ͱ��а�','202','���α׷��־��','���ö','2','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('��������','��ǻ�Ͱ��а�','203','�����͸��̴�','�輺��','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('��������','��ǻ�Ͱ��а�','204','ĸ���漳��׽ǽ�','������','3',MonB,ThrB); --MonB, ThrB
insert into subject values('��������','��ǻ�Ͱ��а�','205','�����ͺ��̽�����','�ձ��','3',TueD,FriB); --TueD, FriB

insert into subject values('��������','���ڰ��а�','211','���ʹ�������I','���ؿ�','3','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA
insert into subject values('��������','���ڰ��а�','212','�̻����','�赿��','3','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('��������','���ڰ��а�','213','�����а���','�ڿ�ö','3','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('��������','���ڰ��а�','214','��ǻ�Ͱ���','�̼���','2','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('��������','���ڰ��а�','215','ȸ���̷�','������','2','Mon','13:00~15:00','Thr','15:00~17:00'); --MonC, ThrD

insert into subject values('��������','�����а�','221','�������α׷����Թ�','���۹�','2','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('��������','�����а�','222','������','���ȣ','3','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA
insert into subject values('��������','�����а�','223','��ü����','ȫ���','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('��������','�����а�','224','��Ὺ��','�̼���','3','Thr','13:00~15:00','Fri','13:00~15:00'); --ThrC, FriC
insert into subject values('��������','�����а�','225','���м���I','�̰濱','2','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA --�����--

insert into subject values('��ü�ɴ���','�ǿ����ǰ�','301','�߼��� ��â�� ����','�����','3','Thr','13:00~15:00','Fri','13:00~15:00'); --ThrC, FriC
insert into subject values('��ü�ɴ���','�ǿ����ǰ�','302','������ũ��I','������','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('��ü�ɴ���','�ǿ����ǰ�','303','��������I','������','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('��ü�ɴ���','�ǿ����ǰ�','304','���ֽǱ�I','������','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('��ü�ɴ���','�ǿ����ǰ�','305','��âû��I','������','2','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA --���￹������--

insert into subject values('��ü�ɴ���','����ȭ��','311','������ ����I','�̸���','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('��ü�ɴ���','����ȭ��','312','����̼���','������','2','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('��ü�ɴ���','����ȭ��','313','�ѱ��̼���','�Ǳ��','3','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('��ü�ɴ���','����ȭ��','314','ȭ���� ����','��Ű�','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('��ü�ɴ���','����ȭ��','315','����̼�������','������','2','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA --���ſ���--

insert into subject values('��ü�ɴ���','��ȸü���а�','321','��ȸü������','������','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('��ü�ɴ���','��ȸü���а�','322','��������å��','����ö','3','Mon','13:00~15:00','Thr','15:00~17:00'); --MonC, ThrD
insert into subject values('��ü�ɴ���','��ȸü���а�','323','��ȸü�����α׷�','������','2','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('��ü�ɴ���','��ȸü���а�','324','��ȸü������','������','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('��ü�ɴ���','��ȸü���а�','325','��ȸü��������','�̹̼�','2','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA --��ü��--
commit;
select DISTINCT college from subject;
select DISTINCT college, department from subject;

desc basket;
desc subject;