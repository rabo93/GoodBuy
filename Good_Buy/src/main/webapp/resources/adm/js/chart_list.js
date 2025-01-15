let myLineChart = null; // 차트 전역변수

document.addEventListener("DOMContentLoaded", function(){
	Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#858796';
	
	// 채팅 통계 데이터 가져오기
	fetchData();
	
	// 선택된 날짜로 검색하기
	$(document).on("click", "#searchDateBtn", function() {
		const schDate = $("#schDate").val();
        fetchData(schDate); // 선택된 날짜로 조회
	});
	
	// 기간별 검색 필터링
    $('#schDate').daterangepicker({
		startDate : moment().subtract(6, 'days'),
		endDate : moment(),
        maxDate: moment(),
        locale: {
			start: '시작일시',
			end: '종료일시',
		    separator: " ~ ", // 시작일시와 종료일시 구분자
		    format: 'YYYY-MM-DD', // 일시 노출 포맷
		    applyLabel: "확인", // 확인 버튼 텍스트
		    cancelLabel: "취소", // 취소 버튼 텍스트
		    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
		    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			customRangeLabel: '기간 지정',
		 },
		autoUpdateInput: true,
	    timePicker: false, // 시간 노출 여부
	    showDropdowns: true, // 년월 수동 설정 여부
	    autoApply: false, // 확인/취소 버튼 사용여부
		ranges: {
            '이번 달': [moment().startOf('month'), moment().endOf('month')], // 이번 달 전체
            '지난 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')], // 지난 달 전체
            '지난 7일': [moment().subtract(6, 'days'), moment()], // 최근 7일
            '지난 14일': [moment().subtract(13, 'days'), moment()], // 최근 14일
            '지난 30일': [moment().subtract(29, 'days'), moment()], // 최근 30일
        },
    }).on('show.daterangepicker', function (ev, picker) {
        picker.container.addClass('goodbuyCustomPicker');                            
    });
    
    // 전체 회원수 가져오기
    $.ajax({
		url: "AllUserCount",
		type : "POST",
		dataType: "JSON",
	}).done(function(res){
		$("#allUserCount").html(res);
	}).fail(function(){
		alert("조회 실패");
	});
	
	// 전체 채팅 건수 가져오기
	$.ajax({
		url: "AllChatCount",
		type : "POST",
		dataType: "JSON",
	}).done(function(res){
		$("#allChatCount").html(res);
	}).fail(function(){
		alert("조회 실패");
	});
    
    // 날짜 선택 후에도 placeholder 유지
    $('#schDate').on('apply.daterangepicker', function(ev, picker) {
        $(this).val(`${picker.startDate.format('YYYY-MM-DD')} ~ ${picker.endDate.format('YYYY-MM-DD')}`);
    });
	
});

// 채팅 통계 데이터 가져오기
function fetchData(schDate = null){
	const requestData = schDate ? { schDate: schDate } : {};
		
	// moment.js 에 한글 추가
	moment.locale('ko');
	
	// 기간별 소통
	$.ajax({
		url: "UserChatAnalysis",
		type : "POST",
		dataType: "JSON",
		contentType : "application/json",
		data : JSON.stringify(requestData)
	}).done(function(res) {
		console.log(res);
		const labelArr = [];
		const dataArr = [];
		for(let key in res) {
//			labelArr.push(moment(res[key].SEND_TIME, 'M월 D, YYYY').format('MM/DD'));
//			labelArr.push(moment(res[key].SEND_TIME, 'MMM D, YYYY').format('MM/DD'));
			labelArr.push(res[key].SEND_TIME);
			dataArr.push(res[key].COUNT);
		}
		console.log(labelArr);
		
		// 차트 그리기
		createChart(labelArr, dataArr);		
	}).fail(function(){
		alert("실패");
	});
}

// 차트 생성
function createChart(labelArr, dataArr){
	const ctx = document.getElementById("chatAreaChart");
	
	if (myLineChart) {
        myLineChart.destroy();
    }
    
	myLineChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: labelArr,
			datasets: [{
				label: "회원 채팅 건수",
				lineTension: 0.3,
		      backgroundColor: "rgba(78, 115, 223, 0.05)",
		      borderColor: "rgba(78, 115, 223, 1)",
		      pointRadius: 3,
		      pointBackgroundColor: "rgba(78, 115, 223, 1)",
		      pointBorderColor: "rgba(78, 115, 223, 1)",
		      pointHoverRadius: 3,
		      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
		      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
		      pointHitRadius: 10,
		      pointBorderWidth: 2,
				data: dataArr,
			}],
		},
		options: {
			maintainAspectRatio: false,
			layout: { padding: { left: 10, right: 25, top: 25, bottom: 0} },
			scales: {
				xAxes: [{ time: { unit: 'date'}, gridLines: { display: false, drawBorder: false }, ticks: { maxTicksLimit: 6 }}],
				yAxes: [{
					ticks: {
						min: 0,
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