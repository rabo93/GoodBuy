/* 공통코드 등록 */
document.addEventListener("DOMContentLoaded", function(){
	$('#commoncode').DataTable({
		lengthChange : false,
		searching : false,
		info : false,
		ordering : false,
		paging : false,
	});
	
	const commoncodeTb = $('#commoncode');
	const addRow = document.querySelector("#commoncodeTrAdd");
	let counter = 1;
	
	function addNewRow(){
		console.log("add");
//		commoncodeTb.add()
//			.row([
//				counter + '.1',
//				counter + '.2',
//				counter + '.3',
//				counter + '.4',
//				counter + '.5',
//				counter + '.5'
//			])
//			.draw(false);
//		counter++;
	}
	
	addRow.addEventListener("click", addNewRow);
	addNewRow();
});
