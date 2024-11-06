-- c03-05.sql

-- 데이터 정의어
-- 데이터를 저장하려면 먼저 데이터를 저장할 테이블의 구조를 만들어야 한다
-- sql의 데이터 정의어는 바로 이 구조를 만드는 명령이다.
-- 데이터 정의어는 테이블의 구조를 만드는 create문, 구조를 변경하는 alter문
-- 구조를 삭제하는 drop문이 있다.

-- 1. create문
-- create 문은 테이블을 구성하고, 속성과 속서에 관한 제약을 정의하며,
-- 기본키 및 외래키를 정의하는 명령이다. 

-- create문의 문법
-- create table 테이블이름(
--  {속성이름 테이터타입 [null|not null|unique|default 기본값|check 체크조건]}
--  [primary key 속성이름(들)]
--  [foreign key 속성이름 references 테이블이름(속성이름)]
--      [on delete {cascade|set null}]
--)
-- 문법에 {}안의 내용은 반복 가능, []은 선택적으로 사용, |는 한 개를 선택
-- not null : null값을 허용하지 않은 제약
-- unique : 유일한 값에 대한 제약
-- default: 기본 값 설정
-- check: 값데 대한 조건을 부여할 때 사용한다.
-- primary key :기본키를 정할 때
-- foreign key: 외래키를 지정할 때
-- on delete: 투플의 삭제 시 외래키 속성에 대한 동작을 나타낸다
-- on delete옵션으로는 cascade, set null이 있다
-- on delete를 명시 하지 않으면 restrict(no action)이다.

-- 문자형 데이터 타입 - char, varchar, varchar2
-- char(n) n바이트를 가진 문자형 타입이다. 저장되는 문자의 길이가 n보다 작으면
-- 나머지는 공백으로 채워 n바이를 만들어 저장한다.
-- varchar2(n)타입은 마찬가지로 n바이트를 가진 문자형 타입이지만 저장되는 문자의 길이만큼만
-- 기억장소를 차지하는 가변형이다.
-- varchar 타입은 varchar2타입과 같지만 오라클에서 미래 업데이트를 염두해 두고
-- 사용자에게 varchar2을 사용할 것을 권하고 있다.
-- 문자형 데이터를 사용할 때 주의할 점은, char에 저장된 값과 varchar2에 저장된 값이
-- 비록 같을지라도 char은 공백을 채운 문자열이기 때문에 동등 비교 시 실패할 수 있습니다.

-- NewBook테이블을 생성합니다.
-- 정수형은 number를 사용하며 문자형은 가변형 문자 타입인 varchar2를 사용한다
-- bookid(도서번호) - number
-- bookname(도서 이름) - varchar2(20) - 20byte ->유니코드 한문자당 2byte 
-- ->10자 정도 넣을 수 있다. 
-- publisher(출판사) - varchar2(20)
-- price(가격)-number

create table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number);

-- 테이블 삭제
drop table newbook;

-- bookid를 기본키로 지정한다.
create table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookid));

drop table newbook;

-- 기본키를 지정하는 다른 방법
create table newbook(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number);
    
-- 두 개의 속성 bookname, publisher가 기본키로 복합키를 지정
drop table newbook;

create table newbook(
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookname,publisher));

-- newbook 테이블의 좀 더 복잡한 제약사항을 추가
-- bookname은 null값을 가질 수 없고, publisher는 같은 값이 있으면 안 된다.
-- price에 값이 입력되지 않을 경우 기본값 10000을 저장한다. 또 가격은 최소 1000원 이상으로 한다.
drop table newbook;

create table newbook(
    bookid number primary key,
    bookname varchar2(20) not null,
    publisher varchar2(20) unique,
    price number default 10000 check(price>1000));

-- newcustomer테이블을 생성하시오.
-- custid(고객번호) - number, 기본키
-- name(이름) - varchar2(40)
-- address(주소) - varchar2(40)
-- phone(전화번호) - varchar2(30)

create table NewCustomer(
    custid number primary key,
    name varchar2(40),
    address varchar2(40),
    phone varchar2(30));
    
-- 외래키는 다른 테이블의 기본키여야 한다.

-- 다음과 같은 속성을 가진 neworders 테이블을 생성하시오.
-- orderid(주문번호)-number, 기본키
-- custid(고객번호)-number, not null제약조건, 외래키(newcustomer.custid, 연쇄삭제)
-- bookid(도서번호)-number, not nul 제약조건
-- saleprice(판매가격)-number
-- orderdate(판매일자)-date

create table neworders(
    orderid number,
    custid number not null,
    bookid number not null,
    saleprice number,
    orderdate date,
    primary key(orderid),
    foreign key(custid) references newcustomer(custid) on delete cascade);
    
-- 외래키 제약 조건을 명시할 때는 주의할 점이 있다.
-- 반드시 참조되는 테이블(부모 릴레이션)이 존재해야 하며 참조되는 테이블의 기본키여야 한다.
-- 외래키 지정시 on delete 옵션은 참조되는 테이블의 투플이 삭제될 때 취할 수 있는 동작을 지정한다.
-- cascade옵션
-- newcustomer테이블 투플이 삭제되면 참조하는 neworders테이블의 해당 투플이 연쇄삭제(cascade)된다.
-- set null 옵션은 null 값으로 바꾼다
-- no action 옵션은 기본 값으로 어떠한 동작도 취하지 않는다.

-- 속성의 데이터 타입 종류
-- 테이터 타입 | 설명
-- number(p,s) | 실수형 p자리 정수 부분. s자리 소수부분, p와 s를 생략하면 number(8,2)로 저장 된다
-- char(n) | 문자형 고정길이. 문자를 저장하고 남은 공간은 공백을 채운다
-- varchar2(n) | 문자형 가변길이, 4000바이트까지 저장된다
-- date | 날짜형. 연도, 월, 일, 시간을 저장한다.

-- alter문
-- alter문은 생성된 테이블의 속성과 속성에 관한 제약을 변경하며, 기본키 및 외래키를 변경한다.
-- alter문의 문법
-- alter table 테이블이름
-- [add 속성이름 데이터 타입]
-- [drop column 속성이름]
-- [modify 속성이름 데이터타입]
-- [modify 속성이름 [null | not null]]
-- [add primary key(속성이름)]
-- [[add|drop] 제약 이름]

drop table newbook;

create table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number);

-- newbook 테이블에 varchar2(13)의 자료형을 가진 isbn속성을 추가하시오.

-- 테이블을 수정하려면 테이블을 삭제하고 다시 생성해도 되지만 테이블에 저장된 데이터를 그대로 두고
-- 변경할 때는 alter문을 사용한다

alter table newbook add isbn varchar2(13);

select * from newbook;

-- newbook 테이블의 isbn속성의 데이터 타입을 number형으로 변경하시오.
alter table newbook modify isbn number;

-- newbook 테이블의 isbn속성을 삭제하시오.
alter table newbook drop column isbn;

-- newbook 테이블의 bookname 속성에 not null제약조건을 적용하시오.
alter table newbook modify bookname varchar(20) not null;

-- ansi sql - sql 표준

-- newbook 테이블의 bookid속성을 기본키로 변경하시오.
alter table newbook add primary key(bookid);

-- drop 문
-- drop문은 테이블을 삭제하는 명령이다. drop문은 테이블의 구조와 데이터를 모두 삭제 하므로
-- 사용에 주의해야 한다. 데이터만 삭제하려면 delete문을 사용한다.
-- drop문의 문법
-- drop table 테이블이름

-- newbook 테이블을 삭제하시오.
drop table newbook;

-- newcustomer 테이블 삭제 하시오.
create table NewCustomer(
    custid number primary key,
    name varchar2(40),
    address varchar2(40),
    phone varchar2(30));
create table neworders(
orderid number,
custid number not null,
bookid number not null,
saleprice number,
orderdate date,
primary key(orderid),
foreign key(custid) references newcustomer(custid) on delete cascade);
drop table newcustomer;
-- 삭제하려며는 테이블의 기본키를 다른 테이블에서 참조하고 있다면 삭제가 거절된다.
-- newcutomer테이블을 삭제하기 위해서는 참조하고 있는 테이블 neworders테이블 부터 삭제해야 한다.
drop table neworders;
drop table newcustomer;


























