<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.item-trade-adr-search {
    padding: 8px 15px 8px 15px;
    min-width: 100px;
    height: 40px;
    box-sizing: border-box;
    border-radius: 50px;
    font-size: 15px;
    font-weight: 700;
    background-color: #0dcc5a;
    border: 2px solid #0dcc5a;
    color: #ffffff;
    cursor: pointer;
}
</style>
<script type="text/javascript">
let url_href = window.location.href;
let url = new URL(url_href);
let category = url.searchParams.get('PRODUCT_CATEGORY');
let price = url.searchParams.get('PRICE');
let tradeEnable = url.searchParams.get('STATUS');
let region = url.searchParams.get('REGION');

// 필터 초기화 버튼
function fliterReset() {
	window.location.search = "&PRODUCT_CATEGORY=" + category;
}

$("input[name='trade-box']").change(function() {
	if ($("input[name='trade-box']").is(':checked')) {
		tradeEnable = 0;	
		url += "&STATUS=" + tradeEnable;
		window.location = url;
	} else {
		tradeEnable = 1;
		url.searchParams.delete('STATUS')
		window.location = url;
	}
})


$("input[name='ip-chk']").change(function() {
	$("input[name='ip-num2']").val($("input[name='ip-chk']:checked").val());
	if (url.searchParams.get('PRICE') == undefined) {
		window.location.search += "&PRICE=" + $("input[name='ip-num1']").val() + "_" + $("input[name='ip-num2']").val();
	} else {
		url.searchParams.set('PRICE', $("input[name='ip-num1']").val() + "_" + $("input[name='ip-num2']").val());
		window.location = url;
	}
})

$("input[name='ip-num1'], input[name='ip-num2']").change(function() {
	if (url.searchParams.get('PRICE') == undefined) {
		window.location.search += "&PRICE=" + $("input[name='ip-num1']").val() + "_" + $("input[name='ip-num2']").val();
	} else {
		url.searchParams.set('PRICE', $("input[name='ip-num1']").val() + "_" + $("input[name='ip-num2']").val());
		window.location = url;
	}
})

function addAdr() {
	if (url.searchParams.get('REGION') == undefined) {
		window.location.search += "&REGION=" + $("input[name='regionSearch']").val();
	} else {
		url.searchParams.set('REGION', $("input[name='regionSearch']").val());
		window.location = url;
	}
}

$(document).ready(function() {
	
	if (url.searchParams.get('PRICE') != undefined) {
		let splitPrice = url.searchParams.get('PRICE').split('_');
		$("input[name='ip-num1']").val(splitPrice[0]);
		$("input[name='ip-num2']").val(splitPrice[1]);
		switch (splitPrice[1]) {
			case '5000': $(".rd1").prop("checked", true); break;
			case '10000': $(".rd2").prop("checked", true); break;
			case '20000': $(".rd3").prop("checked", true); break;
		}
	}
	
	if (url.searchParams.get('STATUS') != undefined) {
		$("input[name='trade-box']").prop("checked", true)
	}
	
	if (url.searchParams.get('REGION') != undefined) {
		$("input[name='regionSearch']").val(url.searchParams.get('REGION'))
	}
	
	$.ajax({
		
		url: "SearchPriceFilter",
		type: "GET",
		data: {
			PRODUCT_STATUS: url.searchParams.get('STATUS') != undefined ? tradeEnable : undefined, 
			PRODUCT_PRICE: url.searchParams.get('PRICE') != undefined ? price : undefined, 
			PRODUCT_TRADE_ADR1: url.searchParams.get('REGION') != undefined ? region : undefined, 
			PRODUCT_CATEGORY: category
		}
	
	}).done(function(data) {
		$("#product-wrap").empty();
		for(let item of data) {
			$("#product-wrap").append(
				`<li class="product-card" onclick="location.href=\'ProductDetail?PRODUCT_ID=\${item.PRODUCT_ID}\'">` +
					`<img src="${pageContext.request.contextPath}/resources/upload/'${item.PRODUCT_PIC1}'" class="card-thumb" alt="thumbnail"/>` +
					`<div class="card-info">` +
						`<div class="category">` +
							`<span>\${item.PRODUCT_CATEGORY}</span>` +
							`<c:if test="${item.product_trade_adr1 != ''}">` +
								`<span class="type">직거래</span>`+
							`</c:if>`+
						`</div>`+
						`<div class="ttl">\${item.PRODUCT_TITLE}</div>`+
						`<div class="price">`+
						 	`\${item.PRODUCT_PRICE} 원`+
						`</div>`+
						`<div class="card-row">`+
							`<span class="add">\${item.PRODUCT_TRADE_ADR1}</span>`+
							`<span class="name">\${item.MEM_NICK}</span>`+
							`<span class="time">1분 전</span>`+
						`</div>`+
					`</div>`+
				`</li>`)};
	}).fail(function() {
		alert("응 안돼");
	})	
	
})

</script>