-- 전시회 입력
-- insert into jang_exhibition(EXNAME, CONT, STDATE, EDDATE, PRICE, PLNO) 
-- values (#{EXNAME}, #{CONT}, #{STDATE} #{EDDATE}, #{PRICE}, 
-- (
--   select
--     PLNO
--   from
--     jang_so
--   where

-- ))



------------------------------------------------------------------------------------

-- 221018. 사용할 조회문 미리 작성해두기

------------------------------------------------------------------------------------
-- 진행중 전시회 목록
select 
  jexhb.EXNO, -- 전시회번호
  jexhb.EXNAME, -- 전시회제목
  jexhb.STDATE, -- 시작일
  jexhb.EDDATE, -- 종료일
  jexhbf.EXFNO, -- 전시회게시글첨부파일번호
  jexhbf.PATH -- 전시회게시글첨부파일경로
from 
  jang_exhibition jexhb 
join 
  jang_exhibition_file jexhbf 
    on 
      jexhb.EXNO = jexhbf.EXNO
where 
  (jexhb.STDATE < CURDATE()) and (jexhb.EDDATE > CURDATE())



-- 진행예정 전시회 목록
select 
  jexhb.EXNO, -- 전시회번호
  jexhb.EXNAME, -- 전시회제목
  jexhb.STDATE, -- 시작일
  jexhb.EDDATE, -- 종료일
  jexhbf.EXFNO, -- 전시회게시글첨부파일번호  
  jexhbf.PATH -- 전시회게시글첨부파일경로
from 
  jang_exhibition jexhb 
join 
  jang_exhibition_file jexhbf 
    on 
      jexhb.EXNO = jexhbf.EXNO
where 
  jexhb.STDATE > CURDATE()



-- 진행완료 전시회 목록
select 
  jexhb.EXNO, -- 전시회번호
  jexhb.EXNAME, -- 전시회제목
  jexhb.STDATE, -- 시작일
  jexhb.EDDATE, -- 종료일
  jexhbf.EXFNO, -- 전시회게시글첨부파일번호
  jexhbf.PATH -- 전시회게시글첨부파일경로
from 
  jang_exhibition jexhb 
join 
  jang_exhibition_file jexhbf 
    on 
      jexhb.EXNO = jexhbf.EXNO
where 
  jexhb.EDDATE < CURDATE()


------------------------------------------------------------------------------------
-- 상세페이지 - 한줄 리뷰
select 
  jexhb.*, -- 전시회-전부
  jso.PLNO, -- 장소-장소번호
  jso.PLNAME, -- 장소-장소명
  jso.QCALL, -- 장소-문의번호
  jso.BASICAD, -- 장소-기본주소
  jso.DETAILAD, -- 장소-상세주소
  jexhbrv.*, -- 전시회한줄리뷰-전부
  jexhbf.EXFNO, -- 전시회게시글첨부파일번호
  jexhbf.PATH -- 전시회게시글첨부파일경로
from 
  jang_exhibition jexhb 
join 
  jang_exhibition_file jexhbf 
    on 
      jexhb.EXNO = jexhbf.EXNO 
join 
  jang_so jso 
    on 
      jexhb.PLNO = jso.PLNO 
left outer join 
  jang_exhibition_review jexhbrv 
    on 
      jexhb.EXNO = jexhbrv.EXNO 


-- 상세페이지 - 해당 장소 포함 후기
-- -- 이거 없애지 않았나?? 전시회는 아예 따로 빼버린다 했던거 같은데
-- select 
--   jexhb.*, -- 전시회-전부
--   jso.PLNO, -- 장소-장소번호
--   jso.PLNAME, -- 장소-장소명
--   jso.QCALL, -- 장소-문의번호
--   jso.BASICAD, -- 장소-기본주소
--   jso.DETAILAD, -- 장소-상세주소
--   jexhbf.EXFNO, -- 전시회게시글첨부파일번호
--   jexhbf.PATH -- 전시회게시글첨부파일경로
-- from 
--   jang_exhibition jexhb 
