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
		autoWidth: false,
		ajax : {
			url: "AdmMemberListForm",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.mem_status = $('input[name="mem_status"]:checked').val();
                d.mem_grade = $('input[name="mem_grade"]:checked').val();
                d.search_keyword = $('input[name="keyword_search"]').val();
            },
			dataSrc: function (res) {
				const data = res.memberList;
				const start = $('#memberList').DataTable().page.info().start; 
				
				// 회원번호(PK)가 아닌 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		order: [[8, 'desc']], // 최초 조회 시 가입일자 최신순으로 기본 설정
		columnDefs: [
			 { targets: [0, 5, 6, 7, 9, 10, 11], orderable: false },
		],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 회원가입 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex", className : "dt-center", width: '30px', },
            { 
				title: "아이디", 
	            data : "mem_id", 
	            defaultContent: "",
	            width: '100px',
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
            },
            { title: "이름", data : "mem_name", defaultContent: "", width: '80px',},
            { title: "닉네임", data : "mem_nick", defaultContent: "", width: '90px',},
            { title: "이메일", data : "mem_email", defaultContent: "", width: '130px', },
            { title: "휴대폰", data : "mem_phone", defaultContent: "", width: '130px', },
            { 
				title: "등급", 
				data : "mem_grade", 
				defaultContent: "일반", 
				className : "dt-center", 
				width: '70px',
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
				className : "dt-center",
				width: '70px',
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
            { title: "가입일자", data : "mem_reg_date", className : "dt-center", defaultContent: "", width: '100px', },
            { 
				title: "SNS연동", 
				data : "sns_status", 
				defaultContent: "-", 
				className : "dt-center",
				width: '80px',
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
				className : "dt-center",
				width: '80px',
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
				searchable: false,
				className : "dt-center",
				width: '180px',
				render : function(data, type, row) {
					return `
						<button class="btn btn-primary edit-btn" data-toggle="modal" data-target="#updateMemberInfo" data-mem-id=${data.mem_id}'">변경</button>
						<button class="btn btn-success edit-btn" onclick="location.href='AdmMemberDetailForm?mem_id=${data.mem_id}'">보기</button>
						<button class="btn btn-danger delete-btn" data-mem-id="${data.mem_id}">삭제</button>
					`;
				}
			}
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
			emptyTable: "데이터가 없습니다.",
			lengthMenu: "_MENU_ 건씩 보기",
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
	
	// 기존 검색 숨기기
	$("#memberList_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="mem_status"], input[name="mem_grade"]').on('change', function() {
        memberList.draw();
    });

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', function() {
        memberList.draw();
    });

    // 엔터키 입력으로 검색
    $('#searchBtn').on('keypress', function(e) {
        if (e.which == 13) {
            memberList.draw();
        }
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
		const memId2 = document.querySelector("#memId2");
		memId.value = rowData.mem_id;
		memId2.value = rowData.mem_id;
		
		// 선택 상태 설정
	    if (memGradeSelect) memGradeSelect.selected = true;
	    if (memStatusSelect) memStatusSelect.selected = true;
	});
	
	// 선택한 컬럼 삭제
	$(document).on("click", '.delete-btn', function() {
		if(confirm("해당 회원을 삭제하시겠습니까?\n삭제 후 복구가 불가능합니다.")) {
			const memId = this.dataset.memId;
			console.log("삭제할 회원 아이디 : " + memId);
			
			$.ajax({
				url : "AdmMemberDelete",
				type : "POST",
				data : {
					"mem_id" : memId,
				},
				success: function(response){
					if(response.status == 'success') {
						alert(response.message);
						window.location.href = response.redirectURL;
					} else {
						alert(response.message);
					}
				},
				error : function(res) {
					alert(res.message);
				}
			});
		}
	});
	
});

// 휴대폰 형식 가공 => DB에서 처리함..
//function formatPhone(phone) {
//    return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
//}
