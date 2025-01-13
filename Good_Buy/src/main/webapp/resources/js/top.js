$(document).ready(function(){
	// header
	// hamburger menu (mobile menu)
	const hamburger = document.querySelector('.hamburger');
	const mobileMenu = document.querySelector('.m-menu-wrap');
	hamburger.addEventListener("click", function () {
	  hamburger.classList.toggle("is-active");
	  mobileMenu.classList.toggle("is-active");
	});
	
	$.ajax({
		url : "getCategory",
		type : "GET",
	}).done(function(data) {
		const codeId = url.searchParams.get('CODE_ID')
		
		for(let item of data) {
			$("#hd-lnb").append(
				`<a href="ProductList?CODE_ID=${item.CODE_ID}">${item.CODE_NAME}</a>`
			)
			
			if (document.location.href.includes("ProductList")) {
				if (codeId == item.CODE_ID) {
					$("#cateTitle").text(`${item.CODE_NAME}`)
				}
			}
		}
	}).fail(function() {
		alert("카테고리 불러오기 실패\n나중에 다시 시도해주세요.");
	})
	
	if (url.searchParams.get('SEARCHKEYWORD')) {
		$('input[name=SEARCHKEYWORD]').val(url.searchParams.get('SEARCHKEYWORD'))
	}
	
});
