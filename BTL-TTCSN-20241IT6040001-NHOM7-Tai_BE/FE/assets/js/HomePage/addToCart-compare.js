// Hàm thêm sản phẩm vào giỏ hàng
function addToCart(customerID, productID) {
    const apiUrl = "http://localhost:8080/user/product-add";
    const payload = {
        customerID: parseInt(customerID), // Chuyển customerID về số nếu cần
        productID: parseInt(productID) // Chuyển productID về số nếu cần
    };

    fetch(apiUrl, {
        method: 'POST', // Gửi yêu cầu POST
        headers: {
            'Content-Type': 'application/json', // Định dạng JSON
        },
        body: JSON.stringify(payload) // Chuyển dữ liệu thành JSON
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`Lỗi API: ${response.statusText}`);
        }
        return response.text();
    })
    .then(data => {
        console.log('Thêm vào giỏ hàng thành công:', data);
        alert('Sản phẩm đã được thêm vào giỏ hàng!');
    })
    .catch(error => {
        console.error('Lỗi khi thêm vào giỏ hàng:', error);
        alert('Không thể thêm vào giỏ hàng. Vui lòng thử lại!');
    });
}

// Gắn sự kiện click vào nút "Thêm vào giỏ hàng"
const addToCartButton1 = document.getElementById('add-to-cart-product1');
const addToCartButton2 = document.getElementById('add-to-cart-product2');

// Thêm sự kiện click cho nút "Thêm vào giỏ hàng" của sản phẩm 1
addToCartButton1.addEventListener('click', function() {
    const productID = addToCartButton1.getAttribute('data-product-id'); // Lấy ID sản phẩm từ data-product-id
    if (!productID) {
        alert("Không tìm thấy ID sản phẩm!");
        return;
    }

    // Kiểm tra customerID từ localStorage
    const customerID = localStorage.getItem('id-customer');
    if (!customerID) {
        alert("Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng!");
        return;
    }

    // Gọi hàm thêm sản phẩm vào giỏ hàng
    addToCart(customerID, productID);
});

// Thêm sự kiện click cho nút "Thêm vào giỏ hàng" của sản phẩm 2
addToCartButton2.addEventListener('click', function() {
    const productID = addToCartButton2.getAttribute('data-product-id'); // Lấy ID sản phẩm từ data-product-id
    if (!productID) {
        alert("Không tìm thấy ID sản phẩm!");
        return;
    }

    // Kiểm tra customerID từ localStorage
    const customerID = localStorage.getItem('id-customer');
    if (!customerID) {
        alert("Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng!");
        return;
    }

    // Gọi hàm thêm sản phẩm vào giỏ hàng
    addToCart(customerID, productID);
});
