// ************* 변수 초기화 **************
let checkName = false;
let checkPasswd1 = true;
let checkPasswd2 = true;
let checkNumber = false;
let checkAddr = false;
let checkMail = true;
//let checkCode = false;
let checkIdResult = false;
let checkNic = false;
let isIdValid=false;
//let phoneCheckResult = false;


//**************** 생년월일 ****************
$(document).ready(function() {
		for (let i = 2000; i > 1980; i--) {
			$('#year').append('<option value="' + i + '">' + i + '</option>');
		}
		for (let i = 1; i < 13; i++) {
			$('#month').append('<option value="' + i + '">' + i + '</option>');
		}
		for (let i = 1; i < 32; i++){
			$('#day').append('<option value ="' + i + '">' + i + '</option>');
		}
});

// ********* 이메일 셀랙트박스 **********
$(document).ready(function() {
//	$("#submit").click(submit);
	$("#emaildmain").change(function() {
		$("#mem_email2").val($("#emaildmain").val());
	});
});

// ************* 이름 검사 **************
function checkNameResult(){
	let name = $("#mem_name").val();
	let regex = /^[가-힣]{2,4}$/;
	
	if(regex.test(name)){
		$("#checkName").text("");
		checkName=true;
	}else {
		$("#checkName").text("올바른 이름을 입력해주세요.");	
		$("#checkName").css("color","red");	
		checkName=false;
	}
}
	
// ************* 아이디 중복체크/길이검사 **************
function checkId(){
	let id = $("#mem_id").val();
	let regex = /^[\d\w][\d\w_]{3,12}$/;
	if(regex.exec(id)){
		$.ajax({
			type : "get" ,
		   	 url : "MemberCheckId" ,
		   	data : {
			mem_id:id
		} ,
			success : function(result){
				if(result.trim() == "false"){
					$("#checkIdResult").text("사용가능한 아이디 입니다.").css("color","GREEN");
					checkIdResult = true;
				}else{
					$("#checkIdResult").text("이미 존재하는 아이디 입니다.").css("color","RED");
//					alert("아이디를 다시 확인해주세요");
					checkIdResult = false;
				}
			} 
		});
	} else {
		$("#checkIdResult").text("4~12글자만 사용가능");
		$("#checkIdResult").css("color", "red");
		checkIdResult = false;
	}
}
 		
/* ************* 닉네임 중복검사 ************* */
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
//						alert("닉네임을 다시 확인해주세요");
						checkNic = false;
					}
				}
		});
	} else {
		$("#checkNic").text("2~8글자만 사용가능");
		$("#checkNic").css("color", "red");
		checkNic = false;
	}
}


// ************* 비밀번호 재입력 동일 검사**************
function checkPasswdResult(){
	let passwd1 = $("#mem_passwd1").val();
	let passwd2 = $("#mem_passwd2").val();
	if(passwd1 == ""){
		$("#checkPasswd2").text("비밀번호를 입력해주세요.");
		$("#checkPasswd2").css("color","var(--red)");
	}else if(passwd1 == passwd2){
		$("#checkPasswd2").text("비밀번호가 일치합니다.");
		$("#checkPasswd2").css("color","var(--secondary)");
	}else {
		$("#checkPasswd2").text("비밀번호가 일치하지 않습니다.");
		$("#checkPasswd2").css("color","var(--red)");
	}
}


// "전체동의하기(terms_all)" 버튼 클릭시 전체 항목 선택/해제 이벤트
$(document).ready(function() {
	const checkAll = document.querySelector('#terms_all'); //id 속성 가져와서 변수에 저장
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
});





/* 회원가입 버튼 */
function checkSubmit(){
    // 유효성 검사
    if (!checkIdResult || !checkNic || !checkPasswd1) {
        alert("회원정보를 다시 확인해주세요");
        console.log("유효성 검사 실패");
        return false;
    }
	
	// 생년월일 결합
    let year = $("#year").val();
    let month = $("#month").val();
    let day = $("#day").val();
	console.log(year + ", " + month + ", " + day);
	
	if (year === "YEAR" || month === "MONTH" || day === "DAY") {
        alert("생년월일을 모두 선택해주세요.");
        return false; // 폼 제출을 막음
    }
	
    // 생년월일 결합 (YYYY-MM-DD 형식)
    month = month.padStart(2, '0'); // 2자리로 변환
    day = day.padStart(2, '0'); // 2자리로 변환
    let birthday = `${year}-${month}-${day}`;
	console.log("생년월일:", birthday);
	
	// 숨겨진 입력 필드에 생년월일 설정
	$("#mem_birthday").val(birthday);
	
	// 폼 제출
    $("#joinForm").submit();
};

//==============================================================================
// [ 회원 수정 ]
// 프로필 사진
$("#profile_img").change(function (event) {
    let file = event.target.files[0];
    let reader = new FileReader();

    reader.onload = function (event2) {
        console.log("파일: " + event2.target.result);
        $("#preview_profile").attr("src", event2.target.result);
    };

    if (file) {
        reader.readAsDataURL(file);
    }
});

// 수정완료 버튼
function myInfoModify(){
    if (!checkIdResult || !checkNic || !checkPasswd1) {
        alert("회원정보를 다시 확인해주세요");
        console.log("유효성 검사 실패");
        return false;
    } else {
        $("#myInfo").submit();
    }
};

