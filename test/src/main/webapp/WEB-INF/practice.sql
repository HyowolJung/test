create table member( 
    member_id varchar2(20),
    member_name VARCHAR2(100),
    member_position varchar2(10),
    member_sex varchar2(10),
    member_img VARCHAR2(200),
    member_tel VARCHAR2(100),
    member_Skill_Language VARCHAR2(200),
    member_Skill_DB VARCHAR2(200),
    member_startdate date default sysdate,
    member_enddate date
);
alter table member add member_status varchar2(50); 
create table project(
    project_id varchar2(20),
    custom_company_id varchar2(200),
    project_name varchar2(200),
    project_Skill_Language varchar2(200),
    project_Skill_DB varchar2(200),
    project_startdate date,
    project_enddate date
);
alter table project add project_no varchar2(20);
select * from project;

create table member_project(
    member_id varchar2(20),
    project_id varchar2(20),
    project_Skill_Language varchar2(200),
    project_Skill_DB varchar2(200),
    project_startdate date,
    project_enddate date
);
select * from member_project;
alter table member_project add member_no number;

DROP TABLE member_project;

CREATE TABLE PROJECT_DETAIL(
    member_id varchar2(20),
    project_id varchar2(20),
    PROJECT_NAME VARCHAR2(200),
    PUSHDATE date,
    PULLDATE date
);
alter table PROJECT_DETAIL add project_no number;

INSERT 
    INTO 
        MEMBER_PROJECT
                            (
                                PROJECT_NO
                                ,MEMBER_ID
                                ,PROJECT_ID
                                ,PROJECT_NAME
                                ,PROJECT_SKILL_LANGUAGE
                                ,PROJECT_SKILL_DB
                                ,PROJECT_STARTDATE
                            )
        VALUES                        
        (
			(
				SELECT 
		  			TO_NUMBER(NVL(MAX(PROJECT_NO), 0))+ 1 
		  		FROM 
		  			MEMBER
		  	)	
		  		,1111111
		  		,2222222
		  		,'플젝1'
		  		,'D'
		  		,'F'
		  		,23/12/25
		 );
         
    SELECT 
       P.PROJECT_NO 
	  ,P.PROJECT_ID
	  ,CASE
           WHEN CUSTOM_COMPANY_ID = 'D061' THEN '삼성'
           WHEN CUSTOM_COMPANY_ID = 'D062' THEN '엘지'
           WHEN CUSTOM_COMPANY_ID = 'D063' THEN '애플'
           WHEN CUSTOM_COMPANY_ID = 'D064' THEN '구글'
           WHEN CUSTOM_COMPANY_ID = 'D065' THEN '아마존'
         END AS CUSTOM_COMPANY_ID
	  ,P.PROJECT_NAME
	  ,CASE
           WHEN PROJECT_SKILL_LANGUAGE = 'S010' THEN 'JAVA'
           WHEN PROJECT_SKILL_LANGUAGE = 'S011' THEN 'PYTHON'
           WHEN PROJECT_SKILL_LANGUAGE = 'S012' THEN 'C++'
           WHEN PROJECT_SKILL_LANGUAGE = 'S013' THEN 'RUBY'
         END AS PROJECT_SKILL_LANGUAGE
      ,CASE
           WHEN PROJECT_SKILL_DB = 'S020' THEN 'ORACLE'
           WHEN PROJECT_SKILL_DB = 'S021' THEN 'MSSQL'
           WHEN PROJECT_SKILL_DB = 'S022' THEN 'MYSQL'
           WHEN PROJECT_SKILL_DB = 'S023' THEN 'POSTGRESQL'
         END AS PROJECT_SKILL_DB
	  ,P.PROJECT_STARTDATE
	  ,P.PROJECT_ENDDATE
	  ,PD.PUSHDATE
	  ,PD.PULLDATE
	FROM 
		PROJECT P
	JOIN
		PROJECT_DETAIL PD
	ON
		P.PROJECT_ID = PD.PROJECT_ID
    JOIN
        MEMBER M
    ON
        M.MEMBER_ID = PD.MEMBER_ID
	WHERE
        PD.MEMBER_ID = 15159898
    AND
        PD.PROJECT_ID = 98969515;
       
     
  
SELECT * FROM PROJECT;     
        