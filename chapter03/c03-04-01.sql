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
    














