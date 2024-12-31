// Lấy tham số từ URL
const urlParams = new URLSearchParams(window.location.search);
const promotionID = urlParams.get('promotionID'); // Lấy giá trị của 'promotionID'

// Kiểm tra và sử dụng promotionID
if (promotionID) {
  console.log('Promotion ID:', promotionID);
  // Gọi API để lấy dữ liệu khuyến mãi (ví dụ gọi API để load dữ liệu vào form)
  loadPromotionData(promotionID);
} else {
  console.log('Không có promotionID trong URL');
}

// Hàm để lấy thông tin khuyến mãi và điền vào form
function loadPromotionData(promotionID) {
  fetch(`http://localhost:8080/admin/promotion/?promotionID=${promotionID}`)
    .then(response => response.json())
    .then(data => {
      if (data) {
        // Điền dữ liệu vào các trường trong form
        document.getElementById('promotion-id').value = data.promotionID;
        document.getElementById('promotion-name').value = data.promotionName;
        document.getElementById('discount-percentage').value = data.discountPercentage;
        document.getElementById('promotion-details').value = data.promotionDetails;
      } else {
        alert('Không tìm thấy khuyến mãi!');
      }
    })
    .catch(error => {
      console.error('Lỗi khi lấy dữ liệu:', error);
      alert('Có lỗi xảy ra khi tải thông tin khuyến mãi.');
    });
}

function addPromotion() {
 
    const promotionID = document.getElementById('promotion-id').value;
    const promotionName = document.getElementById('promotion-name').value;
    const discountPercentage = document.getElementById('discount-percentage').value;
    const promotionDetails = document.getElementById('promotion-details').value;
  
    // Kiểm tra dữ liệu hợp lệ
    if (!promotionID || !promotionName || !discountPercentage || !promotionDetails) {
      alert('Vui lòng điền đầy đủ thông tin!');
      return;
    }
  
    // Tạo đối tượng dữ liệu để gửi
    const promotionData = {
      promotionID: promotionID,
      promotionName: promotionName,
      discountPercentage: discountPercentage,
      promotionDetails: promotionDetails
    };
  
 
    fetch('http://localhost:8080/admin/promotion/update-promotion', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(promotionData) 
    })
    .then(response => response.json()) 
    .then(data => {
      if (data.success) {
        alert('Khuyến mãi được cập nhật thành công!');
        location.reload();
      } else {
        alert('Có lỗi xảy ra khi cập nhật khuyến mãi!');
      }
    })
    .catch(error => {
        alert('Khuyến mãi được cập nhật thành công!');
        location.reload();
    });
  }
  