const reportForm = document.getElementsByClassName('modal-report-form')[0];
const reportBtn = document.getElementsByClassName('modal-report-form-submitBtn')[0];

reportBtn.addEventListener('click', () => {
  fetch('../recommendationReport').then(data => {
    if (data === 'true') {
      alert('신고접수가 완료되었습니다.');
      window.location.href = 'recommendationList';
    } else {
      alert('현재게시글은 신고할 수 없습니다.');
    }
  }).catch(err => console.log(err));
});


// select count(*) 
// from jang_report 
// join jang_so_recommendation 
// on jang_so_recommendation.recono=jang_report.recono 
// where jang_so_recommendation.id='user1'

Recommendation객체랑 그 Recommendation의 첫번째 장소리뷰의 첫번째 AttachedFile 객체를 하나의 ArrayList 에 담자.

ArrayList arr = {Recommendation, AttachedFile};

그리고 새 ArrayList를 만들어서 거기다가 arr를 add하자

List list = new ArrayList;
list.add(arr);

그걸 