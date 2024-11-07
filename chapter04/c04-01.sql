-- chapter04/c04-01.sql

-- sql 고급
-- 01 내장 함수

-- 1. sql 내장 함수
-- 숫자 함수
-- 숫자 함수의 종류
-- 함수 | 설명 | 예
-- abs(숫자) | 숫자의 절대값 계산 | abs(-4.5)=4.5
-- ceil(숫자) | 숫자보다 크거나 같은 최소의 정수 | ceil(4.1)=5
-- floor(숫자) | 숫자보다 작거나 같은 최소의 정수 | floor(4.1)=4
-- round(숫자, m) | m 자리를 기준으로 숫자 반올림 | round(5.36, 1)=5.40
-- log(n, 숫자) | 숫자의 자연로그 값 반환 | log(10)=2.30259
-- power(숫자, n) | 숫자의 n제곱 값 계산 | power(2,3)=8
-- sqrt(숫자) | 숫자의 제곱근 값 계산(숫자는 양수) | sqrt(9.0)=3.0
-- sign(숫자) | 숫자가 음수이면 -1.0이면 0. 양수이면 1 | sign(3.45)=1

-- -78과 +78의 절대값을 구하시오.
select abs(-78), abs(+78)
from Dual;

-- Dual테이블
-- Dual 테이블은 실제로 존재하는 테이블이 아니라 오라클에서 일시적인 연산 작업에 사용하기 위해 만든 가상의 테이블이다.

-- 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오.
select round(4.875,1)
from Dual;

-- 숫자 함수는 입력값으로 숫자 대신 열이름도 사용할 수 있다. 또한 여러 함수를 복합적으로 사용할 수도 있다.

-- 고객별 평균 주문 금액을 백 원 단위로 반올림한 값을 구하시오.
select custid "고객변호", round(sum(saleprice)/count(*),-2) "평균금액"
from orders
group by custid;

-- 문자 함수

-- 문자 함수의 종류: 문자값을 반환 함수( s는 문자열, c는 문자, n과 k는 정수)
-- 함수 | 설명 | 예
-- chr(k) | 정수 아스키코드를 문자로 반환 | chr(68)='D'
-- concat(s1,s2) | 두 문자열을 연결 | concat('마당','서점')='마당서점'
-- initcap(s) | 문자열의 첫 번째 알파벳을 대문자로 변환 | initcap('the soap')='The Soap'
-- lower(s) | 대상 문자열을 모두 소문자로 변환 | lower('MR.SCOTT')='mr.scott'
-- LPAD(s, n, c) | 대상 문자열의 왼쪽부터 지정한 자릿수까지 지정한 문자로 채움 | LPAD('Page 1', 10, '*')='***Page 1'
-- LTRIM(s1, s2) | 대상 문자열의 왼쪽부터 지정한 문자들을 제거 | LTRIM('<==>BROWNING<==>','<>=')='BROWNING<==>'
-- REPLACE(s1, s2, s3) | 대상 문자열의 지정한 문자를 원하는 문자로 변경 
-- | REPLACE('JACK and JUE','J','BL')='BLACK and BLUE'
-- SUBSTR(s,n,k) | 대상 문자열의 지정된 자리에서부터 지정된 길이만큼 잘라서 반환 | substr('abcdefg',3,4)='cdef'
-- trim(c from s) | 대상 문자열의 양쪽에서 지정된 문자를 삭제(문자열만 넣으면 기본값으로 공백 제거)
-- | trim('=' from '==>browning<==') = '>browning<'
-- upper(s) | 대상 문자열을 모두 대문자로 변환 | upper('mr.scott')='MR.SCOTT'
-- length(s) | 대상 문자열의 글자 수를 반환 | length('candide')=7

-- 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록을 보이시오.
select bookid, replace(bookname, '야구','농구') bookname, publisher, price
from book;

-- '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
select bookname "제목", length(bookname) "글자수",
    lengthb(bookname) "바이트수"
from book
where publisher='굿스포츠';

-- 마당서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
select substr(name, 1, 1) "성", count(*) "인원"
from customer
group by substr(name,1,1);

select * from customer;

insert into customer values(5,'박세리','대한민국 서울',null);

-- 날짜, 시간 함수
-- 날짜 시간 함수의 종류
-- 함수 | 설명 | 예
-- to_date(char, datetime) | 문자형(char)데이터블 date형으로 변환 
-- | to_date('2020-09-14','yyyy-mm--dd'=2020-09-14
-- to_char | date형 데이터를 문자열(varchar2)로 반환
-- | to_char(to_date('2020-09-14','yyyy-mm-dd'),'yyyymmdd')='20200914'
-- add_months(date,숫자) | 날짜에 지정한 달을 더해 date형으로 변환(1:다음 달, -1:이전 달)
-- | add_months(to_date('2020-09-14', 'yyy-mm-dd'),12)=2021-09-14
-- last_day(date) | 날짜에 달의 마지막 날을 date형으로 변환
-- | last_day(to_date('2020-09-14','yyyy-mm-dd')))=2020-09-30
-- sysdate | dbms시스템상의 당일 날짜를 date형으로 반환하는 인자가 없는 함수
-- | sysdate=20/09/20

-- '-'와 '+'를 사용하여 원하는 날짜로부터 이전과 이후를 계산할 수 있습니다.
select to_date('2020-09-14','yyyy-mm-dd')+5 "before",
    to_date('2020-09-14','yyyy-mm-dd')-5 "after"
from Dual;

-- 화이트 데이 때 100일이 될려면 언제 사겨야 되나요?
select to_date('2025-03-14','yyyy-mm-dd')-100 "고백할 날짜" 
from Dual;

-- 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정 일자를 구하시오.
select orderid "주문번호", orderdate "주문일" , orderdate+10 "확정"
from orders;

-- 날짜 포맷 형식
-- 예를 들어 2020년 7월 1일을 yyyymmdd 로 쓰면 20200701인 된다.
-- 만약 14시 20분 14같이 시각 정보도 포함하려면 yyyymmddhh24miss 형태로 써 주면 된다.
-- 결과는 20200701142014로 반환된다.
select sysdate, to_char(sysdate, 'yy-mm-dd,hh24:ss') from dual;

-- 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를
-- 모두 보이시오. 단 주문일은 'yyyy-mm-dd 요일' 형태로 표시한다.
select orderid "주문번호", to_char(orderdate, 'yyyy-mm-dd  day') "주문일",
    custid "고객번호", bookid "도서번호"
from orders
where orderdate=TO_DATE('20200707','yyyymmdd');

-- sysdate 함수, systimestamp 함수
-- sysdate함수는 데이터베이스에 설정된 현재 날짜와 시간을 반환한다.
-- systimestamp함수는 현자 날짜, 시간과 함께 초 이하의 시간과 서버의 timezone까지 출력해 준다.

-- dbms 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') "sysdate_1"
from dual;











