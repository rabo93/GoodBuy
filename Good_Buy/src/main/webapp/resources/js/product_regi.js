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
	
	// 카테고리 불러오기
	if (window.location.href.includes("ProductRegist")) {
		$.ajax({
			url : "getCategory",
			type : "GET",
		}).done(function(data) {
			for(let item of data) {
				$("#product_category").append(
					`<option>${item.CODE_NAME}</option>`
				)
			}
		}).fail(function() {
			alert("카테고리 불러오기 실패\n나중에 다시 시도해주세요.");
		})
	}
	
	// 직거래 주소 입력박스
	$("#trade-enable, #trade-disable").change(function() {
	    if ($("#trade-enable").is(":checked")) {
	        $("#item-trade-adr-box").show();
	    } else {
	        $("#item-trade-adr-box").hide();
	        $("#item-trade-adr-sub").val("");
	    }
	});
	
	// 배송비 입력박스
	$("#shipping-fee-enable, #shipping-fee-disable").change(function() {
	    if ($("#shipping-fee-enable").is(":checked")) {
	        $("#shipping-fee-price").show();
	    } else {
	        $("#shipping-fee-price").hide();
	        $("#shipping-fee-price").val(0)
	    }
	});
	
	// 유효성 검사
	$("#productRegist").on("submit", function() {
		if ($("#item-thumb-upload-btn1").val() == "") {
			alert("썸네일을 등록해주세요!");
			$("#item-thumb-preview1").focus();
			return false;
		} else if ($("#item-regi-title-text").val() == "") {
			alert("제목을 입력해주세요!");
			$("#item-regi-title-text").focus();
			return false;
		} else if ($("#item-regi-description-text").val() == "") {
			alert("내용을 입력해주세요!");
			$("#item-regi-description-text").focus();
			return false;
		}  else if ($("#trade-enable").is(":checked") && $("#item-trade-adr-sub").val() == "") {
			alert("주소를 입력해주세요!");
			$("#item-trade-adr-sub").focus();
			return false;
		} else if ($("#shipping-fee-enable").is(":checked") && $("#shipping-fee-price").val() == "") {
			alert("배송비를 입력해주세요!");
			$("#shipping-fee-price").focus();
			return false;
		}  else if ($("#product_price").val() == "") {
			alert("가격을 입력해주세요!");
			$("#product_price").focus();
			return false;
		}
	})
})






