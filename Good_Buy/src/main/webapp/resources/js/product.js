let url = new URL(window.location.href);
let sId = $("input[name=viewer-id]").val();

// product_regi.jsp
function onClickUpload1() {
	let myInput = document.getElementById("item-thumb-upload-btn1");
	myInput.click();
}
function onClickUpload2() {
	let myInput = document.getElementById("item-thumb-upload-btn2");
	myInput.click();
}
function onClickUpload3() {
	let myInput = document.getElementById("item-thumb-upload-btn3");
	myInput.click();
}

// product_detail.jsp
function modalOpen() {
	$('.modal-wrap').show();
	$('.modal-bg').show();
}

function modalClose() {
	$('.modal-wrap').hide();
	$('.modal-bg').hide();
}

function addWishlist() {
	$.ajax({
		url: "AddWishlist",
		type: "GET",
		data: {
			MEM_ID: sId,
			PRODUCT_ID: url.searchParams.get('PRODUCT_ID')
		},
	}).done(function() {
		
	}).fail(function() {
		alert("찜하기 실패\n나중에 다시 시도해주세요.");
	});
}

function itemReporting() {
	$.ajax({
		url: "ItemReporting",
		type: "GET",
		data: {
			PRODUCT_ID: url.searchParams.get('PRODUCT_ID'),
			REASON: $("select[name=modal-sb] option:selected").text() === "기타" ? $(".modal-otherReason").val() :
																				   $("select[name=modal-sb] option:selected").text(),
			REPORTER_ID: sId
		},
	}).done(function(response){
		alert(decodeURIComponent(response).replaceAll("+", " "));
		modalClose();
	}).fail(function() {
		alert(decodeURIComponent(response).replaceAll("+", " "));
		modalClose();
	});
}

$(document).ready(function(){
	$(".modal-otherReason").text($("select[name=modal-sb] option:selected").val());
	$("select[name=modal-sb]").change(function(){
		if ($("select[name=modal-sb] option:selected").text() === "기타") {
			$(".modal-otherReason").removeAttr("readonly");
			$(".modal-otherReason").val("");
			$(".modal-otherReason").attr("placeholder", "기타 사유를 입력해주세요.");
		} else {
			$(".modal-otherReason").attr("readonly", "readonly");
			$(".modal-otherReason").val($("select[name=modal-sb] option:selected").val());
		}
	});
})



// ==============================================================================
// ==============================================================================
// 결제창 열기 - 창을 작게 열려고 함수로 만들었음
function openPayWindow(product_id, receiver_id) {
	var url = "PayTransferRequest?product_id=" + encodeURIComponent(product_id) +
              "&receiver_id=" + encodeURIComponent(receiver_id) ;
    payWindow = window.open(url, "chat_window", "width=500,height=500");
}
