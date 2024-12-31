// Biến toàn cục để lưu trạng thái slide hiện tại
let currentSlide = 0;

// Lấy danh sách tất cả các ảnh
const slides = document.querySelectorAll('.img-fluid-item1 img');

// Hiển thị slide ban đầu
showSlide(currentSlide);

// Hàm hiển thị slide
function showSlide(index) {
  // Ẩn tất cả các slide
  slides.forEach((slide) => {
    slide.classList.remove('active');
  });

  // Hiển thị slide hiện tại
  slides[index].classList.add('active');
}

// Hàm chuyển đổi slide
function changeSlide(direction) {
  // Tính toán chỉ số slide tiếp theo
  currentSlide += direction;

  // Kiểm tra nếu vượt quá số lượng slide
  if (currentSlide >= slides.length) {
    currentSlide = 0; // Quay về slide đầu tiên
  } else if (currentSlide < 0) {
    currentSlide = slides.length - 1; // Quay về slide cuối cùng
  }

  // Hiển thị slide mới
  showSlide(currentSlide);
}
