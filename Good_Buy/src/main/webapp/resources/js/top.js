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
		for(let item of data) {
			$("#hd-lnb").append(
				`<a href="ProductList?CODE_ID=${item.CODE_ID}">${item.CODE_NAME}</a>`
			)
		}
	}).fail(function() {
		
	})
	
	if (url.searchParams.get('SEARCHKEYWORD')) {
		$('input[name=SEARCHKEYWORD]').val(url.searchParams.get('SEARCHKEYWORD'))
	}
	
});
