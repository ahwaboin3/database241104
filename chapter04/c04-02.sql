-- c04-02.sql

-- 02 부속질의
-- 부속질의의 종류
-- 명칭 | 위치 | 설명
-- 중첩질의 | where 절 | where절에 술어와 같이 사용되며 결과를 한정시키기 위해 사용된다.
-- 스칼라 부속질의 | select절 | select절에서 사용되며 단일 값을 반환하기 때문에
-- 스칼라 부속질의라고 한다.
-- 인라인 뷰 | from 절 | from절에서 결과를 뷰형태로 반환하기 때문에 인라인 뷰라고 한다.

-- 상관 부속질의 : 주 질의의 특정 열 값을 부속질의가 상속받아 부속질의의 질의에 사용하는 형태이다
-- 비상관 부속질의 : 독딥된 징의를 수행해서 결과값을 가져오는 형태이다.

-- 1. 중첩질의 - where 부속 질의
-- 중첩질의 연산자의 종류
-- 술서 | 연산자 | 반환 행 | 반환 열 | 상관
-- 비교 | =,>,<,>=,<= | 단일 | 단일 | 가능
-- 집합 | in, not in | 다중 | 다중 | 가능
-- 한정 | all, some(any) | 다중 | 단일 | 가능
-- 존재 | exists, not exists | 다중 | 다중 | 필수

-- 비교 연산자
-- 비교 연산자는 부속질의가 반드시 단일 행, 단일 영을 반환해야 하며 아닐 경우 질의를
-- 처리 할 수 없다. 처리 과정은 주 질의의 대상 열 속성의 값과 부속질의의 결과값을
-- 비교 연산자에 적용하여 참이면 주 질의의 해당 행을 출력한다.

-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice)
                    from orders);
                    
-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
select orderid, custid, saleprice
from orders md
where saleprice>(select avg(saleprice)
                from orders so
                where md.custid=so.custid);
                
-- in, not in 
-- 집합 연산 중 in은 주 질의의 속성값이 부속질의에서 제공한 결과 집합에 있는지 확인
-- 하는 역활을 한다.

-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
select sum(saleprice) "total"
from orders
where custid in (select custid
                from customer
                where address like '%대한민국%');

-- all, some(any)
-- all, some(any)연산자는 비교 연산자와 함께 사용된다. all은 모든, some은 어떠한
-- (최소한 하나라도)이라는 의미를 가진다. any는 some과 동일한 기능을 한다.

-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을
-- 보이시오.
select orderid, saleprice
from orders
where saleprice> all (select saleprice
from orders
where custid=3);

-- 문법
-- 비교 연산자 {all|some|any}(부속질의)

-- exists, not exists
-- 존재 연산자인 exists와 not exists는  데이터의 존재 여부를 확인한다. 주 질의에서
-- 부속질의로 제공된 속성의 값을 가지고 부속질의의 조건을 만족하여 값이 존재하면
-- 참이 되고, 주 질의는 해당 행의 데이터를 출력한다. not exist의 경우 이와 반대로 동작한다.
-- 문법 구조
-- where [not] exists (부속질의)
-- exists 연산자는 다른 연산자와 달리 왼쪽에 스칼라 값이나 열을 명시하지 않는다
-- 때문에 반드시 부속질의 주 질의의 열이름이 제공되어야 한다.
-- 부속질의는 필요한 값이(조건을 만족하는 행)발견되면 참값을 반환한다.

-- exists 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
select sum(saleprice) "total"
from orders od
where exists (select *
from customer cs
where address like '%대한민국%' and cs.custid=od.custid);

-- 스칼라 부속질의 - select 부속질의
-- 스칼라 부속질의는 select절에서 사용되는 부속질의로 부속질의의 결과값은
-- 단일 행, 단일 열의 스칼라값으로 반환한다. 만약 결과값이 다중 행이거나 다중 열이라면
-- dbms는 그 중 어떠한 행, 어떠한 열을 출력해야 하는 지 알 수 없어 에러를 출력한다.
-- 또 결과가 없는 경우에는 null값을 출력한다. 일반적으로 select문과 update set절에 사용된다.

-- 마당서점의 고객별 판매액을 보이시오.(고객이름과 고객별 판매액 출력).
select (select name
        from customer cs
        where cs.custid=od.custid) "name",
        sum(saleprice) "total"
from orders od
group by od.custid;

-- 스칼라 부속질의는 select문과 함께 update문에서도 사용할 수 있다.

-- orders 테이블에 새로운 속성인 도서이름(bookname)을 추가해 보자.
alter table orders add bookname varchar2(40);

select * from orders;
-- 새로운 속성에는 null값이 저장되어 있다.

-- 스칼라 부속질의를 사용하면 도서이름을 일과 수정할 수 있다.

-- orders 테이블에 각 주문에 맞는 도서이름을 입력하시오.
update orders
set bookname=(select bookname
                from book
                where book.bookid=orders.bookid);
                
select * from orders;

-- 3. 인라뷰 - from 부속질의
-- 뷰는 기존 테이블로부터 일시적으로 만들어진 가상의 테이블을 말한다.
-- sql문의 from절에는 테이블 이름이 위치하는데 여기에 테이블 이름 대신 인라인 뷰 부속질의를
-- 사용하면 보통의 테이블과 같은 형태로 사용할 수 있다.
-- 부속질의 결과 반환되는 데이터는 다중 행, 다중 열이어도 상관없다.

-- 고객번호가 2이하인 고객의 판매액을 보이시오(고객 이름과 고객별 판매액 출력)
select cs.name, sum(od.saleprice) "total"
from orders od,
    (select custid, name
    from customer
    where custid<=2) cs
where cs.custid=od.custid
group by cs.name;






























