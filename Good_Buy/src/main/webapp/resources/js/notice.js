if (performance.navigation.type === 1) {
			location.href= "NoticeMain";
		}
	
$(".nt_subject").on("click", function(event){
	let parent = $(event.target).parent();
	let notice_id = $(parent).find(".nt_id").text();
	
	console.log(notice_id);
	
	location.href = "NoticeDetail?notice_idx=" + notice_id;
	//	파라미터로 페이지 넘버 추가?
	
});