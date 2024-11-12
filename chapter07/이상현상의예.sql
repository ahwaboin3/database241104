-- 이상현상의 발생과 해결 예
-- 잘못 설계된 계절학기 수강 테이블 예
-- 계절학기 수강 정보를 저장하는 summer테이블이다. 계절학기는 한 학생이 
-- 한 과목만 신청할 수 있다. summer테이블은 sid(학번), class(수강과목), 
-- price(수강료)로 구성되어 있으며, 한 학생이 한 과목만 신청할 수 있으므로
-- sid(학번)가 키가 된다.

drop table summer;

create table summer(
    sid number,
    class varchar2(20),
    price number
);

insert into summer values(100, 'java', 20000);
insert into summer values(150, 'database', 15000);
insert into summer values(200, 'html5', 10000);
insert into summer values(250, 'javascript', 20000);

select * from summer;

-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
select sid, class from summer;

-- java강좌의 수강료는?
select price from summer where class='java';

-- 수강료가 가장 비싼 과목은?
select distinct class from summer
where price=(select max(price) from summer);

-- 계절학기를 듣는 학생 수와 수강료 총액은?
select count(*), sum(price)
from summer;

-- select 문을 이용한 조회 작업은 별 문제 없이 처리할 수 있다.
-- 그러나 데이터를 조작하는 작업의 경우 이상현상이 발생한다.

-- 삭제이상
-- 200번 학생이 수강신청을 취소하여 delete문으로 관련 투플을 삭제하였다.
-- 200번 학생의 수강신청은 잘 취소되었으나 한 가지 문제가 있다. 삭제 전에
-- 조회할 수 있었던 html5강좌의 수강료를 조회할 수 없게 된 것이다.
-- 학생의 수강신청을 취소하면서 수강료도 함께 삭제 하였기 때문이다.
-- 200번 학생의 계절학기 수강신청을 취소하시오.
-- html5 강좌 수강료 조회
select price "html5 수강료"
from summer
where class='html5';
-- 200번 학생의 수강신청 취소
delete from summer
where sid=200;
-- html5 강좌 수강료 다시 조회
select price "html5 수강료"
from summer
where class='html5';

-- 다음 실습을 위해 200번 학생 자료 다시 입력
insert into summer values(200, 'html5', 10000);

-- 삽입이상
-- react 강좌가 새로 개설되었다. 수강료는 25000원이고 아직 신청한 학생이 없다.
-- 리액트 강좌를 추가하기 위해 insert문을 사용하는데, 신청한 학생이 없어
-- 학번에는 null값을 입력하였다. null값은 집계 함수 사용 시 원하지 않는 결과를
-- 만들어 낸다. null값이 포함된 테이블에 집계 함수를 사용하면 어떤 문제가
-- 발생하는지 sql문을 통해 이해해 보자.

-- 계절학기에 새로운 리액트 강좌를 개설하시오.
-- 리액트 강좌 삽입
insert into summer values (null,'react',25000);

-- summer 테이블 조회
select * from summer;

-- null 값이 있는 경우 주의할 질의: 투플은 다섯 개이지만 수강학생은 총 4명임
select count(*) "수강인원" from summer;

select count(sid) "수강인원" from summer;
select count(*) "수강인원"
from summer
where sid is not null;

-- 수정이상
-- javascript 강좌의 수강료가 20000원에서 15000원으로 변경되어 update문을
-- update문을 이용하여 수정하였다. update문은 조건에 맞는 값을 일괄 수정하지만,
-- 조건을 잘못 주면 데이터 불일치 문제가 발생한다.
-- 자바스크립트 강좌의 수강료를 20000원에서 15000원으로 수정하시오.
-- 자바스크립트 수강료 수정
update summer set price=15000
where class='javascript';

select * from summer;

-- 만약 update문을 다음과 같이 작성하면 데이터 불일치 문제가 발생함
update summer set price=15000
where class='javascript' and sid=250;












