$(document).ready(function(){
	const loginBtn = document.querySelector("#login-btn");
	const panel = document.querySelector("#login-panel");
	loginBtn.addEventListener("click", function(event){
		event.stopPropagation();
		panel.classList.toggle("on");
	});
	
	panel.addEventListener("click", function(event) {
		event.stopPropagation();
	});
	
	document.addEventListener("click", function(event) {
		panel.classList.remove("on");
	});
});