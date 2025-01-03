$(".nt_subject").on("click", function(event){
	let parent = $(event.target).parent();
	let notice_id = $(parent).find(".nt_id").text();
	
	console.log(notice_id);
	
	location.href = "NoticeDetail?notice_id=" + notice_id;
	
});

//	========================================================================================================
//	무한스크롤
let pageNum = "2";
let lastScroll = 0;
let isContinue = true;
let searchType = $("#nt-searchType").val();
let searchKeyword = $("#nt-searchKeyword").val();
$(window).scroll(function(){
	let currentScroll = $(this).scrollTop();
	let documentHeight = $(document).height();
	let windowHeight = $(window).height();
	
	if(currentScroll > lastScroll) {
		if((currentScroll + windowHeight + 10) > documentHeight && isContinue) {
			load_list();
			isContinue = false;
		}
	}
	lastScroll = currentScroll

});
	
	
function load_list() {
	$.ajax({
		type : "GET",
		url : "NoticeListJson",
		data : {
			pageNum : pageNum,
			searchType : searchType,
			searchKeyword : searchKeyword
		},
		dataType : "json"
	}).done(function(data){
		for (let notice of data.noticeList) {
			let item = '<tr>'
				 		+ '<td class="nt_id" hidden>' + notice.notice_id + '</td>'
				 		+ '<td class="nt_subject">' + notice.notice_subject + '</td>'
				 		+ '<td>' + notice.mem_id + '</td>'
				 		+ '<td>' + notice.notice_date + '</td>'
			 		+ '</tr>';
			$(".nt-table").append(item);
		}
		
		if (pageNum < data.pageInfo.maxPage) {
			isContinue = true;
			pageNum++;
		}
		
	}).fail(function(){
		
	});
}

