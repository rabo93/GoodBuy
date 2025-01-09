document.addEventListener("DOMContentLoaded", function () {
    const periodList = $('#periodList2').DataTable({
        lengthChange: false,
        searching: false,
        info: true,
        ordering: true,
        paging: true,
        responsive: true,
        destroy: true,
        scrollX: true,
        autoWidth: false,
        data: generateCurrentMonthDates(), // 기본값: 현재 월의 일자별 데이터
        columns: [
            { title: "날짜", data: "date" },
            { title: "가입수", data: "join", defaultContent: "0" },
            { title: "방문자수", data: "visit", defaultContent: "0" },
            { title: "거래수", data: "order", defaultContent: "0" },
        ],
        language: {
            emptyTable: "데이터가 없습니다.",
        },
    });

    // 현재 월의 일자별 데이터를 생성하는 함수
   function generateCurrentMonthDates() {
		const today = new Date(); // 현재 날짜
		const year = today.getFullYear(); // 현재 연도
		const month = today.getMonth(); // 현재 월 (0부터 시작)
		const daysInMonth = new Date(year, month + 1, 0).getDate(); // 현재 월의 마지막 날짜 계산
		console.log("daysInMonth: " + daysInMonth); // 31
		
		const data = [];
		for (let day = 1; day <= daysInMonth; day++) {
	        const date = new Date(year, month, day);
//	        const formattedDate = date.toISOString().split('T')[0]; // YYYY-MM-DD 포맷
	        const formattedDate = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`; // YYYY-MM-DD 포맷
	        data.push({
				date: formattedDate,
				join: "", // 기본값
				visit: "", // 기본값
				order: "", // 기본값
			});
	    }
	    
	    return data; // 현재 달의 데이터만 반환
	}
    
     // 테이블에 데이터를 추가하는 함수
    function populateTable() {
        const monthData = generateCurrentMonthDates();
        periodList.clear();  // 기존 데이터를 비우기
        periodList.rows.add(monthData);  // 새로운 데이터를 추가
        periodList.draw();  // 테이블 갱신
    }

    // 페이지가 로드되면 데이터를 테이블에 삽입
    populateTable();
    
});