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

create table project(
    project_id varchar2(20),
    custom_company_id varchar2(200),
    project_name varchar2(200),
    project_Skill_Language varchar2(200),
    project_Skill_DB varchar2(200),
    project_startdate date,
    project_enddate date
);

create table member_project(
    member_id varchar2(20),
    project_id varchar2(20),
    project_Skill_Language varchar2(200),
    project_Skill_DB varchar2(200),
    project_startdate date,
    project_enddate date
);

alter table member_project add project_name varchar2(200);

SELECT 
    	M.MEMBER_ID
    	,MP.PROJECT_ID
    	,mp.PROJECT_NAME
    	,MP.PROJECT_SKILL_LANGUAGE
    	,MP.PROJECT_SKILL_DB
    	,MP.PROJECT_STARTDATE
    	,MP.PROJECT_ENDDATE
	FROM 
    	MEMBER M
	JOIN
    	MEMBER_PROJECT MP
	ON
    	M.MEMBER_ID = MP.MEMBER_ID
	WHERE 
    	M.MEMBER_ID = 42;
      
    select * from member;
    select * from member_project;



alter table member modify member_enddate default null;

SELECT * FROM MEMBER ORDER BY MEMBER_ID ASC;

select count(*) from member where member_Tel = '010-1111-1111';
COMMIT;
SELECT 
			* 
		FROM 
			MEMBER
		WHERE 
			MEMBER_ID =1;
            
            
SELECT 
		 MEMBER_ID
		  ,MEMBER_NAME
		  ,CASE
            WHEN MEMBER_SEX = 'D011' THEN '남자'
            WHEN MEMBER_SEX = 'D012' THEN '여자'
          END AS MEMBER_SEX
          ,CASE
            WHEN MEMBER_POSITION = 'D028' THEN '사원'
            WHEN MEMBER_POSITION = 'D027' THEN '대리'
            WHEN MEMBER_POSITION = 'D026' THEN '과장'
            WHEN MEMBER_POSITION = 'D025' THEN '차장'
            WHEN MEMBER_POSITION = 'D024' THEN '부장'
            WHEN MEMBER_POSITION = 'D023' THEN '이사'
            WHEN MEMBER_POSITION = 'D022' THEN '상무'
            WHEN MEMBER_POSITION = 'D021' THEN '사장'
          END AS MEMBER_POSITION
		  ,MEMBER_TEL
		  ,CASE
            WHEN MEMBER_SKILL_LANGUAGE = 'S010' THEN 'JAVA'
            WHEN MEMBER_SKILL_LANGUAGE = 'S011' THEN 'PYTHON'
            WHEN MEMBER_SKILL_LANGUAGE = 'S012' THEN 'C++'
            WHEN MEMBER_SKILL_LANGUAGE = 'S013' THEN 'RUBY'
          END AS MEMBER_SKILL_LANGUAGE
          ,CASE
            WHEN MEMBER_SKILL_DB = 'S020' THEN 'ORACLE'
            WHEN MEMBER_SKILL_DB = 'S021' THEN 'MSSQL'
            WHEN MEMBER_SKILL_DB = 'S022' THEN 'MYSQL'
            WHEN MEMBER_SKILL_DB = 'S023' THEN 'POSTGRESQL'
          END AS MEMBER_SKILL_DB
		  ,MEMBER_STARTDATE
		FROM 
		(
		   SELECT
		      	MEMBER_ID
		  		,MEMBER_NAME
		  		,MEMBER_SEX
		  		,MEMBER_POSITION
		  		,MEMBER_TEL
		  		,MEMBER_SKILL_LANGUAGE
		  		,MEMBER_SKILL_DB
		  		,MEMBER_STARTDATE
		      	,ROW_NUMBER() OVER(ORDER BY member_id DESC) AS NUMROW
		      	,COUNT(*) OVER() AS TOTAL_CNT
			FROM
				MEMBER
		)
		WHERE 
			NUMROW BETWEEN 1 AND 10
		ORDER BY MEMBER_ID DESC;
        
        SELECT * FROM MEMBER ORDER BY MEMBER_ID ASC;


SELECT 
		 PROJECT_ID
		  ,CASE
            WHEN CUSTOM_COMPANY_ID = 'D061' THEN '삼성'
            WHEN CUSTOM_COMPANY_ID = 'D062' THEN '엘지'
            WHEN CUSTOM_COMPANY_ID = 'D063' THEN '애플'
            WHEN CUSTOM_COMPANY_ID = 'D064' THEN '구글'
            WHEN CUSTOM_COMPANY_ID = 'D065' THEN '아마존'
          END AS CUSTOM_COMPANY_ID
		  ,PROJECT_NAME
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
		  ,PROJECT_STARTDATE
		 
		FROM 
		(
		   SELECT
		      	PROJECT_ID
		  		,CUSTOM_COMPANY_ID
		  		,PROJECT_NAME
		  		,PROJECT_SKILL_LANGUAGE
		  		,PROJECT_SKILL_DB
		  		,PROJECT_STARTDATE
		      	,ROW_NUMBER() OVER(ORDER BY PROJECT_ID asc) AS NUMROW
		      	,COUNT(*) OVER() AS TOTAL_CNT
			FROM
				PROJECT
		);