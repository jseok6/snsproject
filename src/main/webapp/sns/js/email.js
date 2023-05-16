// 팝업 열기 버튼 클릭 시 팝업 보이기
document.getElementById("popup-button").addEventListener("click", function() {
    document.querySelector(".popup-container2").style.display = "block";
  });
  
  // 팝업 닫기 버튼 클릭 시 팝업 숨기기
  document.getElementById("pupup-button-cencel").addEventListener("click", function() {
    document.querySelector(".popup-container2").style.display = "none";
  });