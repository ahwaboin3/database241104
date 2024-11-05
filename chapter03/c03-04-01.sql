-- c03-04-01.sql

-- 집계 함수와 group by 검색
-- 집계하기 위해서는 group by 문을 사용하고 구체적인 내용은 집계 함수를 사용한다.

-- 집계 함수
-- 집계 함수는 테이블의 각 열에 대해 계산을 하는 함수로 sum, avg, min, max, count의
-- 다섯 가지가 있다.

-- 주문 테이블의 모든 정보를 표시하시오.
select * from orders;

-- 고객이 주문한 도서의 총판매액을 구하시오.
select sum(saleprice)
from orders;

-- 별칭을 사용하여 다시 출력
select sum(saleprice) as 총매출
from orders;

-- as 키워드는 생략 가능 하다
select sum(saleprice) 총매출
from orders;

-- 집계 함수는 where문과 같이 사용하면 더 유용하다.

-- 2번 김연아 고객이 주문한 도서의 총판매액을 구하시오.
select * from customer;
select * from orders;

select sum(saleprice) as 총매출
from orders
where custid=2;

-- 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오.
select sum(saleprice) as total,
    avg(saleprice) as average,
    min(saleprice) as minimum,
    max(saleprice) as maximum
from orders;

-- 집계 함수 count는 행의 개수를 센다.
-- count() 괄호 안에는 *혹은 특정 속성의 이름이 사용되며,
-- 해당 속성의 투플의 개수를 세어 준다.(null값을 제외)

-- 마당서점의 도서 판매 건수를 구하시오.
select count(*)
from orders;

-- group by 검색
-- sql문에서 group by절을 사용하면 같은 속성값끼리 그룹을 만들 수 있다.

-- 고객별로 주문한 도서의 총수량과 총판매액을 구하시오.
select custid, sum(saleprice) as 총판매액, count(*) as 도서수량
from orders
group by custid;
    
-- having 절은 group by 절의 결과가 나타나는 그룹을 제한하는 역활을 한다.

-- 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량을 구하시오.
-- 단, 2권 이상 구매한 고객만 구하시오.
select custid, count(*) as 도서수량
from orders
where saleprice>=8000
group by custid
having count(*)>=2;

-- group by와 having 절의 문법과 주의사항

-- group by <속성>
-- 주의 사항
-- group by로 투플을 그룹으로 묶은 후 select절에는 group by에서 사용한 <속성>과
-- 집계 함수만 나올 수 있다.

-- having <검색조건>
-- 주의사항
-- where절과 having절이 가팅 포함된 sql문은 검색조건이 모호해질 수 있다.
-- having 절은 1. 반드시 group by절과 같이 작성해야 하고
-- 2. where절보다 뒤에 나와야 한다.
-- 3. <검색조건>에는 sum, avg, max, min, count와 같은 집계 함수가 와야 한다.

-- group by 절이 포함된 sql문의 실행 순서
-- sql문은 실행 순서가 없는 비절차적인 언어이지만 sql문은 내부적으로 샐행순서가 있다.

select custid, count(*) as 도서수량    -- 5
from orders                           -- 1
where saleprice>=8000                 -- 2
group by custid                       -- 3
having count(*)>=2                    -- 4
order by custid;                      -- 6








