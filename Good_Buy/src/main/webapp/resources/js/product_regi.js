// product_regi.jsp
$(function(){
	
	// 썸네일 등록
	$('.item-thumb-upload').on('click', onClickUpload);
	function onClickUpload(){
		let id = this.children[0].id;
		let length = id.length;
		let idx = id.substr(length - 1);
		let myInput = document.getElementById("item-thumb-upload-btn" + idx);
		myInput.click();
		
		$("#item-thumb-upload-btn" + idx).on("change", function(event) {
		    let file = event.target.files[0];
		    let reader = new FileReader(); 
		    reader.onload = function(e) {
		        $("#item-thumb-preview" + idx).attr("src", e.target.result);
		    }
		    reader.readAsDataURL(file);
		});
	}
	
	// 글자수 체크
	if ($("#item-regi-title-text").focus()) {
		updateByteCount("#item-regi-title-text", "#item-regi-name-byte", 100, "최대 100자까지 입력 가능합니다.");
	}
	
	if ($("#item-regi-description-text").focus()) {
		updateByteCount("#item-regi-description-text", "#item-regi-description-byte", 2000, "최대 2000자까지 입력 가능합니다.");
	}
	
	function updateByteCount(selector, byteSelector, maxLength, alertMessage) {
		$(selector).on('keydown change', function() {
			var content = $(this).val();
			$(byteSelector).text("(" + content.length + " / " + maxLength + ")");
				if (content.length > maxLength) {
					alert(alertMessage);
					$(this).val(content.substring(0, maxLength));
					$(byteSelector).text("(" + maxLength + " / " + maxLength + ")");
				}
		});
	}
	
	// 직거래 주소 입력박스
	$("#trade-enable, #trade-disable").change(function() {
	    if ($("#trade-enable").is(":checked")) {
	        $("#item-trade-adr-box").show();
	    } else {
	        $("#item-trade-adr-box").hide();
	    }
	});
	
	// 배송비 입력박스
	$("#shipping-fee-enable, #shipping-fee-disable").change(function() {
	    if ($("#shipping-fee-enable").is(":checked")) {
	        $("#shipping-fee-price").show();
	    } else {
	        $("#shipping-fee-price").hide();
	    }
	});
	
})






