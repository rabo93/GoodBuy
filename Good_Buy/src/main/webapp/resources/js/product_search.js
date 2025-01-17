let url_href = window.location.href;
let url = new URL(url_href);
let category = url.searchParams.get('CODE_ID');
let price = url.searchParams.get('PRICE');
let tradeEnable = url.searchParams.get('STATUS');
let region = url.searchParams.get('REGION');
let pageNum = 1;

// 필터 초기화 버튼
function fliterReset() {
	window.location = 'ProductList';
}

function addAdr() {
	const region = url.searchParams.get('REGION');
	const regionValue = $("input[name='regionSearch']").val();
	switch (true) {
	    case regionValue == "":
	        url.searchParams.delete('REGION');
	        break;
	    case region == undefined:
	        url.searchParams.append('REGION', regionValue);
	        break;
	    default:
	        url.searchParams.set('REGION', regionValue);
	}
	window.location = url;
}

function addAdrEnter(e) {
    if (e.keyCode == 13) {
	
        const region = url.searchParams.get('REGION');
        const regionValue = $("input[name='regionSearch']").val();
        
        switch (true) {
            case regionValue == "":
                url.searchParams.delete('REGION');
                break;
            case region == undefined:
                url.searchParams.append('REGION', regionValue);
                break;
            default:
                url.searchParams.set('REGION', regionValue);
        }
        window.location = url;
    }
}

$(document).ready(function() {
	
	$("input[name='trade-box']").change(function() {
		if ($("input[name='trade-box']").is(':checked')) {
			tradeEnable = 0;	
			url.searchParams.append('STATUS', tradeEnable);
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
	    if ($("input[name='ip-num1']").val() == 0 && $("input[name='ip-num2']").val() == 0) {
	    	url.searchParams.delete('PRICE')
			window.location = url;
	    } else if (url.searchParams.get('PRICE') == undefined) {
	        window.location.search += "&PRICE=" + Number($("input[name='ip-num1']").val()) + "_" + Number($("input[name='ip-num2']").val());
	    } else {
	        url.searchParams.set('PRICE', Number($("input[name='ip-num1']").val()) + "_" + Number($("input[name='ip-num2']").val()));
	        window.location = url;
	    }
	});
	
	
	if (url.searchParams.get('PRICE') != undefined) {
		
		let splitPrice = url.searchParams.get('PRICE').split('_');
		$("input[name='ip-num1']").val(Number(splitPrice[0]));
		$("input[name='ip-num2']").val(Number(splitPrice[1]));
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
	
	searchProduct();
	
	$(window).scroll(function() {
	    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
			searchProduct()
		}
	})

function searchProduct() {
	  $.ajax({
	
		url: "SearchPriceFilter",
		type: "GET",
		data: {
			PRODUCT_STATUS: tradeEnable != undefined ? tradeEnable : undefined, 
			PRODUCT_PRICE: price != undefined ? price : undefined, 
			PRODUCT_TRADE_ADR1: region != undefined ? region : undefined, 
			SEARCHKEYWORD: url.searchParams.get('SEARCHKEYWORD') != undefined ? url.searchParams.get('SEARCHKEYWORD') : undefined, 
			PRODUCT_CATEGORY: category != undefined ? category : undefined,
			pageNum : pageNum
		}
	
		}).done(function(data) {
			if(data.length != 0) {
				moment.locale('ko')
//				$("#product-wrap").empty();
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
					
					$("#product-wrap").append(
						`<li class="product-card" id="product-card" onclick="location.href=\'ProductDetail?PRODUCT_ID=${item.PRODUCT_ID}'">
							<div class="product-thumb">
								${status}
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
				pageNum++;
			} else if (!$("#product-wrap2")) {
				$("#product-list").append(
					`<div class="no-data">
					<img class="no-data-pic" src="../resources/img/no-data-02.svg">
					<h1 class="no-data-text">:( 검색결과가 없습니다</h1>
					</div>`
				)
			}
			
		}).fail(function() {
			alert("검색 실패\n나중에 다시 시도해주세요.");
		})	
	}
})