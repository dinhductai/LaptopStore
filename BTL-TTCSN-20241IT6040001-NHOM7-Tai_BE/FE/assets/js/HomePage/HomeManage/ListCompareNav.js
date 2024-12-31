// So sánh
// Biến để lưu trữ sản phẩm được so sánh
function compareProducts() {
    // Lấy danh sách các sản phẩm đang được thêm vào thanh so sánh (nav)
    if (comparedProducts.length === 2) {
      const product1ID = comparedProducts[0]; 
      const product2ID = comparedProducts[1];
  
      // Tạo URL để chuyển đến trang product-compare.html và truyền các ID sản phẩm
      const compareURL = `product-compare.html?product1=${product1ID}&product2=${product2ID}`;
  
      // Chuyển hướng đến trang so sánh
      window.location.href = compareURL;
    } else {
      alert("Bạn cần chọn 2 sản phẩm để so sánh!");
    }
  }
  
  
  let comparedProducts = [];
  
  // Hàm thêm sản phẩm vào danh sách so sánh
  function addToCompare(productId) {
    if (comparedProducts.length >= 2) {
      alert('Bạn chỉ có thể so sánh tối đa 2 sản phẩm!');
      return;
    }
    
    // Kiểm tra xem sản phẩm đã được thêm chưa
    if (!comparedProducts.includes(productId)) {
      comparedProducts.push(productId);
      updateCompareProducts();
  
      // Hiện thanh điều hướng nếu có sản phẩm
      document.querySelector('.navbar').style.display = 'flex';
    } else {
      alert('Sản phẩm đã được thêm vào danh sách so sánh!');
    }
  }
  
  // Hàm cập nhật danh sách sản phẩm so sánh trên navbar
  function updateCompareProducts() {
    const compareProductsDiv = document.querySelector('.compare-products');
    const navbar = document.querySelector('.navbar');
    compareProductsDiv.innerHTML = ''; // Xóa nội dung cũ
  
    // Kiểm tra nếu có sản phẩm trong danh sách so sánh
    if (comparedProducts.length > 0) {
      navbar.style.display = 'flex'; // Hiện thanh navbar
      document.getElementById('toggle-arrow').style.display = 'inline'; // Hiện mũi tên
  
      // Lấy toàn bộ sản phẩm từ API
      fetch('http://localhost:8080/user/home')
        .then(response => response.json())
        .then(data => {
          comparedProducts.forEach(productId => {
            const product = data.getProductForHomePage.find(item => item.productId === productId);
            if (product) {
              const productItem = document.createElement('div');
              productItem.classList.add('compare-item');
              productItem.innerHTML = `
                <div class="compare-product-image">
                  <img src="${product.imageUrl}" alt="${product.productName}">
                   <span>${product.productName}</span>
                </div>
                <div class="compare-product-info">
                 
                  <button class="remove-btn" onclick="removeFromCompare(${productId})">X</button>
                </div>
              `;
              compareProductsDiv.appendChild(productItem);
            }
          });
        })
        .catch(error => console.error('Error fetching products:', error));
    } else {
      navbar.style.display = 'none'; // Ẩn thanh navbar nếu không có sản phẩm
      document.getElementById('toggle-arrow').style.display = 'none'; // Ẩn mũi tên
    }
  }
  
  // Hàm xóa sản phẩm khỏi danh sách so sánh
  function removeFromCompare(productId) {
    comparedProducts = comparedProducts.filter(id => id !== productId);
    updateCompareProducts();
  }
  
  // Hàm xóa tất cả sản phẩm trong danh sách so sánh
  function clearAllCompare() {
    comparedProducts = [];
    updateCompareProducts();
  }
  
  // Hàm để toggle navbar
  function toggleNavbar() {
    const navbar = document.querySelector('.navbar');
    const arrow = document.getElementById('toggle-arrow');
  
    // Kiểm tra nếu navbar đang hiển thị
    if (navbar.style.display === 'flex') {
      navbar.style.display = 'none'; // Ẩn navbar
      arrow.textContent = '▲'; // Mũi tên lên
    } else {
      navbar.style.display = 'flex'; // Hiện navbar
      arrow.textContent = '▼'; // Mũi tên xuống
    }
  }
  
  
  // So sánh
  