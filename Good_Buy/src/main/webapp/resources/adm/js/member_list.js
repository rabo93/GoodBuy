// Call the dataTables jQuery plugin
document.addEventListener("DOMContentLoaded", function(){
	const modifyForm = document.querySelector("#modifyForm");
	const memberList = $('#memberList').DataTable({
		lengthChange : true, // 건수
		searching : true, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		destroy: true,
		scrollX: true, 
		ajax : {
			url: "AdmMemberListForm",
			type: "POST",
			dataType : "JSON",
			dataSrc: function (res) {
				const data = res;
				// 회원번호(PK)가 아닌 테이블 컬럼 번호 계산
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = i + 1;
//					console.log(data[i]);
				}
				return res;
			},
		},
		columnDefs: [
      	],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 회원가입 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex", className : "dt-center" },
            { 
				title: "ID", 
	            data : "mem_id", 
	            defaultContent: "",
	            width: '80px',
	            render: 
	            	function (data, type, row) {
						if (!data) {
							return "";
						}
                    	return data.replace(/(.{15})/g, '$1<br>'); // 15자마다 줄바꿈
               		}
            },
            { title: "이름", data : "mem_name", defaultContent: "",  orderable: false },
            { title: "닉네임", data : "mem_nick", defaultContent: "", orderable: false, },
            { title: "이메일", data : "mem_email", defaultContent: "", orderable: false, width: '120px',},
            { title: "휴대폰", data : "mem_phone", defaultContent: "", orderable: false, },
            { 
				title: "등급", 
				data : "mem_grade", 
				defaultContent: "일반", 
				orderable: false,
				className : "dt-center", 
				render : function(data, type, row) {
					if(!data) {
						return "";
					} else if(data == "관리자"){
						return "<span class='grade grade-adm'>관리자</span>"
					} else if(data == "일반"){
						return "<span class='grade grade-normal'>일반</span>"
					}
				}
             },
            { 
				title: "상태", 
				data : "mem_status", 
				defaultContent: "정상", 
				orderable: false,
				className : "dt-center",
				width: '80px',
				render : function(data, type, row) {
					if(!data){
						return "<span class='status status-01'>정상</span>";
					}
					switch(data) {
						case 1: return "<span class='status status-01'>정상</span>";
						case 2: return "<span class='status status-02'>정지</span>";
						case 3: return "<span class='status status-03'>탈퇴</span>";
					}
				}
            
            },
            { title: "가입일자", data : "mem_reg_date", className : "dt-center", defaultContent: "", orderable: false, },
            { 
				title: "SNS연동", 
				data : "sns_status", 
				defaultContent: "-", 
				orderable: false,
				className : "dt-center", 
				render : function(data, type, row) {
					if(!data){
						return "-";
					}
					switch(data) {
						case 1: return "연동완료";
						case 2: return "-";
					}
				}
            
            },
            { 
				title: "회원인증", 
				data : "auth_status",
				defaultContent: "-", 
				orderable: false,
				className : "dt-center",
            	render : function(data, type, row) {
					if(!data){
						return "-";
					}
					switch(data) {
						case 1: return "인증완료";
						case 2: return "-";
					}
				}
            },
            {
				title : "관리",
				data: null,
				orderable : false,
				searchable: false,
				className : "dt-center",
				render : function(data, type, row) {
//					console.log(data.mem_id);
					return `
						<button class="btn btn-primary edit-btn" data-toggle="modal" data-target="#updateMemberInfo" data-mem-id=${data.mem_id}'">수정</button>
						<button class="btn btn-primary delete-btn" data-mem-id="${data.mem_id}">삭제</button>
					`;
				}
			}
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
			emptyTable: "데이터가 없습니다.",
			lengthMenu: "_MENU_",
			info: "현재 _START_ - _END_ / 총 _TOTAL_건",
			infoEmpty: "데이터 없음",
			search: "검색",
			infoFiltered: "( _MAX_건의 데이터에서 필터링됨 )",
			loadingRecords: "로딩중...",
			processing: "잠시만 기다려 주세요...",
			zeroRecords: "일치하는 데이터가 없습니다.",
            paginate: {
                first:    '처음',
                previous: '이전',
                next:     '다음',
                last:     '마지막'
            },
        },
	});
	
	// 공통코드 테이블 컬럼 수정 팝업 셋팅
	memberList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = memberList.row(row).data();

		const memGrade = rowData.mem_grade;
		const memStatus = rowData.mem_status;
		const memGradeSelect = document.querySelector(`#memGrade option[value="${memGrade}"]`);;
		const memStatusSelect = document.querySelector(`#memStatus option[value="${memStatus}"]`);;
		
		const memId = document.querySelector("#memId");
		memId.value = rowData.mem_id;
		
		// 선택 상태 설정
	    if (memGradeSelect) memGradeSelect.selected = true;
	    if (memStatusSelect) memStatusSelect.selected = true;
	});
	
});

// 휴대폰 형식 가공
//function formatPhone(phone) {
//    return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
//}
