function getParams() {
	let params = "";
	let searchParams = new URLSearchParams(location.search);	
																
	for (let param of searchParams) {
		params += param[0] + "=" + param[1] + "&";
	}
	
	if (params.lastIndexOf("&" == params.length - 1)) {
		params = params.substring(0, params.length - 1);
	}
	
	return params;
}

function noticeDelete() {
	if (confirm("삭제하시겠습니까?")) {
		location.href = "NoticeDelete?" + getParams();
	}
}

function deleteFile(notice_id, file) {
	console.log(notice_id + "," + file);
	
	if(confirm("삭제하시겠습니까?")){
		
		$.ajax({
			type : "post",
			url : "AdmNoticeDeleteFile",
			data : {
				notice_id : notice_id,
				file : file,
			},
		}).done(function(result){
			if (result.trim() == "true") {
				let fileElem = $("input[name=file" + "]");
				$(fileElem).parent().html(fileElem);
				$(fileElem).prop("hidden", false)
			} else {
				alert("파일 삭제 실패!\n다시 시도해 주시기 바랍니다.");
			}
		}).fail(function(){
			alert("오류 발생!");
		});
		
	}
	
}