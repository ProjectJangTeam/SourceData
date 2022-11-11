let place_name_list = [];
let road_address_name_list = [];
let phone_list = [];
let x_list = [];
let y_list = [];

const doSearch = function () {
  place_name_list.splice(0);
  road_address_name_list.splice(0);
  phone_list.splice(0);
  x_list.splice(0);
  y_list.splice(0);

  const keyword = $(".ga-input-box").val();

  if (keyword.length > 0) {
    $.ajax({
      url:
        "https://dapi.kakao.com/v2/local/search/keyword.json?size=5&query=" +
        encodeURIComponent(keyword),
      type: "GET",
      headers: {
        Authorization: "KakaoAK 0164bda1178748f8b8e6ff5f441710a0",
      },
      success: function (data) {
        for (let i = 0; i < data.documents.length; i++) {
          place_name_list.push(data.documents[i].place_name);
          road_address_name_list.push(data.documents[i].road_address_name);
          phone_list.push(data.documents[i].phone);
          x_list.push(data.documents[i].x);
          y_list.push(data.documents[i].y);
        }
        $("#searchOptions").html("");
        for (let i = 0; i < place_name_list.length; i++) {
          if (road_address_name_list[i].length >= 4) {
            $("#searchOptions").append(
              $("<option>").html(
                place_name_list[i] + ", " + road_address_name_list[i]
              )
            );
          } else if (road_address_name_list[i].length < 4) {
            $("#searchOptions").append($("<option>").html(place_name_list[i]));
          }
        }
      },
      error: function (e) {
        console.log(e);
      },
    });
  }
};

// fin_after_select 배열을 form submit 할 때 같이 보내기
let fin_before_select = "";
const fin_after_select = [];

const doAdd = function () {
  $(".ga-input-box").attr("readonly", true);
  fin_after_select.push(fin_before_select);
  console.log(fin_after_select);
};

$(document).on("change", "input", function () {
  let options = $("datalist")[0].options;
  let val = $(this).val();
  fin_before_select = "";
  for (var i = 0; i < options.length; i++) {
    if (options[i].value === val) {
      fin_before_select =
        place_name_list[i] +
        "," +
        road_address_name_list[i] +
        "," +
        phone_list[i] +
        "," +
        x_list[i] +
        "," +
        y_list[i] +
        "//";
      break;
    }
  }
});

$("#place-add-btn1").click(doAdd);
$(".ga-input-box").keyup(doSearch);
