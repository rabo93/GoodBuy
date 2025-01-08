function linkAccount() {
	// 새 창으로 사용자 인증 요청 수행
	// => 빈 창을 먼저 띄운 후 해당 창에 사용자 인증 페이지 요청
	
	// response_type - 고정값: code Y OAuth 2.0 인증 요청 시 반환되는 형태
	// client_id : 오픈뱅킹에서 발급한 이용기관 앱의 Client ID
	// scope : 권한범위
	// state : 32 bytes 고정 - 보안위협에 대응하기 위해 이용기관이 세팅하는 난수값 (Callback 호출 시 그대로 전달됨)
	// auth_type : 사용자인증타입 구분 (0:최초인증, 1:재인증, 2:인증생략)
	let authWindow = window.open("about:blank", "authWindow", "width=500,height=700");
	authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
							+ "response_type=code" 
							+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9" 
							+ "&redirect_uri=http://localhost:8081/Callback"
							+ "&scope=login inquiry transfer" 
							+ "&state=12345678901234567890123456789012" 
							+ "&auth_type=0"; 
}

function submitForm(anchor) {
    // a 태그의 data-form-id 속성에서 관련 form의 ID를 가져옴
    const formId = anchor.getAttribute('data-form-id');
    const form = document.getElementById(formId);

    if (form && form.tagName === 'FORM') {
        form.submit();
    } else {
        console.error(`No <form> found with ID: ${formId}`);
    }
}

function openModal(modal) {
	$("html").addClass("fixed");
	if(modal == 'charge') {	
		document.getElementById('pay-account-modal').style.display = 'block';
	} else if (modal == 'refund') {
		document.getElementById('pay-refund-modal').style.display = 'block';
	}
}

function closeModal(modal) {
	$("html").removeClass("fixed");
	if(modal == 'charge') {	
		document.getElementById('pay-account-modal').style.display = 'none';
	} else if (modal == 'refund') {
		document.getElementById('pay-refund-modal').style.display = 'none';
	}
}

function addAmount(amount) {
//	console.log(amount);
    const inputField = document.getElementById('total-amount');
    const currentValue = parseInt(inputField.value) || 0;  // 현재 값 가져오기 (없으면 0)
    inputField.value = currentValue + amount;  // 금액 추가
}

// 이용내역 전체의 토글버튼 - 클릭하면 해당 항목이 보이기는 함. 전체내역이 기본설정이 안됨.
function listToggleButton(button, type) {
	const buttons = document.querySelectorAll('button');
	// 목록 활성화 상태 업데이트
	const lists = document.querySelectorAll('.use-history-item');
	buttons.forEach(button => {
		
		button.addEventListener('click', () => {
		    // 모든 버튼에서 selected 클래스 제거
		    buttons.forEach(btn => btn.classList.remove('selected'));
		    
		    // 클릭된 버튼만 선택 상태로 설정
	        button.classList.add('selected');
	        console.log(button.classList[0]);
	        console.log(button.classList[1]);
	        
			 lists.forEach(list => {
	            if (list.dataset.type === type || type === 'all') {
	                list.classList.add('active');
	            } else {
	                list.classList.remove('active');
	            }
			});
	    });
	});
}


// 이용내역 전체의 토글버튼 - 클릭하면 해당 항목이 보이기는 함. 전체내역이 기본설정이 안됨.
//function listToggleButton(button, type) {
////	console.log(button);
////	console.log("button : " + type);
//	// 모든 버튼을 선택
////	const buttons = document.querySelectorAll('.use-buttons > button');
//	const buttons = document.querySelectorAll('button');
//	buttons.forEach(button => {
//		button.addEventListener('click', () => {
//		    // 모든 버튼에서 selected 클래스 제거
//		    buttons.forEach(btn => btn.classList.remove('selected'));
//		    
//		    // 클릭된 버튼만 선택 상태로 설정
//	        button.classList.add('selected');
//	        
//	        
//	        
//	        
//			 // 목록 활성화 상태 업데이트
//			const lists = document.querySelectorAll('.use-history-item');
//			lists.forEach(list => {
//	        	// 처음에는 전체내역 활성화 상태
//				
//	            if (list.dataset.type === type || type === 'all') {
//	                list.classList.add('active');
//	            } else {
//	                list.classList.remove('active');
//	            }
//			});
//
//	    });
//	});
//
//}



//// 이용내역 전체의 토글버튼 - 라디오버튼까지는 됨.
//function listToggleButton(button, type) {
//	console.log(type);
//	// 모든 버튼을 선택
//	const buttons = document.querySelectorAll('.use-buttons > button');
//	
//	// 각 버튼에 클릭 이벤트 리스너 추가
//	buttons.forEach(button => {
//	    button.addEventListener('click', () => {
//	        // 모든 버튼의 선택 상태 초기화
//	        buttons.forEach(btn => btn.classList.remove('selected'));
//	
//	        // 클릭된 버튼만 선택 상태로 설정
//	        button.classList.add('selected');
//	    });
//	});
//}
	
	
