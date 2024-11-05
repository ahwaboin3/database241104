-- c03-04-03.sql

-- 부속 질의
-- sql문 내에 또 다른 sql문을 작성해 할 수 있다.
-- "가격이 가장 비싼 도서의 이름은 얼마인가?"라는 질문에 대한 답을 구한다고 생각해 보자.
-- 가장 비싼 도서의 가격을 구한다.
select max(price)
from book;

-- 가격이 35000원인 도서의 이름을 검색한다.
select bookname
from book
where price=35000;

-- 두 질의를 하나의 질의로 작성할 수 있다.

-- 가장 비싼 도서의 이름을 보이시오.
select bookname
from book
where price=
    (select max(price)
        from book);
-- 부속질의는 질의가 중첩되어 있다는 의미에서 중첩질의라고도 한다.
-- 부속질의 실행 순서
-- 1. where절의 부속질의를 먼저 처리하고 2 전체질의를 처리한다.

-- 부속 질의는 sql문이다. sql문의 결과는 테이블이며 테이블의 결과는 네가지 중 하나가 된다.
-- 단일행-단일열(1*1), 다중행-단일열(n*1), 단일행-다중열(1xn), 다중행-다중열(nxn)
-- 부속질의의 결과가 단일행-단일열로 한 개의 결과를 반환하는 경우 =(등호 연산)을 사용했다.
-- 부속질의의 결과가 다중행-단일열로 여러 개의 값을 반환하면 앞에서 배운 in 키워드를 사용한다.

-- 도서를 구매한 적이 있는 고객의 이름을 알려면 어떻게 해야 할까?
-- 도서를 구매한 적이 있는 고객은 여러 명이므로 다중행-단일열이 된다.
-- 먼저 orders테이블에서 주문 내역을 살펴보고, 주문한 고객의 고객 번호를 찾아야 한다.
select custid
from orders;

select name
from customer
where custid in (1,2,3,4);

-- 이제 두 질의를 하나로 합친다.
select name
from customer
where custid in(
    select custid from orders);
    
-- 세 개 이상의 중첩된 부족질의도 가능하다.

-- '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 보이시오.
select name
from customer
where custid in(select custid from orders
                where bookid in (select bookid from book
                                    where publisher='대한미디어'));

-- 1. 마지막 select문에서는 대한 미디어에서 출판한 도서의 bookid를 구한다
-- 2. 가운데 select문에서는 bookid를 주문한 고객의 custid를 구한다.
-- 3. 맨 위 select문에서는 찾은 custid에 대한 name을 구한다.

-- 부속질의 간에는 상하 관계가 있으며, 실행 순서는 하위 부속질의를 먼저 실행하고
-- 그 결과를 이용하여 상위 부속질의를 실행한다.

-- 상관 부속질의는 상위 부속질의의 투플을 이용하여 하위 부속질의를 계산한다.
-- 상위 부속질의와 하위 부속질의가 독립적이지 않고 서로 관련을 맺고 있다.

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select b1.bookname
from book b1
where b1.price>(select avg(b2.price)
                from book b2
                where b2.publisher=b1.publisher);
                
-- 조인은 부속질의가 할 수 있는 모든 것을 할 수 있다.
-- 한 개의 테이블에서만 결과를 얻는 것은 조인보다 부속질의로 작성하는 것이 편한다.

-- 집합 연산
-- 테이블은 투플의 집합이므로 테이블 간의 집합연산을 이용하여 합집합, 차집합, 교집합을
-- 구할 수 있다.
-- 합집합 union, 차집합은 minus, 교집합은 intersect

-- 도서를 주문하지 않은 고객의 이름을 보이시오.
select name
from customer
minus
select name
from customer
where custid in (select custid from orders);

-- exists
-- exists는 상관 부속질의문 형식이다. exists는 원래 단어에서 의미하는 것과 같이
-- 조건에 맞는 투플이 존재하면 결과에 포함시킨다.
-- 즉 부속질의문의 어떤 행이 조건에 만족하면 참이다.
-- 반면 not exists는 부속질의문의 모든 행이 조건에 만족하지 않을 때만 참이다.
-- exists와 not exists는 상관 부족질의문의 다른 형태이다.

-- 주문이 있는 고객의 이름과 주소를 보이시오.
select name, address
from customer cs
where exists(select *
            from orders od
            where cs.custid=od.custid);











