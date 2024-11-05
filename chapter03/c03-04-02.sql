-- c03-04-02.sql

-- 두 개 이상 테이블에서 sql질의
-- 박지성 고객이 주문한 도서의 총구매액을 알고 싶으면 어떻게 해야 할까?
-- 총구매액은 saleprice값을 합하면 되지만 문제가 있다.
-- 구매액 saleprice는 orders테이블 있고 고객의 이름은 customer테이블에 있다.
-- 두 개 이상의 테이블을 이용한 sql질의를 사용한다.

-- sql은 여러 개의 테이블을 이용하여 질의하는 두 가지 방법을 제공한다.
-- 조인(join)과 부속질의(subquery)이다.

-- 조인
-- 조인은 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는
-- 연산이다.

-- 두 테이블을 아무런 조건을 주지 않고 select 해본다.
select *
from customer, orders;
-- customer테이블의 1번 고객 박지성은 oders테이블의 열 개 행 모두에 대해 결합하고,
-- 나머지 고객들도 각각 orders테이블의 열 개 행 모두에 대해 결합한다.
-- 필요한 것은 박지성의 custid가 1이므로 orders 테이블에서 custid가 1인 것만
-- 선택하면 된다.
-- 이것은 sql문의 where 절에 두 테이블의 연결 조건을 추가함으로써 쉽게 해결할 수 있다.

-- 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
select *
from customer c, orders o
where c.custid=o.custid;

-- 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
select *
from customer, orders
where customer.custid=orders.custid
order by customer.custid;

-- 열 이름을 표기하는 방법
-- '테이블 이름.열 이름'형식의 표현으로 열 이름이 어느 테이블과 연관되는지 정확히 명시한다.

-- 여러 개의 테이블을 연결하여 하나의 테이블을 만드는 과정을 조인이라고 한다.
-- 동등조건에 의하여 테이블을 조인하는 것을 동등조인(equi join)이라고 한다.

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select c.name, saleprice
from customer c, orders o
where c.custid=o.custid;

-- 모든 sql질의의 결과는 단일 테이블이다. 따라서 결과 테이블에 sql문법을 적용할 수 있다.

-- 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬하시오.
select name, sum(saleprice)
from customer, orders
where orders.custid = customer.custid
group by customer.name
order by customer.name;

-- 세 개 이상의 테이블을 조인할 수 있다.
select * from orders;

-- 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select c.name, b.bookname
from customer c, orders o, book b
where c.custid=o.custid and o.bookid=b.bookid;

-- 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select c.name, b.bookname
from customer c, orders o, book b
where c.custid=o.custid 
and o.bookid=b.bookid
and b.price=20000;

-- 동등 조인의 다른 문법
select *
from customer c join orders o 
on c.custid=o.custid;
select *
from customer c inner join orders o 
on c.custid=o.custid;

-- 조인 연산의 특별한 경우로 외부조인(outer join)이 있다.

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매 가격을 구하시오.
select customer.name, saleprice
from customer left outer join orders
    on customer.custid=orders.custid;

-- 조인 문법
-- 내부 조인
-- select <속성들>
-- from 테이블1, 테이블2
-- where <조인조건> and <검색조건>
-- select <속성들>
-- from 테이블1 inner join 테이블2 on <조인조건>
-- 외부조인
-- select <속성들>
-- from 테이블 1 {left|right|full [outer] join 테이블2 on <조인조건>
-- where <검색 조건>

-- 세 개 이상의 테이블은 테이블과 조인조건을 추가하여 작성한다




















