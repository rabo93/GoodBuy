// product_regi.jsp
$(function(){
		
	if ($("#item-trade-adr-sub").val()) {
	    $("#trade-enable").prop("checked", true);
	} else {
	    $("#trade-disable").prop("checked", true);
	}
	
	if ($("#shipping-fee-price").val() != 0) {
	    $("#shipping-fee-enable").prop("checked", true);
	} else {
	    $("#shipping-fee-disable").prop("checked", true);
	    $("#shipping-fee-price").hide();
	}
	
})






