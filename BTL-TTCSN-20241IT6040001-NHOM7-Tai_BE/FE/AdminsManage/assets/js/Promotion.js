// Biến toàn cục để lưu promotionID
let selectedPromotionID = null;

// Gọi API để lấy danh sách khuyến mãi
fetch('http://localhost:8080/admin/promotion')
  .then(response => response.json())
  .then(data => {
    const promotionListElement = document.getElementById('promotion-list');
    
    if (data.length === 0) {
      promotionListElement.innerHTML = '<tr><td colspan="3">Không có khuyến mãi nào</td></tr>';
    } else {
      data.forEach(promotion => {
        const row = document.createElement('tr');
        row.innerHTML = `
          <td>${promotion.promotionID}</td>
          <td class="promotion-name">${promotion.promotionName}</td> <!-- Sử dụng class thay vì id -->
          <td>
            <input type="radio" name="promotion" value="${promotion.promotionID}" 
                   onclick="selectPromotion(${promotion.promotionID}, '${promotion.promotionName}')">
          </td>
        `;
        promotionListElement.appendChild(row);
      });
    }
  })
  .catch(error => {
    console.error('Lỗi khi gọi API:', error);
    const promotionListElement = document.getElementById('promotion-list');
    promotionListElement.innerHTML = '<tr><td colspan="3">Lỗi khi tải khuyến mãi</td></tr>';
  });

// Hàm để chọn khuyến mãi
function selectPromotion(promotionID, promotionName) {
  selectedPromotionID = promotionID;
  console.log('Khuyến mãi được chọn:', promotionName); // Hiển thị tên khuyến mãi
  loadProductsByPromotion(selectedPromotionID);
  loadPromotionData(promotionID);
  const url = new URL(window.location.href);
  url.searchParams.set('promotionID', promotionID);
  window.history.pushState({}, '', url);

  // Gán tên khuyến mãi vào phần tử có class 'promotion-name'
  const promotionNameElements = document.querySelectorAll('.promotion-name');
  promotionNameElements.forEach(element => {
    if (element.textContent === promotionName) {
      // Gán giá trị vào phần tử
      element.textContent = promotionName;
    }
  });
}

// Hàm để tải thông tin khuyến mãi vào form theo promotionID
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
        alert('Không tìm thấy thông tin khuyến mãi!');
      }
    })
    .catch(error => {
      // console.error('Lỗi khi lấy thông tin khuyến mãi:', error);
      // alert('Có lỗi khi tải thông tin khuyến mãi.');
    });
}


// Hàm để gọi API lấy sản phẩm theo khuyến mãi đã chọn
function loadProductsByPromotion(promotionID) {
  const productListElement = document.getElementById('product-list');
  
  fetch(`http://localhost:8080/admin/promotion-product/${promotionID}`)
    .then(response => response.json())
    .then(data => {
      productListElement.innerHTML = '';
      if (data.length === 0) {
        productListElement.innerHTML = '<tr><td colspan="5">Không có sản phẩm nào áp dụng khuyến mãi</td></tr>';
      } else {
        data.forEach(product => {
          const row = document.createElement('tr');
          row.innerHTML = `
            <td>${product.productID}</td>
            <td>${product.productName}</td>
            <td>${product.brand}</td>
            <td>
              <input type="checkbox" ${product.hasPromotion === 1 ? 'checked' : ''} 
                     onchange="togglePromotion(${product.productID}, this.checked)">
            </td>
          `;
          productListElement.appendChild(row);
        });
      }
    })
    .catch(error => {
      console.error('Lỗi khi gọi API:', error);
      productListElement.innerHTML = '<tr><td colspan="5">Danh sách trống</td></tr>';
    });
}

// Hàm xử lý khi thay đổi checkbox
function togglePromotion(productID, isChecked) {
  if (selectedPromotionID) {
    const url = isChecked
      ? `http://localhost:8080/admin/promotion-product/add-promotion/${productID}/${selectedPromotionID}`
      : `http://localhost:8080/admin/promotion-.product/remove-promotion/${productID}/${selectedPromotionID}`;

    fetch(url, {
      method: isChecked ? 'POST' : 'DELETE',
      headers: { 'Content-Type': 'application/json' },
      body: isChecked ? JSON.stringify({ productID, selectedPromotionID, isApplied: true }) : null,
    })
    .then(response => response.json())
    .then(data => {
      if (isChecked) {
        console.log('Khuyến mãi được thêm vào sản phẩm:', data);
      } else {
        console.log('Khuyến mãi đã bị xóa khỏi sản phẩm:', data);
      }
    })
    .catch(error => {
      console.error('Lỗi khi thay đổi khuyến mãi cho sản phẩm:', error);
      loadProductsByPromotion(selectedPromotionID);
    });
  } else {
    console.log('Không có khuyến mãi được chọn.');
  }
}

// Gọi hàm load sản phẩm khi trang được tải
loadProductsByPromotion(selectedPromotionID);

