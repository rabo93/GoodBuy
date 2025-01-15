url = new URL(window.location.href);

// 헤더 스크립트
$(document).ready(function(){
	$("#login-btn").on("click", function(e){
		e.stopPropagation();
		$("#login-panel").toggleClass("on");
	});
	
	$("#login-panel").on("click", function(e){
		e.stopPropagation();
	});
	
	$(document).on("click", function() {
		$("#login-panel").removeClass("on");
	});
		
	$.ajax({
		url : "getCategory",
		type : "GET",
	}).done(function(data) {
		
		for(let item of data) {
			$("#hd-lnb").append(
				`<a href="ProductList?CODE_ID=${item.CODE_ID}">${item.CODE_NAME}</a>`
			)
			
			if (document.location.href.includes("ProductList")) {
				const codeId = url.searchParams.get('CODE_ID')
				if (codeId == item.CODE_ID) {
					$("#cateTitle").text(`${item.CODE_NAME}`)
				}
				if (url.searchParams.get('SEARCHKEYWORD')) {
					$('input[name=SEARCHKEYWORD]').val(url.searchParams.get('SEARCHKEYWORD'))
				}
			}
		}
	}).fail(function() {
		alert("카테고리 불러오기 실패\n나중에 다시 시도해주세요.");
	})
	
});

// 메인화면 무한 스크롤
if ($("#product-wrap2")) {
	var page = 1;
	$(window).scroll(function() {
	    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
	      
	      $.ajax({
			
			url: "MainProduct",
			type: "GET",
		
		}).done(function(data) {
			if(data.length != 0) {
				moment.locale('ko')
				$("#product-wrap2").empty();
				for(let item of data) {
					let addr = "";
					let category = `<span>${item.PRODUCT_CATEGORY}</span>`;
					let status = "";
					
					if (item.PRODUCT_TRADE_ADR1) {
						category += `<span class="type">직거래</span>`;
						addr = `<span class="add">${item.PRODUCT_TRADE_ADR1}</span>`;
					}
					
					if (item.PRODUCT_STATUS == 1) {
						status = `<div class="status" id="status">거래중</div>` 
					} else if (item.PRODUCT_STATUS == 2) {
						status = `<div class="status" id="status">예약중</div>` 
					}
					
					$("#product-wrap2").append(
					`<li class="product-card" id="product-card" onclick="location.href=\'ProductDetail?PRODUCT_ID=${item.PRODUCT_ID}'">
						${status}
						<div class="product-thumb">
							<img src="../resources/upload/${item.PRODUCT_PIC1}" class="card-thumb" alt="thumbnail"/>
						</div>
						<div class="card-info">
							<div class="category">
								${category}
							</div>
							<div class="ttl">${item.PRODUCT_TITLE}</div>
							<div class="price">
							 	${item.PRODUCT_PRICE.toLocaleString()} 원
							</div>
							<div class="card-row">
								${addr}
								<span class="name">${item.MEM_NICK}</span>
								<span class="time">${moment(item.PRODUCT_REG_DATE, "YYYYMMDDhhmmss").fromNow()}</span>
							</div>
						</div>
					</li>`)
				};
			} else {
				$("#product-wrap2").append(
					`<h1>:( 검색결과가 없습니다</h1>`
				)
			}
		}).fail(function() {
			alert("검색 실패\n나중에 다시 시도해주세요.");
		})
	      
	    }
	});
}
