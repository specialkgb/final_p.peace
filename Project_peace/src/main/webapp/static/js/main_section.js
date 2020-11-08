// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(35.160219, 126.910007), // 지도의 중심좌표
    level: 3, // 지도의 확대 레벨
  };

// 지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);
map.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);

kakao.maps.event.addListener(map, "zoom_changed", function () {
  if (map.getLevel() < 3) {
    map.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);
  } else {
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);
  }
});

if (navigator.geolocation) {
  // GeoLocation을 이용해서 접속 위치를 얻어옵니다
  navigator.geolocation.getCurrentPosition(function (position) {
    var lat = position.coords.latitude, // 위도
      lon = position.coords.longitude; // 경도

    var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
      message = '<div style="padding:5px;color:red;">현재위치</div>'; // 인포윈도우에 표시될 내용입니다
    displayMarker(locPosition, message);
  });
} else {
  var locPosition = new kakao.maps.LatLng(35.160219, 126.910007);
}

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

function displayMarker(locPosition, message) {
  // 마커를 생성합니다
  var marker = new kakao.maps.Marker({
    map: map,
    position: locPosition,
  });
  var iwContent = message, // 인포윈도우에 표시할 내용
    iwRemoveable = true;

  // 인포윈도우를 생성합니다
  var infowindow = new kakao.maps.InfoWindow({
    content: iwContent,
    removable: iwRemoveable,
  });

  // 인포윈도우를 마커위에 표시합니다
  infowindow.open(map, marker);
  map.setLevel(3);
  map.setCenter(locPosition);
}

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
  var keyword = document.getElementById("keyword").value;

  if (!keyword.replace(/^\s+|\s+$/g, "")) {
    alert("키워드를 입력해주세요!");
    return false;
  }

  // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
  ps.keywordSearch(keyword, placesSearchCB);
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
  if (status === kakao.maps.services.Status.OK) {
    // 정상적으로 검색이 완료됐으면
    // 검색 목록과 마커를 표출합니다
    displayPlaces(data);

    // 페이지 번호를 표출합니다
    displayPagination(pagination);
  } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
    alert("검색 결과가 존재하지 않습니다.");
    return;
  } else if (status === kakao.maps.services.Status.ERROR) {
    alert("검색 결과 중 오류가 발생했습니다.");
    return;
  }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
  var listEl = document.getElementById("placesList"),
    menuEl = document.getElementById("menu_wrap"),
    fragment = document.createDocumentFragment(),
    bounds = new kakao.maps.LatLngBounds(),
    listStr = "";

  // 검색 결과 목록에 추가된 항목들을 제거합니다
  removeAllChildNods(listEl);

  // 지도에 표시되고 있는 마커를 제거합니다
  removeMarker();

  for (var i = 0; i < places.length; i++) {
    // 마커를 생성하고 지도에 표시합니다
    var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
      marker = addMarker(placePosition, i),
      itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    // LatLngBounds 객체에 좌표를 추가합니다
    bounds.extend(placePosition);

    // 마커와 검색결과 항목에 click 했을때
    // 해당 장소에 인포윈도우에 장소명을 표시합니다
    // mouseout 했을 때는 인포윈도우를 닫습니다
    (function (marker, title) {
      kakao.maps.event.addListener(marker, "click", function () {
        displayInfowindow(marker, title);
      });

      kakao.maps.event.addListener(marker, "mouseout", function () {
        infowindow.close();
      });

      itemEl.onclick = function () {
        displayInfowindow(marker, title);
      };

      itemEl.onmouseout = function () {
        infowindow.close();
      };
    })(marker, places[i].place_name);
    fragment.appendChild(itemEl);
  }

  // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
  listEl.appendChild(fragment);
  menuEl.scrollTop = 0;

  // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
  map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
  var el = document.createElement("li"),
    itemStr =
      '<span class="markerbg marker_' +
      (index + 1) +
      '"></span>' +
      '<div class="info">' +
      "   <h5>" +
      places.place_name +
      "</h5>";

  if (places.road_address_name) {
    itemStr +=
      "    <span>" +
      places.road_address_name +
      "</span>" +
      '   <span class="jibun gray">' +
      places.address_name +
      "</span>";
  } else {
    itemStr += "    <span>" + places.address_name + "</span>";
  }

  itemStr += '  <span class="tel">' + places.phone + "</span>" + "</div>";

  el.innerHTML = itemStr;
  el.className = "item";

  return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
  var imageSrc =
      "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
    imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
    imgOptions = {
      spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
      spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
      offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
    },
    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
    marker = new kakao.maps.Marker({
      position: position, // 마커의 위치
      image: markerImage,
    });

  marker.setMap(map); // 지도 위에 마커를 표출합니다
  markers.push(marker); // 배열에 생성된 마커를 추가합니다

  return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
  var paginationEl = document.getElementById("pagination"),
    fragment = document.createDocumentFragment(),
    i;

  // 기존에 추가된 페이지번호를 삭제합니다
  while (paginationEl.hasChildNodes()) {
    paginationEl.removeChild(paginationEl.lastChild);
  }

  for (i = 1; i <= pagination.last; i++) {
    var el = document.createElement("a");
    el.href = "#";
    el.innerHTML = i;

    if (i === pagination.current) {
      el.className = "on";
    } else {
      el.onclick = (function (i) {
        return function () {
          pagination.gotoPage(i);
        };
      })(i);
    }

    fragment.appendChild(el);
  }
  paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
  var content = '<div style="padding:5px;z-index:1;">' + title + "</div>";

  infowindow.setContent(content);
  infowindow.open(map, marker);

  map.setLevel(3);
  map.panTo(marker.getPosition());
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {
  while (el.hasChildNodes()) {
    el.removeChild(el.lastChild);
  }
}

// 출발, 도착 마커 생성자
var startSrc =
    "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png", // 출발 마커이미지의 주소입니다
  startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다
  startOption = {
    offset: new kakao.maps.Point(15, 43), // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
  };

// 출발 마커 이미지를 생성합니다
var startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

var startDragSrc =
    "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_drag.png", // 출발 마커의 드래그 이미지 주소입니다
  startDragSize = new kakao.maps.Size(50, 64), // 출발 마커의 드래그 이미지 크기입니다
  startDragOption = {
    offset: new kakao.maps.Point(15, 54), // 출발 마커의 드래그 이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
  };

// 출발 마커의 드래그 이미지를 생성합니다
var startDragImage = new kakao.maps.MarkerImage(
  startDragSrc,
  startDragSize,
  startDragOption
);

// 출발 마커를 생성합니다
var startMarker = new kakao.maps.Marker({
  map: map, // 출발 마커가 지도 위에 표시되도록 설정합니다
  position: map.getCenter(),
  draggable: true, // 출발 마커가 드래그 가능하도록 설정합니다
  image: startImage, // 출발 마커이미지를 설정합니다
});
startMarker.setVisible(false);

// 출발 마커에 dragstart 이벤트를 등록합니다
kakao.maps.event.addListener(startMarker, "dragstart", function () {
  // 출발 마커의 드래그가 시작될 때 마커 이미지를 변경합니다
  startMarker.setImage(startDragImage);
});

// 출발 마커에 dragend 이벤트를 등록합니다
kakao.maps.event.addListener(startMarker, "dragend", function () {
  // 출발 마커의 드래그가 종료될 때 마커 이미지를 원래 이미지로 변경합니다
  startMarker.setImage(startImage);
});

var arriveSrc =
    "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png", // 도착 마커이미지 주소입니다
  arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다
  arriveOption = {
    offset: new kakao.maps.Point(15, 43), // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
  };

// 도착 마커 이미지를 생성합니다
var arriveImage = new kakao.maps.MarkerImage(
  arriveSrc,
  arriveSize,
  arriveOption
);

var arriveDragSrc =
    "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_drag.png", // 도착 마커의 드래그 이미지 주소입니다
  arriveDragSize = new kakao.maps.Size(50, 64), // 도착 마커의 드래그 이미지 크기입니다
  arriveDragOption = {
    offset: new kakao.maps.Point(15, 54), // 도착 마커의 드래그 이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
  };

// 도착 마커의 드래그 이미지를 생성합니다
var arriveDragImage = new kakao.maps.MarkerImage(
  arriveDragSrc,
  arriveDragSize,
  arriveDragOption
);

// 도착 마커를 생성합니다
var arriveMarker = new kakao.maps.Marker({
  map: map, // 도착 마커가 지도 위에 표시되도록 설정합니다
  position: map.getCenter(),
  draggable: true, // 도착 마커가 드래그 가능하도록 설정합니다
  image: arriveImage, // 도착 마커이미지를 설정합니다
});
arriveMarker.setVisible(false);

// 도착 마커에 dragstart 이벤트를 등록합니다
kakao.maps.event.addListener(arriveMarker, "dragstart", function () {
  // 도착 마커의 드래그가 시작될 때 마커 이미지를 변경합니다
  arriveMarker.setImage(arriveDragImage);
});

// 도착 마커에 dragend 이벤트를 등록합니다
kakao.maps.event.addListener(arriveMarker, "dragend", function () {
  // 도착 마커의 드래그가 종료될 때 마커 이미지를 원래 이미지로 변경합니다
  arriveMarker.setImage(arriveImage);
});

$(function () {
  $("#btn_start").click(function () {
    var startPosition = map.getCenter();
    startMarker.setVisible(true);
    startMarker.setPosition(startPosition);
  });

  $("#btn_arrive").click(function () {
    var arrivePosition = map.getCenter();
    arriveMarker.setVisible(true);
    arriveMarker.setPosition(arrivePosition);
  });

  $("#btn_rview").click(async function () {
    // $("div#roadview").css("display", "flex");
    let startPosition =
      startMarker.getPosition().getLng() +
      "," +
      startMarker.getPosition().getLat();
    let arrivePosition =
      arriveMarker.getPosition().getLng() +
      "," +
      arriveMarker.getPosition().getLat();

    const naverMapList = await $.ajax({
      url: "http://localhost:8080/nav/api/search",
      method: "POST",
      data: { sPos: startPosition, aPos: arrivePosition },
    });

    const paths = naverMapList.trafast[0].path;

    const roadviewClient = new kakao.maps.RoadviewClient();
    const container = document.getElementById("roadview");
    const roadview = new kakao.maps.Roadview(container);
    console.log(container);
    // console.log(paths);
    await paths.forEach((map) => {
      let position = new kakao.maps.LatLng(map[1], map[0]);
      roadviewClient.getNearestPanoId(position, 100, async (panoId) => {
        await roadview.setPanoId(panoId, position);
      });
    });
  });
});
