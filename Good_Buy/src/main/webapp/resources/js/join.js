// ************* 변수 초기화 **************
let checkName = false;
let checkNic = false;
let checkIdResult = false;
let checkPasswd1 = false;
let checkPasswd2 = false;
let checkEmail = false;
let checkBirthday = false;


let oldPasswd = false;

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
                // 인증 상태를 1로 변경
    			$("#auth_status").val(1);
                
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
		// 이메일 중복 체크 함수 호출
    	checkEmailDuplicate();
	});
	// 이메일1과 이메일2가 변경될 때마다 중복 체크
	$("#mem_email1, #mem_email2").on("keyup change", function() {
	    checkEmailDuplicate();
	});
	
	
	//---------------------------------------------------------------------
	// 비밀번호 / 비밀번호 재입력 키업시 이벤트
	$("#mem_passwd1, #mem_passwd2").keyup(function() {
		checkPasswdResult();
	});
	
	//---------------------------------------------------------------------
	// 생년월일 옵션 선택
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
				isChecked = (totalCnt === checkedCnt); // isChecked 업데이트
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
	} else {
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
			type : "Get",
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


//---------------------------------------------------------------------
// 이메일 중복 체크 함수
function checkEmailDuplicate() {
	let email1 = $("#mem_email1").val();
	let email2 = $("#mem_email2").val();
	let email = email1 + "@" + email2;
	
    // 이메일이 완전히 입력되지 않으면 중복 체크를 하지 않음
    if (email1 && email2) {
        // AJAX로 이메일 중복 체크
        $.ajax({
            url: 'MemberCheckEmail',
            type: 'POST',
            data: { mem_email: email },
            success: function(result) {
                if(result.trim() === "false") {
                    // 중복되지 않는 이메일
                    $("#checkMail").text("사용 가능한 이메일입니다.").css("color", "var(--secondary)");
                    $("#mem_email").val(email); // 이메일 hidden 필드에 값 설정
                    checkEmail = true;
                } else {
                    // 중복된 이메일
                    $("#checkMail").text("이미 가입된 이메일입니다.").css("color", "var(--red)");
                    checkEmail = false;
                }
            }
        });
    } else {
        $("#checkMail").text(""); // 이메일 입력이 완료되지 않으면 결과를 지운다.
        checkEmail = false;
    }
}


//=================================================================================================
// [ 회원 가입 버튼] 
function checkSubmit(){
	event.preventDefault(); // 조건 만족 전에 폼 제출 되는 것을 막음
	
	//--------------------------------------------
    // ********** 필수 기입 항목 확인 *********
	// 휴대폰 본인확인
    let authStatus = $("#auth_status").val();
	if (authStatus !== "1") {
       alert("휴대폰 인증을 완료해주세요.");
       return false; // 가입 중단
    }
	//--------------------------------------------
    // 이름
    if (!checkName) {
        alert("이름을 다시 확인해주세요.");
        return false;
    }
	//--------------------------------------------
    // 닉네임
    if (!checkNic) {
        alert("닉네임을 다시 확인해주세요.");
        return false;
    }
	//--------------------------------------------
	// 아이디
    if (!checkIdResult) {
    	alert("아이디를 다시 확인해주세요.");
        return false;
    }
	//--------------------------------------------
    // 비밀번호
    if (!checkPasswd1) {
        alert("비밀번호를 다시 확인해주세요.");
        return false;
    }
	//--------------------------------------------
	// 이메일
    if (!checkEmail) {
        alert("이메일을 다시 확인해주세요.");
        return false;
    }
	//--------------------------------------------
	// 생년월일
    let year = $("#year").val();
    let month = $("#month").val();
    let day = $("#day").val();
	
	if (year === "YEAR" || month === "MONTH" || day === "DAY") {
        alert("생년월일을 모두 선택해주세요.");
        return false;
    }
    
    // 생년월일 결합 (YYYY-MM-DD 형식)
    month = month.padStart(2, '0'); // 2자리로 변환
    day = day.padStart(2, '0'); // 2자리로 변환
    let birthday = `${year}-${month}-${day}`;
	
	// 생년월일 유효한 경우 상태 업데이트
    checkBirthday = true;
	
	// 숨겨진 입력 필드에 생년월일 설정
	$("#mem_birthday").val(birthday);
   
    //--------------------------------------------
    // 모든 약관 동의 여부 확인
    const checkAll = $("#terms_all").is(":checked");
    if (!checkAll) {
        alert("모든 약관에 동의해야 가입이 가능합니다.");
        return false;
    }
    //--------------------------------------------
	// 최종 폼 제출!!
	$("#joinForm").submit();
}

// 폼의 submit 이벤트 리스너에 checkSubmit 함수 등록
$("#joinForm").on("submit", checkSubmit);

//=================================================================================================
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> MyInfo 마이페이지 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//=================================================================================================
// [ 회원 수정 ]
// 프로필 사진
// 파일 선택 시 미리보기 기능
function previewImage(event) {
	const input = event.target;
//	let file = event.target.files[0]; // 사용자가 업로드한 파일 가져오기
	const reader = new FileReader();
	
	reader.onload = function(e) {
		const preview = document.getElementById('profile_preview');
		preview.src = reader.result; // 선택한 이미지로 업데이트
//		document.getElementById('profile_preview').src = e.target.result;
     };
     
     if (input.files && input.files[0]) {
        reader.readAsDataURL(input.files[0]); // 파일 읽기
    }
//     reader.readAsDataURL(file);
}












//-----------------------------------------------------------------------
// [ 수정완료 버튼 ]
function myInfoModify(){
	event.preventDefault(); // 조건 만족 전에 폼 제출 되는 것을 막음
	
	// 기존 비밀번호 확인
    let oldPasswd = $("#old_passwd").val();
    
    if (!oldPasswd) {
        alert("기존 비밀번호를 입력해주세요.");
        return false;
    }
	
    // 새 비밀번호와 확인 비밀번호의 유효성 검사
    let newPasswd1 = $("#mem_passwd1").val();
    let newPasswd2 = $("#mem_passwd2").val();
    if (!newPasswd1 || !newPasswd2) {
        alert("새 비밀번호를 입력하고 확인해주세요.");
        return false;
    }

    if (newPasswd1 !== newPasswd2) {
        alert("새 비밀번호가 일치하지 않습니다.");
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
//        console.log("비밀번호 유효성 검사 실패");
        return false;
    }
	
    //--------------------------------------------
	// 수정 폼 제출
	$("#myInfo").submit();
};

// 폼의 submit 이벤트 리스너에 checkSubmit 함수 등록
$("#myInfo").on("submit", checkSubmit);
