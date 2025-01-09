document.addEventListener("DOMContentLoaded", function(){
	updateTime(); 
	setInterval(updateTime, 1000);
	
	for(let item of document.querySelectorAll('.counter-text')) {
		counter(item);
	}
	
});

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