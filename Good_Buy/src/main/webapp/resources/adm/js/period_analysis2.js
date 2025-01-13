document.addEventListener("DOMContentLoaded", function () {
    const periodList = $('#periodList2').DataTable({
        lengthChange: false,	//건수(비활성화) 
        searching: false,		//검색(비활성화) 
        info: true,				//정보
        ordering: true,			//정렬
        paging: false,  		//페이징(비활성화) 
        responsive: true,		//반응형
        destroy: true,			
        scrollX: true,
        autoWidth: false,		//컬럼사이즈 조정 자동설정(비활성화)
        data: generateCurrentMonthDates(), // 기본값: 현재 월의 일자별 데이터
        columns: [
            { title: "날짜", data: "date" },
            { title: "가입수", data: "join", defaultContent: "0" },
            { title: "방문자수", data: "visit", defaultContent: "0" },
            { title: "거래수", data: "order", defaultContent: "0" },
        ],
        initComplete: function () {
			// 데이터 초기화 완료 후 총합 계산
			updateFooter(this.api());
		},
        language: {
            emptyTable: "데이터가 없습니다.",
            info: "현재 _START_ - _END_ / 총 _TOTAL_건",
            loadingRecords: "로딩중...",
			processing: "잠시만 기다려 주세요...",
			zeroRecords: "일치하는 데이터가 없습니다.",
        },
         footerCallback: function (row, data, start, end, display) {
	        var api = this.api();
	        
	
	        var totalJoin = api
	            .column(2, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseFloat(a) + parseFloat(b);
	            }, 0);
	
	        var totalVisit = api
	            .column(3, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseFloat(a) + parseFloat(b);
	            }, 0);
	
			var totalTrade = api
	            .column(3, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseFloat(a) + parseFloat(b);
	            }, 0);
	            
	        $(api.column(1).footer()).html(totalJoin.toFixed(1));
	        $(api.column(2).footer()).html(totalVisit.toFixed(2));
	        $(api.column(3).footer()).html(totalTrade.toFixed(3));
	        
	    }
    });
	
	//------------------------------------------------------------------
    // 현재 월의 일자별 데이터를 생성하는 함수
   function generateCurrentMonthDates() {
		const today = new Date(); // 현재 날짜
		const year = today.getFullYear(); // 현재 연도
		const month = today.getMonth(); // 현재 월 (0부터 시작)
		const daysInMonth = new Date(year, month + 1, 0).getDate(); // 현재 월의 마지막 날짜 계산
//		console.log("daysInMonth: " + daysInMonth); // 31
		
		const data = [];
		for (let day = 1; day <= daysInMonth; day++) {
//	        const date = new Date(year, month, day);
//	        const formattedDate = date.toISOString().split('T')[0]; // YYYY-MM-DD 포맷
//	        const formattedDate = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`; // YYYY-MM-DD 포맷
	        const date = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
	        data.push({
//				date: formattedDate,
//				join: "", // 기본값
//				visit: "", // 기본값
//				order: "", // 기본값
				
//				date: formattedDate,
				date: date,
				join: Math.floor(Math.random() * 100), // 테스트용 난수 데이터
				visit: Math.floor(Math.random() * 100),
				order: Math.floor(Math.random() * 100),
			});
	    }
	    
	    return data; // 현재 달의 데이터만 반환
	}
	//------------------------------------------------------------------
    // 테이블의 하단에 총합을 추가하는 함수
    function updateFooter(api) {
//		const data = api.rows().data(); // 테이블의 모든 데이터를 가져오기
//		console.log("data:" + data);
//		
//		// 총합 계산
//		let totalJoin = 0;
//		let totalVisit = 0;
//		let totalOrder = 0;
//		
//		data.each(function (row) {
//			totalJoin += parseInt(row.join || 0, 10);
//			totalVisit += parseInt(row.visit || 0, 10);
//			totalOrder  += parseInt(row.order || 0, 10);
//		});
//		
//		// tfoot에 총합 업데이트
//		// 기존 총합 행을 덮어쓰지 않도록 추가
//	    const tfootRow = `
//	        <tr>
//	            <th>총합</th>
//	            <th>${totalJoin}</th>
//	            <th>${totalVisit}</th>
//	            <th>${totalOrder}</th>
//	        </tr>
//	    `;

//		const tfootRow = $('<tr>')
//            .append($('<th>').text('총합'))
//            .append($('<th>').text(totalJoin))
//            .append($('<th>').text(totalVisit))
//            .append($('<th>').text(totalOrder));
//	    console.log("tfootRow : " + tfootRow);
	    
	    // tfoot에 총합행 추가
//        $('#dataTotal').html(tfootRow);
//        $('#periodList2 tfoot').html(tfootRow);
        
//        console.log("Table data:", data.toArray());
//        console.log("Total Join:", totalJoin);
//		console.log("Total Visit:", totalVisit);
//		console.log("Total Order:", totalOrder);
    }
});