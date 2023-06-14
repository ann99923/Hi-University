select * from basket;
delete from basket;
commit;
drop table basket;

create table basket(    -- 장바구니 DB
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
SELECT * FROM user_tables ; -- 테이블 확인
--------------------------------------------------------------------------------
create table college_list(  -- 대학 DB
college varchar2(50) primary key);

insert into college_list(college) values('인문대학');
insert into college_list(college) values('공과대학');
insert into college_list(college) values('예체능대학');
select * from college_list;
--------------------------------------------------------------------------------
create table department_list(   -- 학과 DB
college varchar2(50),
department varchar2(50));
insert into department_list values('인문대학','정치외교학과');
insert into department_list values('인문대학','행정학과');
insert into department_list values('인문대학','철학과');

insert into department_list values('인문대학','교양');
insert into department_list values('공과대학','교양');
insert into department_list values('예체능대학','교양');

insert into department_list values('공과대학','컴퓨터공학과');
insert into department_list values('공과대학','전자공학과');
insert into department_list values('공과대학','기계공학과');

insert into department_list values('예체능대학','실용음악과');
insert into department_list values('예체능대학','동양화과');
insert into department_list values('예체능대학','사회체육학과');

select*from department_list;
--------------------------------------------------------------------------------
create table subject(   -- 과목 DB
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
insert into subject values('인문대학','정치외교학과','101','정치학개론','김면회','3','월','수','A','B');
insert into subject values('예체능대학','동양화과','311','수묵의 이해I','이만수','2','수','목','C','D');
insert into subject values('인문대학','정치외교학과','102','국제정치이론','남궁영','3');
insert into subject values('인문대학','행정학과','111','행정학개론','견진만','3');
insert into subject values('공과대학','컴퓨터공학과','201','자료구조','김낙현','2');
insert into subject values('공과대학','컴퓨터공학과','202','프로그래밍어론','김상철','2');
select * from subject;
commit;
--------------------------------------------------------------------------------
create table basket(    -- 장바구니 DB
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
create table grade( -- 성적 DB
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
insert into grade values(111555,'101','인문대학','정치외교학과','정치학개론','aaa','A',50);
insert into grade values(222444,'101','인문대학','정치외교학과','정치학개론','bbb','B',90);
delete from grade;
select * from grade;
commit;
--------------------------------------------------------------------------------
create table student_info(  -- 학생정보 DB
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
insert into student_info values(111555,'111','aaa', '1','동양화과','010','aaa@',00111, 'aaaaa',null);
insert into student_info values(222444,'222','bbb','2','정치외교학과','020','bb@',00555, null, '별명');
insert into student_info values(111111,'333','ccc','1','실용음악과','030','cc@',111111, 'ccc', null);
select * from student_info;
commit;
update student_info set nickname = null where student_id='111555';

commit;
--------------------------------------------------------------------------------
create sequence board_seq start with 1 increment by 1;  -- 게시판 글번호 시퀀스
drop sequence board_seq;

create table board (    -- 게시판 글 등록 DB
seq number(3) primary key,  -- 게시판 글번호 
id varchar2(10), -- 학번
type number(1) not null,    -- 게시판 종류(1:자유 2:익명 3:학과)
nickname varchar2(30) not null, -- 별명
title varchar2(50) not null,    -- 글제목
pass char(4) not null,  -- 글비밀번호
content varchar2(1000), -- 글내용
writedate date, -- 작성일
filename varchar2(30)  -- 등록 파일명
);

select count(*) from board;
select * from board order by seq desc;
desc board;
drop table board;
drop sequence board_seq;
insert into board values(board_seq.nextval,111111,1,'aaa','제목','1111','1번입니다', sysdate, '1.txt');
insert into board values(board_seq.nextval,111111,2,'aaa','제목','1111','2번입니다', sysdate, null);

select * from board;
commit;
select pass from board where nickname='별명';
select * from board1 where type=1 and title like '%c%';
select * from board1 where type=1 order by seq desc;
SELECT *  FROM (SELECT ROWNUM RNUM, board.*  FROM 
      (SELECT * FROM board1 where type=1 ORDER BY seq DESC) board) 
         WHERE rnum <= 4;
--------------------------------------------------------------------------------
create sequence comment_seq start with 1 increment by 1;  -- 게시판 글번호 시퀀스

create table comments (    -- 댓글 등록 DB
comment_seq number(3) primary key,    -- 댓글 글번호
board_seq number(3),  -- 게시글 글번호
id varchar2(10), -- 학번
nickname varchar2(30) not null, -- 별명
writedate_c date, -- 작성일
content_c varchar2(1000) -- 글내용
);

desc comments;
drop table comments;
drop sequence comment_seq;

--------------------------------------------------------------------------------
create table admin(  -- 관리자 DB
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
create table eval_list( -- 강의정보 DB
subject varchar2(50) primary key,
professor varchar2(20) not null,
content varchar2(1000)
);

insert into eval_list values('재료역학','이순걸','설명1');
insert into eval_list values('공학수학I','이경엽','설명2');
insert into eval_list values('발성과 가창의 기초','한충완','설명3');
insert into eval_list values('보컬테크닉I','권진원','설명4');
select * from eval_list;
commit;
--------------------------------------------------------------------------------
CREATE SEQUENCE eval_seq START WITH 1 INCREMENT BY 1;

create table eval_score( -- 강의평가 DB
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

insert into eval_score values(eval_seq.nextval,'공학수학I','내용','A', 'C','B');
commit;
select * from eval_score;
drop table eval_score;
--------------------------------------------------------------------------------
create table basket( -- 수강신청 장바구니 DB

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
insert into subject values('예체능대학','동양화과','311','수묵의 이해I','이만수','2','Wed','Thr','C','D');
insert into subject values('예체능대학','동양화과','312','동양미술사','유근택','2','Mon','Fri','A','B');
insert into subject values('예체능대학','동양화과','313','한국미술사','권기범','3','Tue','Fri','A','C');
insert into subject values('예체능대학','동양화과','314','화조의 이해','노신경','3','Wed','Mon','B','C');
insert into subject values('인문대학','정치외교학과','101','정치학개론','김면회','3','Mon','Wed','A','B'); --월A, 수B
insert into subject values('인문대학','정치외교학과','102','국제정치이론','남궁영','3','Mon','Thr','C','D'); --월C, 목D
insert into subject values('인문대학','정치외교학과','103','비교정치','서경교','2','Tue','Tue','B','C'); --화 B,C
insert into subject values('인문대학','정치외교학과','104','고대정치사상','이상환','2','Wed','Wed','C','D'); --수 C,D
insert into subject values('인문대학','정치외교학과','105','정치학연구방법론','이재목','3','Thr','Thr','A','B'); --목 A,B

insert into basket values('인문대학','정치외교학과','101','정치학개론','김면회','3','Mon','Wed','A','B','231001'); --월A, 수B
insert into basket values('인문대학','정치외교학과','102','국제정치이론','남궁영','3','Mon','Thr','C','D','231001'); --월C, 목D
insert into basket values('인문대학','정치외교학과','103','비교정치','서경교','2','Tue','Tue','B','C','231001'); --화 B,C
insert into basket values('인문대학','정치외교학과','104','고대정치사상','이상환','2','Wed','Wed','C','D','231001'); --수 C,D
insert into basket values('인문대학','정치외교학과','105','정치학연구방법론','이재목','3','Thr','Thr','A','B','231001'); --목 A,B
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
select * from subject where department='예체능대학';

select DISTINCT * from basket where id='233003';

create table subject(   -- 과목 DB
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
insert into subject values('인문대학','정치외교학과','101','정치학개론','김면회','3','Thr','13:00~15:00','Fri','13:00~15:00'); --thrC, friC
insert into subject values('인문대학','정치외교학과','102','국제정치이론','남궁영','3','Wed','15:00~17:00','Thr','09:00~11:00'); --wedD, thrA
insert into subject values('인문대학','정치외교학과','103','비교정치','서경교','2','Mon','09:00~11:00','Wed','09:00~11:00'); --monA, wedA
insert into subject values('인문대학','정치외교학과','104','고대정치사상','이상환','2','Tue','13:00~15:00','Fri','09:00~11:00'); --tueC, friA
insert into subject values('인문대학','정치외교학과','105','정치학연구방법론','이재목','3','Tue','11:00~13:00','Wed','13:00~15:00'); --tueB, wedC

insert into subject values('인문대학','행정학과','111','행정학개론','견진만','3','Mon','13:00~15:00','Thr','15:00~17:00'); --MonC, ThrD
insert into subject values('인문대학','행정학과','112','지방정부론','곽선주','2','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('인문대학','행정학과','113','도시행정','권태형','3','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('인문대학','행정학과','114','행정법I','김선영','3','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('인문대학','행정학과','115','공공리더십론','김성수','2','Mon','11:00~13:00','Thr','11:00~13:00'); --MonB, ThrB

insert into subject values('인문대학','철학과','121','근대철학사','신승환','2','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA
insert into subject values('인문대학','철학과','122','존재론/형이상학','이창우','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('인문대학','철학과','123','윤리학','박승찬','2','Mon','11:00~13:00','Thr','11:00~13:00'); --MonB, ThrB
insert into subject values('인문대학','철학과','124','기초논리학','백민정','3','Thr','13:00~15:00','Fri','13:00~15:00'); --ThrC, FriC
insert into subject values('인문대학','철학과','125','분석철학','이병덕','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC --가톨릭대--

insert into subject values('공과대학','컴퓨터공학과','201','자료구조','김낙현','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('공과대학','컴퓨터공학과','202','프로그래밍어론','김상철','2','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('공과대학','컴퓨터공학과','203','데이터마이닝','김성복','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('공과대학','컴퓨터공학과','204','캡스톤설계및실습','박종혁','3',MonB,ThrB); --MonB, ThrB
insert into subject values('공과대학','컴퓨터공학과','205','데이터베이스설계','손기락','3',TueD,FriB); --TueD, FriB

insert into subject values('공과대학','전자공학과','211','기초미적분학I','강준우','3','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA
insert into subject values('공과대학','전자공학과','212','이산수학','김동식','3','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('공과대학','전자공학과','213','디지털공학','박영철','3','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('공과대학','전자공학과','214','컴퓨터개론','이성현','2','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('공과대학','전자공학과','215','회로이론','이정훈','2','Mon','13:00~15:00','Thr','15:00~17:00'); --MonC, ThrD

insert into subject values('공과대학','기계공학과','221','공학프로그래밍입문','유송민','2','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('공과대학','기계공학과','222','열역학','장승호','3','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA
insert into subject values('공과대학','기계공학과','223','유체역학','홍희기','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('공과대학','기계공학과','224','재료역학','이순걸','3','Thr','13:00~15:00','Fri','13:00~15:00'); --ThrC, FriC
insert into subject values('공과대학','기계공학과','225','공학수학I','이경엽','2','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA --경희대--

insert into subject values('예체능대학','실용음악과','301','발성과 가창의 기초','한충완','3','Thr','13:00~15:00','Fri','13:00~15:00'); --ThrC, FriC
insert into subject values('예체능대학','실용음악과','302','보컬테크닉I','권진원','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('예체능대학','실용음악과','303','리듬합주I','피정훈','3','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('예체능대학','실용음악과','304','합주실기I','오정수','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('예체능대학','실용음악과','305','시창청음I','김정배','2','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA --서울예술대학--

insert into subject values('예체능대학','동양화과','311','수묵의 이해I','이만수','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('예체능대학','동양화과','312','동양미술사','유근택','2','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('예체능대학','동양화과','313','한국미술사','권기범','3','Mon','09:00~11:00','Wed','09:00~11:00'); --MonA, WedA
insert into subject values('예체능대학','동양화과','314','화조의 이해','노신경','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('예체능대학','동양화과','315','현대미술의쟁점','정성윤','2','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA --성신여대--

insert into subject values('예체능대학','사회체육학과','321','사회체육개론','유덕수','3','Tue','15:00~17:00','Fri','11:00~13:00'); --TueD, FriB
insert into subject values('예체능대학','사회체육학과','322','스포츠정책론','육현철','3','Mon','13:00~15:00','Thr','15:00~17:00'); --MonC, ThrD
insert into subject values('예체능대학','사회체육학과','323','사회체육프로그램','윤석훈','2','Tue','11:00~13:00','Wed','13:00~15:00'); --TueB, WedC
insert into subject values('예체능대학','사회체육학과','324','사회체육행정','윤영길','2','Wed','15:00~17:00','Thr','09:00~11:00'); --WedD, ThrA
insert into subject values('예체능대학','사회체육학과','325','사회체육지도론','이미숙','2','Tue','13:00~15:00','Fri','09:00~11:00'); --TueC, FriA --한체대--
commit;
select DISTINCT college from subject;
select DISTINCT college, department from subject;

desc basket;
desc subject;