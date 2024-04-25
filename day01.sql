--주석 comment  create / read / update / delete
-- DML(data manipulation ()) /DDL/DCL
-- insert / SELECT / UPDATE / delete
SELECT ename,job,SAL FROM emp;
--where 는 조건 걸기
SELECT * FROM emp;
SELECT * FROM emp WHERE empno = 7369;
SELECT * FROM emp WHERE ENAME = 'SMITH';  -- 문자는 ''작은 따옴표
SELECT ename,sal FROM emp WHERE sal >= 2000; --  = != >= <=
SELECT ename AS 이름,sal AS 연봉 FROM emp WHERE sal >= 2000;
SELECT ename, sal, sal*1.1 AS "ten" FROM emp;
SELECT ename, sal FROM emp WHERE sal >= 1000 AND sal <= 2000; 
SELECT ename, sal FROM emp WHERE sal BETWEEN 1000 AND 2000; 
-- mybatis xml 쿼리문이랑 개발 코드 분리...  
--1000보다 크고 2000 보다 작은 사람 이름과 sal 뽑아보기

SELECT ename FROM emp WHERE ename LIKE '%S%';
--er로 끝나는 사람 찾기...
SELECT ename FROM emp WHERE ename LIKE '%ER';

--SELECT * FROM notice WHERE subject LIKE '%자바%';

-- db table  중복  relation 관계형데이터베이스 rdbms  오라클 마이sql
-- table 밑으로 내려가는건 걱정없다.  처음에 만들때 설계를 잘 해야한다.
-- emp + depth   db하시는 분들이 돈 제일 많이 받음...
SELECT * FROM emp;
SELECT DISTINCT deptno AS 부서번호 FROM emp;  --DISTINCT 하면 중복 제거
-- concat이 정식 || 는 편의상
SELECT CONCAT(ename,job) AS "name and job" FROM emp;
SELECT ename || '''s job is ' || job AS "name and job" FROM emp;


SELECT * FROM emp;
--연봉  각 사원들의 연봉정보 출력 이름 , 월급, 연봉
SELECT ename AS 이름, sal AS 월급 , sal*12 + NVL(comm,0) AS 연봉 
FROM emp;
-- null 연산
--empno, ename, comm , yes, no
SELECT empno, ename, comm, NVL2(comm,'YES','NO') AS "커미션 유무"  FROM emp;


--작은 따옴표는 값을 나타낼때
SELECT * FROM emp WHERE ename = 'SMITH';

--큰 따옴표는 문자 즉 식별자로 사용한다.
SELECT * FROM emp;
SELECT * FROM emp ORDER BY sal DESC, DEPTNO asc;-- 두번 정렬
-- emp에서 찾기...
--1. deptno=30인 사원 전부 찾기 
SELECT ename FROM emp WHERE DEPTNO = 30;

--2. deptno=30 이면서 job이 salesman 인 사람 찾기
SELECT ename FROM emp WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

--3. deptno=30 이면서 job이 clerk 인 사람 찾기
SELECT ename FROM emp WHERE DEPTNO = 30 AND JOB = 'CLERK';

--4. 연봉이 30000이상인 사람 찾기
SELECT ename FROM emp WHERE sal*12 >= 30000;

--5. 이름이 f  보다 큰 사람 찾기
SELECT ename FROM emp WHERE ENAME > 'F';

--6. job이 manager 거나 salesman이거나 clerk인 사람 찾기
SELECT ename FROM emp 
WHERE job = 'MANAGER' OR JOB = 'CLERK' OR JOB = 'SALESMAN';

SELECT ename FROM emp 
WHERE job IN ('MANAGER','CLERK','SALESMAN');

--7. job이 manager이 아니고 salesman이 아니고 clerk이 아닌 사람 찾기
SELECT ename FROM emp 
WHERE job != 'MANAGER' AND JOB ^= 'CLERK' AND JOB <> 'SALESMAN';

SELECT ename FROM emp 
WHERE job NOT IN ('MANAGER','CLERK','SALESMAN');

-- 이름의 다섯번째가 s로 끝나는 사람
SELECT ename FROM emp WHERE ENAME LIKE '____S';

SELECT ename FROM emp ;
-- 이름 세번째에 A들어간 사람...
SELECT ename FROM emp WHERE ENAME LIKE '__A%';

SELECT ename, SAL FROM emp WHERE SAL LIKE '1%';
-- 성능에 좋지않다.

-- null 값 조회  IS 로 조회한다. nvl(컬럼명,0), 
-- nvl2(컬럼명,널이 아닐때 값, 널일때 값)은  값을 치환
SELECT ename, job, comm FROM emp WHERE COMM IS NOT NULL;

-- dual 가상테이블 빈테이블
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM dual;

WITH temp AS (
	SELECT 111 empno, '장성호' ename, 'programmer' job FROM dual 
	UNION ALL
	SELECT 222 empno, '장동건' ename, 'actor' job FROM dual
	UNION ALL
	SELECT 222 empno, '장동건' ename, 'actor' job FROM dual
)
SELECT * FROM temp;

-- dept 20, 30 부서에 근무하는 사람중에 sal 2000인 사람 구해보기...
SELECT * FROM emp WHERE DEPTNO = 20 AND SAL >= 2000
UNION ALL 
SELECT * FROM emp WHERE DEPTNO = 30 AND SAL >= 2000;

--union all은 합집합 중복 허용  4시 10분에 다시 시작
SELECT * FROM emp WHERE SAL >= 1000
UNION ALL 
SELECT * FROM emp WHERE DEPTNO = 30;

--intersect 교집합 
SELECT * FROM emp WHERE SAL >= 1000
INTERSECT  
SELECT * FROM emp WHERE DEPTNO = 30;

-- 차집합
SELECT * FROM emp WHERE SAL >= 1000
MINUS  
SELECT * FROM emp WHERE DEPTNO = 30;


--1. emp테이블을 이용해서 사원이름이 S로 끝나는 사원 데이터를 모두 출력하라.
-- % 는 뭐든.... _ 자리수
SELECT ename FROM EMP WHERE ENAME LIKE '%S';
--2. emp테이블을 이용해서 부서코드 30번에서 근무하는 사원 중, 
--직책이 SALESMAN인 사원의 사원번호, 이름, 직책, 급여, 부서번호를 출력하라.

SELECT EMPNO , ENAME , JOB , SAL , DEPTNO FROM emp 
WHERE DEPTNO = 30 AND JOB = 'SALESMAN';


--3. emp테이블을 이용해서 20,30번 부서에 근무하는 사원 중 급여가 2000초과하는 
     --사원을 다음 두가지 방식으로 접근하여 사원번호, 이름, 급여, 부서번호를 출력하라.
--3-1. 집합 연산자를 사용하지 말 것. 

SELECT  empno, ename,sal, deptno FROM emp
WHERE (DEPTNO = 20 OR DEPTNO = 30) AND sal > 2000;

SELECT  empno, ename,sal, deptno FROM emp
WHERE DEPTNO IN (20,30) AND sal > 2000;
--3-2. 집합 연산자를 사용 할것.

SELECT  empno, ename,sal, deptno FROM emp
WHERE DEPTNO = 20 AND sal > 2000
UNION ALL 
SELECT  empno, ename,sal, deptno FROM emp
WHERE DEPTNO = 30 AND sal > 2000;

--4. NOT BETWEEN A AND B 연산자를 사용하지 않고 
  --급여 범위 2000~3000을 제외한 데이터를 출력하라.

SELECT * FROM EMP 
WHERE SAL < 2000 OR SAL > 3000;

--5. 사원 이름에 'E'가 포함된 30번 부서 소속 사원 중, 
  --급여가 1000~2000 사이가 아닌 사원의 이름, 사원번호, 급여, 부서번호를 출력하라.

SELECT * FROM EMP 
WHERE ENAME LIKE '%E%' 
AND 
sal NOT BETWEEN 1000 AND 2000;

--6. 추가 수당이 존재하지 않고 상급자(mgr)가 있고 직책이 MANAGER,CLERK인 
 --사원 중에서 사원 이름의 두번째 글자가 'L'이 아닌 사원의 정보를 출력하라.
SELECT * FROM EMP
WHERE COMM IS NULL AND 
MGR IS NOT NULL AND 
JOB IN ('MANAGER','CLERK') AND 
ENAME NOT LIKE '_L%';

-- or 쓴거
SELECT * FROM EMP
WHERE COMM IS NULL AND 
MGR IS NOT NULL AND 
(JOB = 'MANAGER' OR JOB = 'CLERK') AND 
ENAME NOT LIKE '_L%';






WITH TEMP5 AS (
   SELECT * FROM EMP
   MINUS
   SELECT * FROM EMP WHERE SAL BETWEEN 1000 AND 2000), 
TEMP6 AS (
   SELECT * FROM EMP e WHERE e.ENAME LIKE '%E%' AND e.DEPTNO = 30
   INTERSECT 
   SELECT * FROM TEMP5
)
SELECT ENAME AS "이름", EMPNO AS "사원번호", SAL AS "급여", DEPTNO AS "부서번호" FROM TEMP6;










