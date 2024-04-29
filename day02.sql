SELECT '901216-1234567' AS original ,
RPAD(SUBSTR('901216-1234567',1,7),14,'#') 
FROM dual;
SELECT '010-1111-2222' AS original , 
       '010-' || rpad('1',4,'#') || rpad('-',5,'#') AS rpadnum
       FROM dual;
SELECT LTRIM('0001234','0') FROM dual; 

SELECT ROUND(1234.5678) AS round, 
       ROUND(1234.5678,0) AS round_0,
       ROUND(1234.5678,1) AS round_1,
       ROUND(1234.5618,2) AS round_2
FROM dual; 
SELECT ROUND(1234.5678,-1) AS round,
	   ROUND(1258.5678,-3) AS round
FROM dual; 

SELECT TRUNC(1234.5678) AS trunc,
	   TRUNC(1234.5678,1) AS trunc_1,
	   TRUNC(1234.5678,2) AS trunc_2,
	   TRUNC(1234.5678,3) AS trunc_3
FROM DUAL; 

SELECT TRUNC(1234.5678) AS trunc,
	   TRUNC(1234.5678,-1) AS trunc_1,
	   TRUNC(1234.5678,-2) AS trunc_2,
	   TRUNC(1934.5678,-3) AS trunc_3
FROM DUAL; 

SELECT FLOOR(1234.5678*100)/100 FROM dual;

SELECT MOD(-10,3) FROM dual; 

WITH temp AS (
	SELECT 1111 AS NO, '장성호' AS name ,'1990-08-02' AS hiredate 
	FROM dual
	UNION ALL
	SELECT 1111 AS NO, '장성호' AS name ,'1984-04-12' AS hiredate 
	FROM dual
)
SELECT name,
trunc(MONTHS_BETWEEN(SYSDATE,hiredate)/12) AS year  
FROM temp;

SELECT *
  FROM nls_session_parameters
 WHERE parameter LIKE '%FORMAT%';

 SELECT SYSDATE ,
       TO_CHAR(SYSDATE,'yyyy/mon/DD','NLS_DATE_LANGUAGE = ENGLISH') AS "날짜"
       FROM dual;
      
select to_date('1989-11월-24', 'YYYY-Month-DD'),
       to_date('1989/11/24', 'YYYY/MM/DD'),
       to_date('24-11월-1989', 'DD-Mon-YYYY')
from dual;      

SELECT TO_CHAR(SYSDATE, 'yyyy-mm-dd AM hh:mi:ss') FROM dual;

SELECT TO_CHAR(SYSDATE,'D'), 
       TO_CHAR(SYSDATE,'DY'),
       TO_CHAR(SYSDATE,'DAY')
FROM dual;

SELECT TO_CHAR(SYSDATE,'DDD') AS "365",
       TO_CHAR(SYSDATE,'Ww') AS "몇주차",
       TO_CHAR(SYSDATE,'Q') AS "몇분기"
FROM dual;

SELECT 
TO_CHAR(1234,'fm9999999999999') AS "9999",
TO_CHAR(1234,'fml99999') AS "9999",
TO_CHAR(1234,'09999') AS "앞에 0 추가",
TO_CHAR(1234,'9999.99') AS "소수점 추가",
TO_CHAR(123455678,'fml999,999,999,999,999','NLS_DATE_LANGUAGE = ENGLISH') AS "세자리 끊기",
TO_CHAR(0.45,'0.999') AS "소수점"
FROM dual; 
SELECT TO_NUMBER('-1234438488394832') FROM dual; 

WITH temp AS (
	SELECT '-1234' AS num FROM dual
)
SELECT num+10 FROM temp;

SELECT TO_DATE('26/04/2024','dd-mm-yyyy') AS hiredate FROM dual;

SELECT SUBSTR('abcdefgh@naver.com' ,INSTR('abcdefgh@naver.com','@')+1 ) 
  FROM DUAL;
 SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + interval '100' month
  FROM DUAL; 

 
 
 
 --1. emp에서
--   사원번호의 첫 두글자만 출력하고 나머지는
--   *로 채워 출력하고
--   사원이름의 첫글자만 출력하고
--   나머지는 *로 채우시오.
--
SELECT empno, 
	   RPAD(SUBSTR(EMPNO ,1,2),4,'*') 
	   	AS masking_empno,
	   RPAD(SUBSTR(ENAME ,1,1),LENGTH(ENAME),'*') 
	   	AS masking_ename
FROM emp;

--2. 한달 근무일수를 21.5로 하고
--   하루 평균 8시간 근무한다고 했을때
--   사원들의 일당과 시급을 구하시오.
--   일당은 소수점 세째자리는 버리고
--   시급은 소수점 둘째자리 반올림 하시오.
SELECT ename, sal, 
	   trunc(sal/21.5,2) AS 일당 ,
	   round(sal/21.5/8,1) AS 시급 
FROM emp;
--
--3. 사원들의 입사일을 기준으로
--   3개월이 지난후 첫번째 월요일에
--   정직원으로 전환되는데 전환되는 
--   날짜를 YYYY-MM-DD로   출력하시오.
SELECT ename, hiredate, 
	TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월'),'YYYY-MM-DD') 
FROM emp;

------------------ decode vs case when---------------
--decode 함수 오라클 전용 if문

-- 월급을 올려줘야지...  
-- manager 10% salesman  5% analyst 동결 clerk 3%
SELECT ename, empno, job, sal,
DECODE(
 job,
 'MANAGER',   sal*1.1,
 'SALESMAN',  sal*1.05,
 'CLERK',     sal*1.03,
 sal
) AS "인상된 월급"
FROM emp;

--
WITH temp AS (
	SELECT 'M' gender FROM dual UNION ALL
	SELECT 'F' gender FROM dual UNION ALL
	SELECT 'X' gender FROM dual
)
SELECT gender, 
DECODE(
   		gender,'M','남자',
   		       'F','여자',
   		       '기타'
      ) AS "성별"  
FROM temp;

/*
if(gender=='M') { RETURN "남자"}
ELSE if(gender=='F') {RETURN "여자"}
ELSE {RETURN "기타"}
*/
SELECT * FROM emp;
--한글 이름 출력하기...

SELECT ename,job, decode (
	job,
	'CLERK','사원',
	'SALESMAN','영업',
	'MANAGER','관리자',
	'ANALYST','분석가',
	'PRESIDENT','회장'
) AS "한글 명칭" FROM emp;
-- decode는 null 체크 가능
SELECT ename, comm, 
decode(comm,NULL,'no','yes') AS "커미션 있고 없고"
FROM emp;



SELECT ename, empno, job, sal,
CASE job
	 WHEN  'MANAGER'  THEN  sal*1.1
	 WHEN  'SALESMAN' THEN  sal*1.05
	 WHEN  'CLERK'    THEN  sal*1.03
	 ELSE  sal
END AS "인상된 월급"
FROM emp;

SELECT ename, empno, job, sal,
CASE 
	 WHEN JOB =  'MANAGER'  THEN  sal*1.1
	 WHEN JOB =  'SALESMAN' THEN  sal*1.05
	 WHEN JOB =  'CLERK'    THEN  sal*1.03
	 ELSE  sal
END AS "인상된 월급"
FROM emp;

SELECT * FROM emp; 
--월급이 2900인 사람은 다이아
-- 2700이상이면 에메랄드
-- 2000이상이면 골드
-- 나머지는 실버
 
SELECT ename, sal,
CASE 
	WHEN sal >= 2900 THEN '다이아'
	WHEN sal >= 2700 THEN '에메랄드'
	WHEN sal >= 2000 THEN '골드'
	ELSE '실버'
END AS  "등급" FROM emp;

-- case when
SELECT empno, ename, comm,
	CASE 
		WHEN COMM IS NULL THEN 'NO'
		WHEN COMM > 0 THEN 'YES'
	END AS "커미션"
FROM emp;

SELECT * FROM emp;

-- 매니저가 없을때는 0000
-- 매니저의 사원번호가 75일때는 5555
-- 매니저의 사원번호가 76일때는 6666
-- 매니저의 사원번호가 77일때는 7777
-- 매니저의 사원번호가 78일때는 8888
-- 나머지는 그대로

SELECT empno, ename,mgr,
CASE 
	WHEN SUBSTR(mgr,1,2) = '75' THEN '5555'
	WHEN SUBSTR(mgr,1,2) = '76' THEN '6666'
	WHEN SUBSTR(mgr,1,2) = '77' THEN '7777'
	WHEN SUBSTR(mgr,1,2) = '78' THEN '8888'
	WHEN mgr IS NULL            THEN '0000'
	ELSE to_char(mgr)
END AS "manager number"
FROM emp;
SELECT # fro	


--다중행, 복수행
