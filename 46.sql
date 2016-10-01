 drop database if exists work;
 create database if not exists work;
 use work;
 drop table if exists student;
 drop table if exists teacher;
 drop table if exists course;
drop table if exists sc;
 create table if not exists student(
 sno varchar (10), 
 #primary key,
sname varchar(20),
sage int(2),
 ssex varchar(5)
 );
 create table if not exists teacher(
 tno varchar(10),
 #primary key,
tname varchar(20)
 );
 create table if not exists course(
 cno varchar(10), 
# primary key, 
cname varchar(20),
tno varchar(20)

 );
 create table if not exists sc(
 sno varchar(10),
cno varchar(10),
 score float(5,2)

 );
-- -- ******初始化学生表的数据*****
 insert into student values ('s001','张三',23,'男');
insert into student values ('s002','李四',23,'男'); 
insert into student values ('s003','吴鹏',35,'男');
 insert into student values ('s004','琴沁',20,'女'); 
 insert into student values ('s005','王丽',20,'女'); 
 insert into student values ('s006','李波',21,'男');
 insert into student values ('s007','刘玉',21,'男');
 insert into student values ('s008','萧蓉',21,'女');
 insert into student values ('s009','陈萧晓',23,'女');
 insert into student values ('s010','陈美',22,'女');
 insert into student values ('s011','陈美',22,'女');
 commit;
-- *****************初始化教师表**********************
 insert into teacher values ('t001', '刘阳');
 insert into teacher values ('t002', '谌燕');
 insert into teacher values ('t003', '胡明星');
 commit;
-- -- **************初始化课程表***************************
 insert into course values ('c001','J2SE','t002');
 insert into course values ('c002','Java Web','t002');
 insert into course values ('c003','SSH','t001');
 insert into course values ('c004','Oracle','t001');
 insert into course values ('c005','SQL SERVER 2005','t003');
 insert into course values ('c006','C#','t003');
 insert into course values ('c007','JavaScript','t002');
 insert into course values ('c008','DIV+CSS','t001');
 insert into course values ('c009','PHP','t003');
 insert into course values ('c010','EJB3.0','t002');
 commit;
-- -- **************初始化成绩表**********************
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',50.9);
insert into sc values ('s001','c002',22.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',81.9);
insert into sc values ('s001','c003',59）;
insert into sc values ('s001','c004',59);
-- 1、查询“c001”课程比“c002”课程成绩高的所有学生的学号；
#select s1.sno from sc as s1 join sc as s2 on(s1.sno = s2.sno)
#where s1.cno = 'c001' and s2.cno = 'c002' and s1.score>s2.score;
-- 2、查询平均成绩大于60 分的同学的学号和平均成绩；
#select sno,avg(score) from sc group by sno having avg(score)>60;
-- 3、查询所有同学的学号、姓名、选课数、总成绩；
#select student.sno,student.sname,count(sc.cno),sum(sc.score) from student 
#left join sc on(student.sno = sc.sno) group by student.sno;
-- 4、查询姓“刘”的老师的个数；
#select count(tname) from teacher where tname like'刘%';
-- 5、查询没学过“谌燕”老师课的同学的学号、姓名；
#select student.*,sc.*,course.*,teacher.* from student left join sc on(student.sno = sc.sno) 
#left join course on(sc.cno = course.cno) left join teacher on(course.tno = teacher.tno)
#group by student.sno having teacher.tname<>'谌燕' or teacher.tname is null;
-- 6、查询学过“c001”并且也学过编号“c002”课程的同学的学号、姓名；
#select student.sno,student.sname from sc as s1 join sc as s2 on(s1.sno = s2.sno) 
#join student on(s2.sno = student.sno) 
#where s1.cno = 'c001' and s2.cno = 'c002';
-- 7、查询学过“谌燕”老师所教的所有课的同学的学号、姓名；
#select student.*,sc.*,course.*,teacher.* from student left join sc on(student.sno = sc.sno) 
#left join course on(sc.cno = course.cno) left join teacher on(course.tno = teacher.tno)
#group by student.sno having teacher.tname<>'谌燕' or teacher.tname is null;
-- 8、查询课程编号“c002”的成绩比课程编号“c001”课程低的所有同学的学号、姓名；
#select student.sno,student.sname from sc as s1 join sc as s2 on(s1.sno = s2.sno) 
#join student on(s2.sno = student.sno)
#where s1.cno = 'c001' and s2.cno = 'c002' and s1.score>s2.score;
-- 9、查询所有课程成绩小于60 分的同学的学号、姓名；
#select student.sno,student.sname from sc join student on(sc.sno = student.sno) 
#where sc.score<60 group by sc.sno;
-- 10、查询没有学全所有课的同学的学号、姓名；
-- 11、查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名；
-- select student.sno,student.sname from sc join student on(sc.sno = student.sno) 
-- where sc.sno <>'s001' and sc.cno in
-- (select cno from sc where sno = 's001') group by student.sno;
-- 12、查询至少学过学号为“s001”同学所有一门课的其他同学学号和姓名；
 -- select * from sc join student on(sc.sno = student.sno) 
 -- where sc.sno <>'s001' and sc.cno in
 -- (select cno from sc where sno = 's001') group by sc.sno having count(sc.cno) = 1;
-- 13、把“SC”表中“谌燕”老师教的课的成绩都更改为此课程的平均成绩；
-- update sc set score = 
-- 	select a from(
--  (select avg(sc.score) from teacher 
-- 	join course on(teacher.tno = course.tno)  
-- 	join sc on(course.cno = sc.cno) 
-- where teacher.tname = '谌燕' group by sc.cno having sc.cno = 'c001') 
--  )
-- where cno = 'c001';
-- select * from sc;
-- 14、查询和“s001”号的同学学习的课程完全相同的其他同学学号和姓名；
-- select student.sno,student.sname from sc join student on(sc.sno = student.sno) 
#where sc.sno<>'s001' and sc.cno in( 查询其他同学的课程是否满足即在s001学过的课程 
#又和s001学过的课程数量一样
-- select sc.cno from sc where sc.sno = 's001') 统计s001学过的课程
-- group by sc.sno having count(sc.cno) = 
-- (select count(sc.cno) from sc where sc.sno = 's001' group by sc.sno) 
	#统计s001学过的课程数量
#;
-- 15、删除学习“谌燕”老师课的SC 表记录；
#DELETE FROM 表名称 WHERE 列名称 = 值
#delete from sc where sc.cno in
#(select course.cno from teacher join course on(teacher.tno = course.tno) where teacher.tname = '谌燕');
#select * from sc;
-- 16、向SC 表中插入一些记录，这些记录要求符合以下条件：
#没有上过编号“c002”课程的同学学号、“c002”号课的平均成绩；

-- 17、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
#select cno,max(sc.score),min(sc.score) from sc group by cno;
-- 18、按各科平均成绩从低到高和及格率的百分数从高到低顺序
#select a.cno,avg(a.score) as num,
#((select count(b.cno) from sc as b where b.score>=60 and b.cno = a.cno
#)/count(a.cno)*100) as 'rate(百分比)'
#from sc as a group by a.cno order by num asc,'rate(百分比)' desc;
#select a.cno,avg(a.score) as num,(count(case when a.score>=60 then 1 or 0 end)/count(a.cno)) as rate
#from sc as a group by a.cno order by num asc,rate desc;
-- 19、查询不同老师所教不同课程平均分从高到低显示
-- 20、统计列印各科成绩,各分数段人数:课程ID,课程名称,[100-85],[85-70],[70-60],[ <60]
#select course.cno,course.cname,sum(case when sc.score>=85 and sc.score<=100 then 1 or 0 end) as 优,
#sum(case when sc.score>=70 and sc.score<85 then 1 or 0 end) as 良,
#sum(case when sc.score>=60 and sc.score<70 then 1 or 0 end) as 中,
#sum(case when sc.score<60 then 1 or 0 end) as 差
#from course left join sc on(sc.cno = course.cno) group by course.cno;
-- 21、查询各科成绩前三名的记录:(不考虑成绩并列情况)
-- 22、查询每门课程被选修的学生数
#select course.cno,count(sc.sno) as 学生数 from course left join sc on(course.cno = sc.cno) group by course.cno;
-- 23、查询出只选修了一门课程的全部学生的学号和姓名
#select student.sno,student.sname from student left join sc on(student.sno = sc.sno) group by student.sno having count(sc.cno) = 1;
-- 24、查询男生、女生人数
#select ssex,count(ssex) from student group by ssex;
-- 25、查询姓“张”的学生名单
#select * from student where sname like'张%';
-- 26、查询同名同姓学生名单，并统计同名人数
#select s1.sname,count(s1.sname) from student as s1 
#group by s1.sname having count(s1.sname)>1;
-- 27、1981 年出生的学生名单(注：Student 表中Sage 列的类型是number)
#select * from student where (year(now())-1981) = student.sage;
-- 28、查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列
#select course.cno,avg(sc.score) as 平均成绩 from course left join sc on(course.cno = sc.cno)
#group by course.cno order by 平均成绩 asc,course.cno desc;
-- 29、查询平均成绩大于85 的所有学生的学号、姓名和平均成绩
-- select student.sno,student.sname,avg(sc.score) from sc join student on(sc.sno = student.sno) 
-- group by sc.sno having avg(sc.score)>85;
-- 30、查询课程名称为“数据库”，且分数低于60 的学生姓名和分数
-- select student.sname,sc.score from student join sc on(student.sno = sc.sno) join course on(sc.cno = course.cno)
--  where course.cname = 'J2SE' and sc.score>=60 group by student.sno;
-- 31、查询所有学生的选课情况；
-- 32、查询任何一门课程成绩在70 分以上的姓名、课程名称和分数；
-- select student.sname,course.cname,sc.score from sc join student on(sc.sno = student.sno) join course on(sc.cno = course.cno) 
-- group by sc.sno having min(sc.score)>=70;
-- 33、查询不及格的课程，并按课程号从大到小排列
-- select course.* from course left join sc on(course.cno = sc.cno) 
-- where sc.score < 60 or sc.score is null group by course.cno order by course.cno desc;
-- 34、查询课程编号为c001 且课程成绩在80 分以上的学生的学号和姓名；
-- select student.sno,student.sname from sc join student on(sc.sno = student.sno) 
-- where sc.cno = 'c001' and sc.score>80;
-- 35、求选了课程的学生人数
#select count(sc.sno) from sc where sc.cno is not null group by sc.sno; 
-- 36、查询选修“谌燕”老师所授课程的学生中，成绩最高的学生姓名及其成绩
-- select student.sname,sc.score from sc join course on(sc.cno = course.cno) 
#join teacher on(course.tno = teacher.tno) 
-- join student on(sc.sno = student.sno)
-- where teacher.tname='谌燕' order by sc.score desc limit 1;
-- 37、查询各个课程及相应的选修人数
-- select course.cno,course.cname,count(sc.sno) from course left join sc on(course.cno = sc.cno) 
-- group by course.cno;
-- 38、查询不同课程成绩相同的不同学生的学号、课程号、学生成绩
-- select s1.sno,s1.cno,s1.score from sc as s1 join sc as s2 on(s1.score = s2.score) 
-- where s1.cno<>s2.cno and s1.sno<>s2.sno;
-- 39、查询每门功课成绩最好的前两名
-- 40、统计每门课程的学生选修人数（超过2 人的课程才统计）。
#要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号降序排列
-- select sc.cno,count(sc.sno) from sc group by sc.cno having count(sc.sno)>2 
-- order by count(sc.sno) desc,sc.cno desc;
-- 41、检索至少选修两门课程的学生学号
#select sc.sno from sc group by sc.sno having count(sc.cno)>=2;
-- 42、查询全部学生都选修的课程的课程号和课程名
-- select * from student left join sc on(student.sno = sc.sno) 
-- left join course on(sc.cno = course.cno) group by sc.cno having count(sc.sno) = 11;
-- 43、查询没学过“谌燕”老师讲授的任一门课程的学生姓名
-- select student.sname from student where student.sno not in
-- (select sc.sno from sc where sc.cno in
-- (select course.cno from teacher join course on(teacher.tno = course.tno) where teacher.tname='谌燕')) 
-- group by student.sno;
-- 44、查询两门以上不及格课程的同学的学号及其平均成绩
-- select sc.sno,avg(sc.score) from sc group by sc.sno having sum(case when score<60 then 1 or 0 end)>2;
-- 45、检索“c004”课程分数小于60，按分数降序排列的同学学号
#select sc.sno from sc where sc.cno = 'c004' and sc.score<60 order by sc.score desc;
-- 46、删除“s002”同学的“c001”课程的成绩
-- delete from sc where sc.sno = 's002' and sc.cno = 'c001';
-- 	select * from sc;