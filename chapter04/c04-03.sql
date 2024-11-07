-- c04-03.sql

-- 뷰
-- 뷰는 가상의 테이블이다.
-- select문을 통해 얻은 최종 결과를 가상의 테이블로 정의하여 실제 테이블처럼 사용할 수
-- 있도록 만든 데이터베이스 개체이다.

-- 뷰의 장점
-- 편리성 : 여러 테이블에서 데이터를 가져와 하나의 테이블로 정의함으로써 질의 작성이
-- 간단하게 된다. 또 미리 작성된 질의를 뷰로 정의해 두면 질의 재사용이 가능하다.
-- 보안성 : 원본 테이블에서 보안이 필요한 속성을 제외하고 새로운 테이블을 정의하여
-- 사용자에게 제공함으로써 데이터 보안성을 높인다.
-- 논리적 데이터 독립성 : 뷰를 정의하여 응용 프로그램이 사용하게 하면 개념스키마에 정의된
-- 테이블 구조가 변경되어도 응용 프로그램의 변경을 막아 주기 때문에 논리적 데이터 독립성
-- 을 제공한다.

-- 뷰는 테이블처럼 사용할 수 있지만, select문을 제외한 일부 물리적인 테이블의 갱산 작업을
-- 수행하는데 제약이 있다. insert, update, delete 등의 dml작업은 경우에 따라 수행되지 않는다.

-- 1. 뷰의 생성
-- 문법
-- create view 뷰이름 [(열이름[,...n])]
-- as <select 문>

-- book테이블에서 '축구'라는 문구가 포함된 자료만 보여주는 뷰 만들기
select *
from book
where bookname like '%축구%';

create view vw_book
as select *
from book
where bookname like '%축구%';

select * from vw_book;
-- 뷰가 생성되면 일반 테이블처럼 사용할 수 있다.
-- 뷰는 실제 데이터가  저장되는 게 아니라 뷰의 정의가 dbms에 저장되는 것이다.
-- book 테이블에 축구라는 문구를 포함한 도서가 새로 추가되면 이 데이터 역시 뷰에도 나타난다.
-- 만약 추가되는 도서이름에 '축구'라는 문구가 포함되어 있지 않으면 book테이블에 존재하지만
-- 뷰에서는 나타나지 않는다.

-- 주소에 대한민국을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오.
-- 뷰의 이름 vw_customer로 설정
create view vw_customer
as select *
    from customer
    where address like '%대한민국%';

select * from vw_customer;
-- create view 문에 열이름에 대한 특별한 정의가 없으면 vw_customer는 select문의 열이름을
-- 그대로 가져와 뷰를 생성한다.

-- orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, 김연아 고객이
-- 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
create view vw_orders(orderid, custid, name, bookid, bookname, saleprice,
    orderdate)
as select od.orderid, od.custid, cs.name,
    od.bookid, bk.bookname, od.saleprice, od.orderdate
from orders od, customer cs, book bk
where od.custid=cs.custid and od.bookid=bk.bookid;

select * from vw_orders;

select orderid, bookname, saleprice
from vw_orders
where name='김연아';









