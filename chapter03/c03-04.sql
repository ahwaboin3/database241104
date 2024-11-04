-- chapter03/c03-04.sql
-- sql문의 주석
-- 04 데이터 조작어 - 검색
-- 1. select문 문법
-- sql의 select문은 데이터를 검색하는 기본 문장으로, 특별히 질의어(query)라고 부른다.
-- 2. select문 예제

-- 모든 도서의 이름과 가격을 검색하시오.
select bookname, price 
from book;

-- sql문은 세미콜론(;)과 함께 끝난다.
-- 대소문자 구분이 없다.
-- sql 예약어는 대문자로, 테이블이나 속성이름은 소문자로 적어 준다.

-- select절에서 열 순서는 결과 테이블의 열 순서를 결정한다.
select price, bookname
from book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
select * from book;

-- book테이블의 모든 열을 보고 싶으면 '*'를 써 주면 열의 이름을 쓰지 않아도 된다.
-- '*'(asterisk)는 모든 열(all)을 나타 낸다.
-- 열의 개수가 많거나 열의 이름을 모를 때 편리하게 사용할 수 있다.

-- 도서 테이블에 있는 모든 출판사를 검색하시오.
select * from book;
select publisher from book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.2
select bookid, bookname, publisher,price
from book;

-- 도서 테이블에 있는 모든 출판사를 검색하시오.
select publisher from book;
-- sql문은 기본적으로 중복을 제거하기 않는다.

-- 중복을 제거하고 싶으면 distinct라는 키워드를 사용한다.
select distinct publisher
from book;

-- 조건 검색
-- 조건에 맞는 검색을 할 때는 where절을 사용한다.
-- 조건으로 사용할 수 있는 술어는 비교, 범위, 집합, 패턴, null로 구분할 수 있다.
-- where절에 조건으로 사용할 수 있는 술어
-- 술어 | 연산자
-- 비교 | =, < , >, <=, >=
-- 범위 | between
-- 집합 | in , not in
-- 패턴 | like
-- null | is null, is not null
-- 복합조건 | and , or , not








