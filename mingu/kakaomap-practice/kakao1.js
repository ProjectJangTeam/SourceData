var place_name_list = [];
var road_address_name_list = [];
var phone_list = [];
var x_list = [];
var y_list = [];

var doSearch = function() {

  place_name_list.length = 0;
  road_address_name_list.length = 0;
  phone_list.length = 0;
  x_list.length = 0;
  y_list.length = 0;

  var keyword = $(".ga-input-box").val();

  if (keyword.length > 0) {

    $.ajax({
      url:'https://dapi.kakao.com/v2/local/search/keyword.json?size=5&query='+encodeURIComponent(keyword),
      type:'GET',
      headers: {'Authorization' : 'KakaoAK 0164bda1178748f8b8e6ff5f441710a0'},
      success:function(data) {
        for (let i = 0; i < data.documents.length; i++) {
          place_name_list.push(data.documents[i].place_name);
          road_address_name_list.push(data.documents[i].road_address_name);
          phone_list.push(data.documents[i].phone);
          x_list.push(data.documents[i].x);
          y_list.push(data.documents[i].y);
        }
        for (let i = 0; i < data.documents.length; i++) {
          if (road_address_name_list[i].length >= 4) {
            $('option').eq(i).val(place_name_list[i] + ', ' + road_address_name_list[i]);
          } else if (road_address_name_list[i].length < 4) {
            $('option').eq(i).val(place_name_list[i]);
          }
        }
      },
      error : function(e) {
        console.log(e);
      }
    });
  }
};


// 아래 다섯개 배열들을 form submit 할 때 같이 보내기
var fin_place_name_list = [];
var fin_road_address_name_list = [];
var fin_phone_list = [];
var fin_x_list = [];
var fin_y_list = [];

var doAdd = function () {
  $(".ga-input-box").attr("readonly", true);
  var word = $(".ga-input-box").val().split(', ');
  for (let i = 0; i < place_name_list.length; i++) {
    if (place_name_list[i] == word[0]) {
      fin_place_name_list.push(place_name_list[i]);
      fin_road_address_name_list.push(road_address_name_list[i]);
      fin_phone_list.push(phone_list[i]);
      fin_x_list.push(x_list[i]);
      fin_y_list.push(y_list[i]);
      break;
    }
  }
  console.log(place_name_list, road_address_name_list, phone_list, x_list, y_list);
};

$("#place-add-btn1").click(doAdd);
$(".ga-input-box").keyup(doSearch);
