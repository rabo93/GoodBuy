// ************* 변수 초기화 **************
let checkIdResult = false;
let checkName = false;
let checkNic = false;
let checkPasswd1 = false;
let checkPasswd2 = false;
let checkBirthday = false;
let checkBox = false;

//let checkAddr = false;
//let checkMail = true;
//let checkCode = false;
//let isIdValid=false;
//let phoneCheckResult = false;

$(document).ready(function() {
	//---------------------------------------------------------------------
	// [CoolSMS] 휴대폰 문자 인증 API
	// "인증번호 요청" 버튼 클릭 이벤트
    $("#phoneChk").click(function(){
        let userPhone = $("#mem_phone").val(); // 버튼 클릭 시 입력값 가져오기
        let regex = /^[0-9]{11}$/; // 휴대폰번호 유효성 검사 : 정확히 11자리 숫자만 허용
        
        if (!regex.test(userPhone)) {
			alert("휴대폰번호는 '-' 없이 11자리 숫자로 입력해주세요.");
			return;
		}
        

        $.ajax({
            type: "POST",
            url: "/send-one",
            data: { "userPhone" : userPhone },
            cache: false,
            success: function(data) {
//             	console.log("응답 데이터: " + JSON.stringify(data));
            	if(data == "error") {
            		alert("휴대폰번호가 올바르지 않습니다.");
            		$("#mem_phone").focus();
            		
            	} else { // 발송 성공시
		            alert('인증번호 발송이 완료되었습니다.');
            		$("#authSection").show(); // 인증번호 섹션 표시
            		$("#auth_code").attr("disabled", false); // 인증코드 입력창 활성화
            		$("#mem_phone").attr("readonly", true);	// 휴대폰번호 입력창 읽기전용으로 변경
                	
                	$("#authChkBtn").attr("disabled", false); // 인증하기 버튼 활성화
                    $(".after").attr("disabled", true); // 인증완료 버튼 비활성화
            	}
            },
            error: function (xhr) {
                if (xhr.status === 400) {
                    alert(xhr.responseText); // 서버에서 보낸 메시지를 alert로 표시
                } else {
                    alert("서버 요청 중 오류가 발생했습니다.");
                }
            }
        });
    });
    
	// "인증하기" 버튼 클릭 이벤트 > 성공시 "인증완료" 버튼으로 바뀜
	$("#authChkBtn").click(function () {
		let authCode = $("#auth_code").val(); // 입력된 인증번호
		let userPhone = $("#mem_phone").val(); // 휴대폰번호
		
		if (!authCode) {
            alert("인증번호를 입력해주세요.");
            return;
        }
		
		$.ajax({
            type: "POST",
            url: "/verify-code",
            data: { "authCode": authCode, "userPhone" : userPhone },
            success: function (response) {
                alert(response || "인증 성공!");
                // 인증번호 입력창 읽기전용으로 변경
            	$("#auth_code").attr("readonly", true).css("background-color", "#E8F0FE"); 
            	// 인증 성공 시 "인증하기" 버튼 숨기고, "인증완료" 버튼 보이게 하기
                $("#authChkBtn").hide(); // 인증하기 버튼 숨기기
                $("#rest_time").hide(); // 남은시간 숨기기
                $(".after").show(); // 인증완료 버튼 보이기
                $("#authCheckResult").hide();
                
                //인증번호 요청 숨기고, 인증번호 재요청 보이기 
                $("#phoneChk").hide(); // 인증번호 요청 버튼 숨기기
                $("#phoneReChk").show(); // 인증번호 재요청 버튼 보이기
                
                //----------------------------------------
                //아이디/비번 찾기할 때 인증 성공시 버튼 보이기
                $(".find").show();
                
            },
            error: function (xhr) {
            	// 서버 에러 메시지 처리
                let errorMessage = xhr.responseText || "인증 실패! 다시 시도해주세요.";
                alert(errorMessage);
                $("#authCheckResult").text("인증 실패").css("color", "red");
            }
        });
	});
	
	// "휴대폰번호 재인증" 버튼 클릭 이벤트
	$("#phoneReChk").click(function () {
	    location.reload(); // 페이지 새로고침
	});
	
	//---------------------------------------------------------------------
	// 이메일 도메인 셀렉트 박스 선택시 이벤트
	$("#emaildmain").change(function() {
		$("#mem_email2").val($("#emaildmain").val());
	});
	
	//---------------------------------------------------------------------
	// 비밀번호 / 비밀번호 재입력 키업시 이벤트
	$("#mem_passwd1, #mem_passwd2").keyup(function() {
		checkPasswdResult();
	});
	
	//---------------------------------------------------------------------
	// 생년월일 옵션
	for (let i = 2000; i > 1980; i--) {
		$('#year').append('<option value="' + i + '">' + i + '</option>');
	}
	for (let i = 1; i < 13; i++) {
		$('#month').append('<option value="' + i + '">' + i + '</option>');
	}
	for (let i = 1; i < 32; i++){
		$('#day').append('<option value ="' + i + '">' + i + '</option>');
	}
	
	//---------------------------------------------------------------------
	// "전체동의하기(terms_all)" 체크박스 클릭시 전체 항목 선택/해제 이벤트
	const checkAll = document.querySelector('#terms_all'); //id 속성 가져와서 변수에 저장
	
	if(checkAll) {
		const checkboxes = document.querySelectorAll('.terms'); //name 속성 전체 가져와서 변수에 저장
		// 1. 초기 동기화 : 페이지가 처음 로드될 때 'checkAll'의 상태에 따라 다른 체크박스들의 상태를 설정
		const isChecked = checkAll.checked; // checkAll이 체크되어 있는지 확인
		checkboxes.forEach(checkbox => checkbox.checked = isChecked);
		
		// 2. 전체선택 클릭시 이벤트
		checkAll.addEventListener('click', function() {
			let isChecked = checkAll.checked;
			checkboxes.forEach(checkbox => checkbox.checked = isChecked);
			
		});
		
		// 3. 개별 체크박스 클릭 시, 전체선택 상태 업데이트
		// 개별 체크박스 하나라도 체크 해제 시 전체선택 체크 해제 이벤트
		checkboxes.forEach(checkbox => {
			checkbox.addEventListener('click', function() {
				let totalCnt = checkboxes.length; //총 체크박스 갯수
				let checkedCnt = document.querySelectorAll('.terms:checked').length; //체크한 갯수
				
				// 모든 체크박스가 선택되었는지 확인 후 전체선택 상태 업데이트
				checkAll.checked = (totalCnt === checkedCnt);
			});
		});	
	
	}
});

//---------------------------------------------------------------------
// 아이디 중복체크/길이검사
function checkId(){
	let id = $("#mem_id").val();
	let regex = /^[\d\w][\d\w_]{3,12}$/;
	if(regex.exec(id)){
		$.ajax({
			type : "get",
			url : "MemberCheckId",
			data : { mem_id : id }, 
			success : function(result) {
				if(result.trim() == "false") {
					$("#checkIdResult").text("사용가능한 아이디 입니다.").css("color","var(--secondary)");
					checkIdResult = true;
				} else{
					$("#checkIdResult").text("이미 존재하는 아이디 입니다.").css("color","var(--red)");
					checkIdResult = false;
				}
			} 
		});
	} else {
		$("#checkIdResult").text("4~12글자만 사용가능");
		$("#checkIdResult").css("color", "var(--red)");
		checkIdResult = false;
	}
}
 		
//---------------------------------------------------------------------
// 이름 검사
function checkNameResult(){
	let name = $("#mem_name").val();
	let regex = /^[가-힣]{2,4}$/;
	
	if(regex.test(name)){
		$("#checkName").text("");
		checkName=true;
	}else {
		$("#checkName").text("올바른 이름을 입력해주세요.");	
		$("#checkName").css("color","var(--red)");	
		checkName=false;
	}
}

//---------------------------------------------------------------------
// 닉네임 중복검사
function ckNick(){
	let nick = $("#mem_nick").val();
	let regex = /^[\w가-힣]{2,8}$/;
	if(regex.exec(nick)){
		$.ajax({
			type : "get",
			url : "MemberCheckNick",
			data : {
				mem_nick : nick
			},
			success : function(result){
				if(result.trim() == "false" ){
					$("#checkNic").text("사용가능한 닉네임 입니다").css("color","var(--secondary)");
					checkNic = true;
				}else {
					$("#checkNic").text("이미 사용중인 닉네임 입니다").css("color","var(--red)");
					checkNic = false;
				}
			}
		});
	} else {
		$("#checkNic").text("2~8글자 사이 입력해주세요.");
		$("#checkNic").css("color", "var(--red)");
		checkNic = false;
	}
}

//---------------------------------------------------------------------
// 비밀번호 재입력 동일 검사
function checkPasswdResult(){
	let passwd1 = $("#mem_passwd1").val();
	let passwd2 = $("#mem_passwd2").val();
	
	if(passwd1 == "") {
		$("#checkPasswd2").text("비밀번호를 입력해주세요.");
		$("#checkPasswd2").css("color","var(--red)");
		checkPasswd1 = false;
	} else if(passwd1 != passwd2) {
		$("#checkPasswd2").text("비밀번호가 일치하지 않습니다.");
		$("#checkPasswd2").css("color","var(--red)");
		checkPasswd1 = false;
	} else {
		$("#checkPasswd2").text("비밀번호가 일치합니다.");
		$("#checkPasswd2").css("color","var(--secondary)");
		checkPasswd1 = true;
	}
}


//---------------------------------------------------------
// [ 회원 가입 버튼] 
function checkSubmit(){
    // 유효성 검사
//    if (!checkIdResult || !checkName || !checkNic || !checkPasswd1) {
//        alert("회원정보를 다시 확인해주세요");
//        console.log("유효성 검사 실패");
//        return false; // 폼 제출을 막음
//    }
	
	
    //--------------------------------------------
	// 생년월일 결합
    let year = $("#year").val();
    let month = $("#month").val();
    let day = $("#day").val();
	console.log(year + ", " + month + ", " + day);
	
	if (year === "YEAR" || month === "MONTH" || day === "DAY") {
//        alert("생년월일을 모두 선택해주세요.");
        checkBirthday = false; // 유효하지 않은 상태로 설정
//        return false; // 폼 제출 중단
    }
	
    // 생년월일 결합 (YYYY-MM-DD 형식)
    month = month.padStart(2, '0'); // 2자리로 변환
    day = day.padStart(2, '0'); // 2자리로 변환
    let birthday = `${year}-${month}-${day}`;
	console.log("생년월일:", birthday);
	
	// 생년월일 유효한 경우 상태 업데이트
    checkBirthday = true;
	console.log("checkBirthday: " + checkBirthday);
	
	// 숨겨진 입력 필드에 생년월일 설정
	$("#mem_birthday").val(birthday);
	
    //--------------------------------------------
    // ********** 유효성 검사 *********
    // 휴대폰 인증 확인
//    if ($("#auth_code").prop("readonly") !== true) {
//        alert("휴대폰 번호 인증을 완료해주세요.");
//        return false;
//    }
    if (!checkName) {
        alert("이름을 다시 확인해주세요.");
        return false;
    }
    if (!checkNic) {
        alert("닉네임을 다시 확인해주세요.");
        return false;
    }
    if (!checkIdResult) {
    	alert("아이디를 다시 확인해주세요.");
        return false;
    }
    if (!checkPasswd1) {
        alert("비밀번호를 다시 확인해주세요.");
        return false;
    }
   
    if (!checkBirthday) {
        alert("생년월일을 다시 확인해주세요.");
        return false;
    }
    if (!checkBox) {
        alert("모든 약관에 동의해주세요.");
        return false;
    }
    //--------------------------------------------
	// 폼 제출
	$("#joinForm").submit();
	
}

//==============================================================================
// >>>>>>>>>>>> MyInfo <<<<<<<<<<<<<<<<<<<
//==============================================================================
// [ 회원 수정 ]
// 프로필 사진
 $("#profile_img").change(function (event) {
    let file = event.target.files[0]; // 사용자가 업로드한 파일 가져오기
    let reader = new FileReader();

    reader.onload = function (event2) {
        console.log("파일 : " + event2.target.result); // 파일 내용 확인용 로그
        $("#preview_profile").attr("src", event2.target.result); // 미리보기 이미지 변경
    };

    // 파일을 URL로 읽어오기
    if (file) {
        reader.readAsDataURL(file);
    }
});


// [ 수정완료 버튼 ]
function myInfoModify(){
	// 기존 비밀번호 확인
    let oldPasswd = $("#old_passwd").val();
    
    if (!oldPasswd) {
        alert("기존 비밀번호를 입력해주세요.");
        console.log("기존 비밀번호 입력 누락");
        return false;
    }
	
    // 새 비밀번호와 확인 비밀번호의 유효성 검사
    let newPasswd1 = $("#mem_passwd1").val();
    let newPasswd2 = $("#mem_passwd2").val();
    if (!newPasswd1 || !newPasswd2) {
        alert("새 비밀번호를 입력하고 확인해주세요.");
        console.log("새 비밀번호 입력 누락");
        return false;
    }

    if (newPasswd1 !== newPasswd2) {
        alert("새 비밀번호가 일치하지 않습니다.");
        console.log("새 비밀번호 불일치");
        return false;
    }

    // 닉네임 중복 검사 결과 확인
//    if (!checkNic) {
//        alert("닉네임 중복 여부를 확인해주세요.");
//        console.log("닉네임 중복 확인 실패");
//        return false;
//    }

    // 비밀번호 검사 결과 확인
    if (!checkPasswd1) {
        alert("비밀번호가 유효하지 않습니다.");
        console.log("비밀번호 유효성 검사 실패");
        return false;
    }
	
    //--------------------------------------------
	// 폼제출
	$("#myInfo").submit();
};

