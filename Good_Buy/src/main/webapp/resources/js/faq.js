$(document).ready(function(){
	showFAQ("policy");
	$('.answer').hide();
});

function showFAQ(category) {
	const faqLists = document.querySelectorAll('.faq-list');
	const selectedFAQ = document.getElementById(category);
	faqLists.forEach(function(list){
		list.style.display = 'none';
	});
	
	selectedFAQ.style.display = 'block';
}

function toggleAnswer(button) {
	var answer = $(button).next(".answer");
	answer.toggle();
}









