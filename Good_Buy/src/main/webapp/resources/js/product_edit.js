$(function(){
		
	if ($("#item-trade-adr-sub").val()) {
	    $("#trade-enable").prop("checked", true);
	} else {
	    $("#trade-disable").prop("checked", true);
	    $("#item-trade-adr-box").hide();
	}
	
	if ($("#shipping-fee-price").val() != 0) {
	    $("#shipping-fee-enable").prop("checked", true);
	} else {
	    $("#shipping-fee-disable").prop("checked", true);
	    $("#shipping-fee-price").hide();
	}
	
	let byteTitle = $("#item-regi-title-text").val().length
	$("#item-regi-name-byte").text("(" + byteTitle + " / 100)");
	let byteDescription = $("#item-regi-description-text").val().length
	$("#item-regi-description-byte").text("(" + byteDescription + " / 2000)");
	
})

