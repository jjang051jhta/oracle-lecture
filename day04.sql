-- join  테이블 연결해서 쓰기... join
SELECT * FROM emp;
SELECT * FROM dept;

-- table의 alias(별칭) 은 한칸 띄우면 됨
SELECT 
  empno,
  ename, 
  job,
  mgr, 
  hiredate, 
  sal ,
  comm,
  d.deptno,
  dname,
  loc 
FROM emp e, DEPT d
WHERE e.DEPTNO = d.DEPTNO; 

--14*4  56개의 데이터 출력
-- 조건을 잘 맞추어 써야한다.
SELECT e.*,d.dname,d.loc FROM emp e, dept d
WHERE e.DEPTNO = d.DEPTNO AND sal >= 3000
ORDER BY empno;  
-- inner join  등가 조인  같은 값을 찾아서 join하기

-- 비등가 조인
SELECT * 
FROM emp;


SELECT * FROM SALGRADE;

-- 같다가 아니라 등가 가 아니라 그 사이에 있는 경
SELECT * 
FROM EMP e, SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 오라클 조인  표준 이랑 오라클 join이랑 좀 다르다.
SELECT * from  salgrade;

SELECT * 
FROM EMP e, SALGRADE s
WHERE e.SAL >= s.LOSAL AND e.sal <= s.HISAL;

-- 같은 테이블을 한번 더 쓰기  self join 등가 조인...
SELECT 
e1.empno, e1.ename, e1.mgr,
e2.empno AS MGR_NO,
e2.ename AS MGR_NAME
FROM emp e1, emp e2
WHERE e1.mgr = e2.EMPNO(+);    

SELECT 
e1.empno, e1.ename, e1.mgr,
e2.empno AS MGR_NO,
e2.ename AS MGR_NAME
FROM emp e1, emp e2
WHERE e1.mgr(+) = e2.EMPNO;


-- ansi 조인 / 표준조인
  


SELECT e.empno, 
       e.ename, 
       e.JOB, 
       e.mgr, 
       e.HIREDATE,
	   e.SAL,
	   e.COMM,
	   deptno,
	   d.DNAME,
	   d.loc
FROM emp e NATURAL JOIN dept d
ORDER BY e.empno, deptno;

SELECT e.empno, 
       e.ename, 
       e.JOB, 
       e.mgr, 
       e.HIREDATE,
	   e.SAL,
	   e.COMM,
	   deptno,
	   d.DNAME,
	   d.loc
FROM emp e JOIN dept d using(deptno)
ORDER BY e.empno, deptno;


SELECT e.empno, 
       e.ename, 
       e.JOB, 
       e.mgr, 
       e.HIREDATE,
	   e.SAL,
	   e.COMM,
	   e.deptno,
	   d.DNAME,
	   d.loc
FROM emp e 
INNER JOIN dept d   --inner는 생략 가능하다. 없으면 INNER join
ON e.deptno = d.DEPTNO
WHERE e.JOB = 'MANAGER'
ORDER BY e.empno, deptno;

SELECT e.ename,e.deptno, d.dname, d.loc
FROM emp e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.JOB = 'MANAGER';



SELECT e1.empno, e1.ename, e1.mgr,
       e2.empno AS mgr_no,
       e2.ename AS mgr_name
FROM emp e1 
LEFT OUTER JOIN emp e2 
ON e1.mgr = e2.EMPNO
ORDER BY e1.empno;

--
--SELECT 
--e1.empno, e1.ename, e1.mgr,
--e2.empno AS MGR_NO,
--e2.ename AS MGR_NAME
--FROM emp e1, emp e2
--WHERE e1.mgr(+) = e2.EMPNO;  

SELECT e1.empno, e1.ename, e1.mgr,
       e2.empno AS mgr_no,
       e2.ename AS mgr_name
FROM emp e1 
RIGHT OUTER JOIN emp e2 
ON e1.mgr = e2.EMPNO
ORDER BY e1.empno;


SELECT e1.empno, 
       e1.ename, 
	   d1.deptno,
       d1.dname
FROM emp e1 
CROSS JOIN dept d1 
ORDER BY e1.empno;


SELECT e1.empno, 
       e1.ename, 
	   d1.deptno,
       d1.dname
FROM emp e1 
FULL OUTER JOIN dept d1 ON e1.DEPTNO = d1.DEPTNO 
ORDER BY e1.empno;
-- 



 












