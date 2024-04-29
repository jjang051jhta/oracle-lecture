-- 다중행 / 복수행 함수
SELECT * FROM emp;
SELECT SUM(sal) FROM emp;  -- row

SELECT ename, sum(sal) FROM emp; 
-- 다중행 함수는 다중행 끼리만 사용 단일행 함수랑 사용 안됨...

--sum 함수는 null을 0으로 처리한다.
SELECT sum(comm) AS comm_count, sum(sal) AS sum_sal 
FROM emp;

-- 갯수 세기
SELECT count(*) FROM emp WHERE ename = 'jjang';

--평균
SELECT avg(sal) FROM emp;

-- distinct를 쓰면 같은 값이면 한번만 연산
SELECT sum(DISTINCT sal) AS distict_sal,
       sum(ALL  sal) AS all_sal,
       sum(sal) AS sal
FROM emp;       


SELECT max(sal) AS max_sal, min(sal) AS min_sal 
FROM emp;

SELECT max(HIREDATE), min(HIREDATE) 
FROM emp WHERE deptno = 30;

-- 다중행 함수는 group by
-- 10, 20, 30
SELECT avg(sal) FROM emp WHERE DEPTNO = 10
UNION all
SELECT avg(sal) FROM emp WHERE DEPTNO = 20
UNION all
SELECT avg(sal) FROM emp WHERE DEPTNO = 30;

SELECT avg(sal), deptno FROM emp
GROUP BY deptno;

-- order by는 무조건 제일 마지막에 쓴다. 예전에는 sort 되어서 결과 반환
-- 일반열을 사용해야한다면 group by에 명시해야 한다.
SELECT deptno, job, avg(sal) 
FROM emp
GROUP BY DEPTNO, job
ORDER BY DEPTNO, job;
/*
1. WHERE 
2. GROUP BY
3. HAVING 
4. ORDER by
*/

-- HAVING group by에 조건 달기...
SELECT deptno, job, avg(sal) 
FROM emp
--WHERE AVG(sal)  >= 2000  where 절에 group 함수의 조건을 쓸 수 없음
GROUP BY DEPTNO, job
HAVING AVG(sal)  >= 2000
ORDER BY DEPTNO, job;


SELECT deptno, job, avg(sal) 
FROM emp
WHERE sal <= 3000  -- WHERE 조건에서 먼저 행을 거르고
GROUP BY DEPTNO, job  -- 여기서 그룹핑을 한다.
HAVING AVG(sal)  >= 2000
ORDER BY DEPTNO, job;


--부서별 직책의 평균 급여가 500 이상인 사람들의 부서번호, 직책, 
-- 부서별 직책의 평균 급여 출력

SELECT deptno, job, avg(sal)
FROM emp
GROUP BY deptno,job
ORDER BY DEPTNO , job;
-- 직책별 전체 급여, 몇명있는지, 평균급여 구해보세요.
-- view   1년에 1억 이상 쓴 사람들에게 메일 보내고 싶다.  view
SELECT job,
       sum(sal) AS sal_total, 
       count(*) AS count,
	   --sum(sal) / COUNT(*) 
       trunc(avg(sal))
FROM emp
GROUP BY job
HAVING sum(sal) >= 5000 AND avg(sal) >= 2000;
--   전체 급여가 5000 이상이고 평균 급여가 2000 이상인 것만 뽑아보기

SELECT deptno, 
       STDDEV(sal)  AS "표준 편차" ,
FROM emp
GROUP BY DEPTNO ;

-- 소계 구하기...
SELECT job, SUM(sal)
FROM emp
GROUP BY ROLLUP (job);

SELECT deptno,job, count(*) AS count,max(sal) AS max,SUM(sal) AS sum
FROM emp
GROUP BY ROLLUP (deptno, job)
ORDER BY DEPTNO, job; 
-- group by절에 rollup 을 사용하면 각각의  소계를 구해준다.
-- 그리고 마지막에 전체 값을 다시 한번 출력해준다.

-- 
SELECT deptno,job, count(*) AS count,max(sal) AS max,SUM(sal) AS sum
FROM emp
GROUP BY cube (deptno, job)
ORDER BY DEPTNO, job; 


SELECT deptno,
       job, 
       count(*) AS count,
       max(sal) AS max,
       SUM(sal) AS sum,
	   GROUPING(DEPTNO),  -- 0이 나오면 GROUPING 되었다. 아니면 1 나옴
	   GROUPING(job) 
FROM emp
GROUP BY cube (deptno, job)
ORDER BY DEPTNO, job;


--grouping함수는 그룹핑이 되면 0아니면 1
SELECT  DECODE(GROUPING(DEPTNO),1,'ALL_DEPT_NO',DEPTNO)  AS DEPTNO ,
        DECODE(GROUPING(job),1,'ALL_JOB',JOB)  AS job ,
        COUNT(*)  AS count,
        MAX(sal) AS max,
        AVG(sal) AS avg
FROM emp
GROUP BY CUBE (DEPTNO,JOB)
ORDER BY DEPTNO , JOB ;






/*
1. emp 테이블에서 부서번호, 평균급여, 최고 급여, 최저급여, 사원수를 출력하시오.
   평균 급여에서는 소수점 제외하시오.
2. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하시오.
3. 입사연도를 기준으로 부서별 입사인원을 출력하시오.
4. 추가수당을 받는 사원수와 그렇지 않은 사원수를 출력하시오 yes 몇명 no 몇명
5. 각 부서의 입사연도별 사원수 최고급여, 총급여, 평균 급여를 부서별 소계와 
    총계를 출력하시오.
*/
-- 다한 사람 코드 주세요... 

--1번
SELECT 
	DEPTNO , 
	round(avg(SAL),1) AS avg, 
	max(SAL) AS max, 
	min(sal), 
	count(*) AS count
FROM EMP
GROUP BY DEPTNO;

--2번
SELECT 
	JOB,
	COUNT(*) AS count
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3
ORDER BY job,count;
--ORDER BY 1,2;

--3. 입사연도를 기준으로 부서별 입사인원을 출력하시오.
-- group by에 alias 못씀
SELECT 
	TO_CHAR(HIREDATE ,'YYYY') AS YEAR,
	DEPTNO ,
	count(*) AS count
FROM EMP
GROUP BY ROLLUP (TO_CHAR(HIREDATE ,'YYYY'), DEPTNO)
ORDER BY YEAR;

--4. 추가수당을 받는 사원수와 그렇지 않은 사원수를 출력하시오 yes 몇명 no 몇명
SELECT nvl2(comm,'yes','no') AS comm,
count(*) AS count
FROM EMP
GROUP BY nvl2(comm,'yes','no');

-- 5. 각 부서의 입사연도별 사원수 최고급여, 총급여, 평균 급여를 부서별 소계와 총계를 출력하시오.
SELECT deptno,
       TO_CHAR(HIREDATE,'YYYY') AS YEAR,
       COUNT(*)  AS count,
       MAX(sal) AS max,
       SUM(sal) AS total_sal,
       AVG(sal)  AS avg
FROM emp
GROUP BY ROLLUP(deptno, TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1,2;
--list_aggregate
SELECT ename FROM emp;

--옆으로 나열하고 싶을때...
SELECT deptno, 
       LISTAGG(ename,',') WITHIN GROUP( ORDER BY sal desc) AS ename
FROM emp
GROUP BY DEPTNO; 


-- pivot subquery








