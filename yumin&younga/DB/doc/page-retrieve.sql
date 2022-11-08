-- ---------------------------------
-- 마이페이지
-- 이름
select NNAME
from jang_member
where ID = x;
-- 사진
select PROFILE
from jang_member
where ID = x;
-- SNS 주소
select SNS
from jang_member
where ID = x;
-- MBTI
select MBTI
from jang_member
where ID = x;
-- 내가 좋아요 한 글 목록
select rec.TITLE
FROM 
	jang_so_recommendation rec, jang_like lik
where 
	rec.RECONO = lik.RECONO
	and lik.ID = x;
-- 내가 쓴 글 목록 제목, 작성일, 조회수, 좋아요
select rec.TITLE, rec.WDATE, rec.CNT, lik.cn
FROM
	jang_so_recommendation rec, 
    (select count(*) cn, ID
		from jang_like 
        where ID = x
        GROUP BY RECONO) lik
WHERE
	rec.ID = lik.ID;

-- 내가 쓴 댓글 목록
select com.CONT
from jang_comment com
where com.ID = x;

— 알림
select alram.CONT
from jang_alram alram, jang_member mem
where alram.ID = mem.ID;

-- follwer cnt
select count(*)
from jang_follow
where ID = x;

-- follwing
select count(*)
from jang_follow
where OTHID = x;

— 남의 마이페이지 글 목록 + 
select rec.TITLE
from jang_so_recommendation rec, 
	(select PRVNO from jang_so_review rev )
where rec.ID = x;

select rev.PRVNO
from 
	jang_so_recommendation rec, jang_so_review rev
where rec.RECONO = rev.RECONO
limit 1;

— 사진
select file.PATH 
from jang_so_review_file file,
	(select rev.PRVNO
	from 
		jang_so_recommendation rec, jang_so_review rev
	where rec.RECONO = rev.RECONO
	limit 1) rev1
where rev1.PRVNO = file.PRVNO;

— 기본 주소
select js.BASICAD
from jang_so js,
	(select rev.PLNO
	from 
		jang_so_recommendation rec, jang_so_review rev
	where 
		rec.RECONO = rev.RECONO
	limit 1) rev1
where js.PLNO = rev1.PLNO;