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
-- 범위 | between and
-- 집합 | in , not in
-- 패턴 | like
-- null | is null, is not null
-- 복합조건 | and , or , not

-- 비교
-- 가격이 20000원 미만인 도서를 검색하시오.
select *
from book
where price<20000;

-- 범위
-- 가격이 10000원 이상 20000원이하인 도서를 검색하시오.
select *
from book
where price between 10000 and 20000;

-- 논리연산자 사용
select *
from book
where price>=10000 and price<=20000;

-- 집합
-- where절에 두 개 이상의 값을 비교하려면 in 연산자와 not in 연산자를 사용하면 편리하다.
-- in 연산자는 집합의 원소인지 판단하는 연산자이다.

-- 출판사가 '굿스포츠'혹은 '대한 미디어'인 도서를 검색하시오.
select *
from book
where publisher in ('굿스포츠','대한미디어');
-- sql문의 문자열은 작은 따옴표로 감싼다.

-- 출판사가 '굿스포츠'혹은 '대한미디어'가 아닌 출판사를 검색하는 sql문을 작성하시오.
select *
from book
where publisher not in ('굿스포츠','대한미디어');

-- 패턴
-- 문자열의 패턴을 비교할 때는 like연산자를 사용한다.

-- "축구의 역사"를 출간한 출판사를 검색하시오.
select publisher, bookname
from book
where bookname like '축구의 역사';

-- 텍스트 혹은 날짜 데이터는 영문 작은따옴표('')로 둘러싸야 한다.
-- 한글의 작은따옴표('')를 사용하면 오류가 난다.

-- 별칭(a.k.a)
-- 속성 다음에 as키워드 다음에 별칭을 붙일 수 있다.
-- 별칭은 ""(큰따옴표)로 감싸는 것은 선택사항이다.
-- 별칭 이름에 공백이 포함될 때는 ""(큰따옴표)를 반드시 사용한다.
select bookname as "책 이름"
from book;

select bookname "책 이름"
from book;
-- as는 생략 가능 하다

select book.bookname
from book;

select b.bookname
from book b;

-- 도서이름에 '축구'가 포함된 출판사를 검색하시오.
-- 와일드 문자'%'를 사용한다
-- '%'아무 문자열이나 대신하는 기호이다.
select bookname,publisher
from book
where  bookname like '%축구%';

-- 와일드 문자 _(밑줄)는 특정 위치에 한 문자만 대신할 때 사용한다.

-- 도서 이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
select *
from book
where bookname like '_구%';

-- 와일드 문자의 종류
-- 와일드 문자 | 의미 | 사용 예
-- + | 문자열을 연결 | '골프'+'바이블':'골프바이블'
-- % | 0개 이상의 문자열과 일치 | '%축구%':축루를 포함하는 문자열
-- [] | 한 개의 문자와 일치 |'[0-5]%':0~5사이 숫자로 시작하는 문자열
-- [^] | 한 개의 문자와 불일치 | '[^0-5]%':0~5사이 숫자로 시작하지 않는 문자열
-- _ | 특정 위치의 한 개의 문자와 일치 | '_구%':두 번째 위치에 '구'가 들어 가는 문자열

-- 복합조건 검색
-- 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오.
select *
from book
where bookname like '%축구%' and price>=20000;

-- 출판사가 '굿스포츠'혹은 '대한 미디어'인 도서를 검색하시오.
select *
from book
where publisher='굿스포츠' or publisher='대한미디어';













