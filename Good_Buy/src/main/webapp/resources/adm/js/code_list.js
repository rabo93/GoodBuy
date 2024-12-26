// Call the dataTables jQuery plugin
$(document).ready(function() {
	$('#codeList').DataTable({
		lengthChange : true, // 건수
		searching : true, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		ajax : {
			url: "AdmCommoncodeListForm",
			type: "POST",
			dataType : "JSON",
			dataSrc: function (data) {
				return data;
			},
		},
		columns: [
            { data : "CODETYPE_ID" },
            { data : "CODETYPE_NAME" },
            { data : "MAIN_DESC" },
            { data : "CODE_ID" },
            { data : "CODE_NAME" },
            { data : "SUB_DESC" },
            { data : "CODE_STATUS" },
            { data : "CODE_SEQ" },
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
            paginate: {
                first:    '처음',
                previous: '이전',
                next:     '다음',
                last:     '마지막'
            },
        },
		

	});
  
});
