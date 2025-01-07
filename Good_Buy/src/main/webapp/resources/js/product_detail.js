let url = new URL(window.location.href);

// product_detail.jsp
function toggleModal(action) {
    if (action === 'open') {
        $('.modal-wrap').show();
        $('.modal-bg').show();
    } else if (action === 'close') {
        $('.modal-wrap').hide();
        $('.modal-bg').hide();
    }
}

function removeWishlist() {
	$.ajax({
		url: "MyWishDel",
		type: "POST",
		data: {
			wishlist_id: $("input[name=wishlistCheck]").val()
		}
	}).done(function() {
		$("#removeWish").hide();
		$("#addWish").show();
		location.reload();
	}).fail(function() {
		alert("찜 삭제실패!\n나중에 다시 시도해주세요.");
		modalClose();
	});
}

function addWishlist() {
	$.ajax({
		url: "MyWishAdd",
		type: "GET",
		data: {
			MEM_ID: $("input[name=seller-id]").val(),
			PRODUCT_ID: url.searchParams.get('PRODUCT_ID'),
			PRODUCT_TITLE: $("#product-title").text()
		},
	}).done(function(){
		$("#removeWish").show();
		$("#addWish").hide();
		location.reload();
	}).fail(function() {
		alert("찜 등록실패!\n나중에 다시 시도해주세요.");
		modalClose();
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
			REPORTER_ID: $("input[name=seller-id]").val()
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