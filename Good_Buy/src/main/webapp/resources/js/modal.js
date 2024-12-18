// Modal
function showModal(id) {
  console.log("click");
  const modal = document.querySelector('#' + id);
  modal.classList.add('show-modal');
}
function hideModal(id) {
  const modal = document.querySelector('#' + id);
  modal.classList.remove('show-modal'); 
}
