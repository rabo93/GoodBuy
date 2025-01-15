document.addEventListener("DOMContentLoaded", function(){
	Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#858796';
	
	// 카테고리 label 클래스명 지정
	const classNames = {
		"여성의류" : "primary", 
		"남성의류" :"success", 
		"레저/스포츠" :"info", 
		"생활용품" :"secondary", 
		"키즈" :"warning", 
		"도서" :"danger"	
	};
	
	// 카테고리 label 색상 지정
	const colors = {
		"여성의류" : "#4e73df", 
		"남성의류" :"#1cc88a", 
		"레저/스포츠" :"#36b9cc", 
		"생활용품" :"#858796", 
		"키즈" :"#f6c23e", 
		"도서" :"#e74a3b"
	}
		
	// 시계 
	updateTime(); 
	setInterval(updateTime, 1000);
	
	for(let item of document.querySelectorAll('.counter-text')) {
		counter(item);
	}
	
	// 가격대별 상품 개수 
	$.ajax({
		url : "PriceRangeChart",
		type : "POST",
		dataType: "JSON",
	}).done(function(res) {
		const dataArr = [];
		for(let key in res) {
			dataArr.push(res[key]);
		}
		createBarChart(dataArr);
		
	}).fail(function(){
		alert("실패!");
	});
	
	
	// 카테고리별 상품 개수
	$.ajax({
		url : "CategoryStats",
		type : "POST",
		dataType: "JSON",
	}).done(function(res){
		const labelArr = [];
		const dataArr = [];
		const colorArr = [];
		
		for(let key in res) {
			let category = res[key].PRODUCT_CATEGORY.replaceAll('"', '');
			
			labelArr.push(res[key].PRODUCT_CATEGORY);
			dataArr.push(res[key].COUNT);
			colorArr.push(colors[category]);
			
			$("#categoryLabels").append(`
				<span class="mr-2">
		            <i class="fas fa-circle text-${classNames[category]}"></i> ${category}
		        </span>
			`);
		}
		
		createDonutChart(labelArr, dataArr, colorArr);
		
	}).fail(function() {
		alert("실패");
	});
	
	const transactionList = $('#transactionList').DataTable({
		lengthChange : true, // 건수
		searching : false, // 검색
		info : false, // 정보
		ordering : false, // 정렬
		paging : false,
		responsive: true, // 반응형
		destroy: true,
		scrollX: false, 
		autoWidth: false,
		ajax : {
			url: "WeeklyTransaction",
			type: "POST",
			dataType : "JSON",
			dataSrc: function (res) {
				const data = res.transactionList;
				const start = 0; 
				
				// 회원번호(PK)가 아닌 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		columnDefs: [
		],
		columns: [
            { title: "No.", data: "listIndex", className : "dt-center", width: '30px', },
            { title: "판매자", data : "SELLER_ID",className : "dt-center", defaultContent: "",
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
            },
            { title: "구매자", data : "BUYER_ID", defaultContent: "",},
            { title: "거래일시", data : "PAYDATE", defaultContent: "", },
            { title: "거래상품명", data : "PRODUCT_TITLE", defaultContent: "", },
            { title: "거래위치", data : "PAY_ADDRESS", defaultContent: "",  },
        ],
		serverSide : false, // 서버사이드 처리
		processing : false,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
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
	
});

// 바 형식 그래프 그리기
function createBarChart(dataArr) {
	const ctx = document.getElementById("priceRangeChart");
	const myLineChart = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: ["~ 10,000", " ~ 50,000", " ~ 100,000", " ~ 500,000", "500,000 ~"],
			datasets: [{
				label: "가격대별 상품 개수",
				backgroundColor: "#4e73df",
				hoverBackgroundColor: "#2e59d9",
				borderColor: "#4e73df",
				data: dataArr,
			}],
		},
		options: {
			maintainAspectRatio: false,
			layout: { padding: { left: 10, right: 25, top: 25, bottom: 0} },
			scales: {
				xAxes: [{ time: { unit: '원'}, gridLines: { display: false, drawBorder: false }, ticks: { maxTicksLimit: 6 }}],
				yAxes: [{
					ticks: {
						min: 0,
						max: 20,
						maxTicksLimit: 4, 
						padding: 5,
					},
					gridLines: { color: "rgb(234, 236, 244)", zeroLineColor: "rgb(234, 236, 244)", drawBorder: false, borderDash: [2], zeroLineBorderDash: [2] }
				}],
			},
			legend: { display: false },
			tooltips: { 
				backgroundColor: "rgb(255,255,255)",
				bodyFontColor: "#858796",
				titleMarginBottom: 10,
				titleFontColor: '#6e707e',
				titleFontSize: 14,
				borderColor: '#dddfeb',
				borderWidth: 1,
				xPadding: 15,
				yPadding: 15,
				displayColors: false,
				intersect: false,
				caretPadding: 10,
				callbacks: {
					label: function(tooltipItem, chart) {
						var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
						return datasetLabel + ': ' + number_format(tooltipItem.yLabel) + "개";
					}
				}
			} // tooltips
		} //options
	}); // end
}


// 도넛차트 그리기
function createDonutChart(labelArr, dataArr, colorArr){
	const ctx2 = document.getElementById("categoryStats");
	const myPieChart = new Chart(ctx2, {
		type: 'doughnut',
		data: {
			labels: labelArr,
			datasets: [{
			data: dataArr,
			// 순서 : 남성의류, 도서, 레저/스포츠, 생활용품, 여성의류, 키즈
			backgroundColor: colorArr,
			// hoverBackgroundColor: [ '#17a673', '#e74a3b', '#2c9faf', '#5a5c69', '#4e73df', '#f6c23e'],
			hoverBorderColor: "rgba(234, 236, 244, 1)",
		}],
	},
	options: {
        maintainAspectRatio: false,
        tooltips: {
          backgroundColor: "rgb(255,255,255)",
          bodyFontColor: "#858796",
          borderColor: '#dddfeb',
          borderWidth: 1,
          xPadding: 15,
          yPadding: 15,
          displayColors: false,
          caretPadding: 10,
        },
        legend: {
          display: false
        },
        cutoutPercentage: 80,
      },
	});
}

// 카운트 애니메이션 함수
function counter(counter) {
  let max = parseInt(counter.textContent);
  let now = parseInt(counter.textContent);
  const handle = setInterval(() => {
    counter.innerHTML = Math.ceil(max - now);
    
    // 목표에 도달하면 정지
    if (now < 1) clearInterval(handle);
    
    // 적용될 수치, 점점 줄어듬
    const step = now / 10;
    now -= step;
    
  }, 30);
}

// 오늘 날짜 및 시간 구하기 (실시간)
function updateTime() { 
	const now = moment(); 
	const localTime = now.format("YYYY-MM-DD HH:mm:ss"); 
	document.querySelector("#todayText").innerHTML = `<i class="fa-solid fa-clock"></i> ${localTime}`; 
} 

// 숫자 포맷
function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}