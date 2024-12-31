document.addEventListener('DOMContentLoaded', () => {
    const tableBody = document.getElementById('product-list');
    //thanhtoan
    const totalPriceElement = document.querySelector('.total-price');

    //tong cong
    const totalElement = document.querySelector('.total-amount');
    const selectAllCB = document.getElementById('selectAll');
    const detailButtons = document.querySelectorAll('.view-details-btn');
    const discountAmount= document.querySelector('.discount-amount')

    //sẽ thay đổi sau
    const idCart = localStorage.getItem('id-cart');
    const idCustomer = localStorage.getItem('id-customer');
    const idUser = localStorage.getItem('id-user');

    //combobox khuyen mai
    



    // Fetch data từ API
    
    // Tạo hàm random màu
function getRandomColor() {
    const letters = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

// Bản đồ ánh xạ productId -> màu sắc
const productColors = new Map();

// Fetch data từ API
async function fetchCartDetailsForPromotion() {
    try {
        const response = await fetch(`http://localhost:8080/user/mycart/cart-detail?cartID=${idCart}`);
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const cartDetails = await response.json();
        populateComboBox(cartDetails);
    } catch (error) {
        console.error("Failed to fetch cart details:", error);
    }
}

    // Populate ComboBox với các khuyến mãi
    function populateComboBox(cartDetails) {
        const comboBox = document.getElementById('promotionComboBox');

        cartDetails.forEach(cartDetail => {
            const { productId, productName, promotion, price } = cartDetail;

            // Gán màu ngẫu nhiên cho mỗi productId nếu chưa tồn tại trong Map
            if (!productColors.has(productId)) {
                productColors.set(productId, getRandomColor());
            }

            const productColor = productColors.get(productId);

            // Thêm các khuyến mãi vào ComboBox
            promotion.forEach(promo => {
                const option = document.createElement('option');
                option.value = promo.promotionID;
                const tienGiam = (price * promo.discountPercentage) / 100;

            // Định dạng số tiền với dấu chấm ngăn cách hàng nghìn
            const formattedTienGiam = tienGiam.toLocaleString('vi-VN');
            // Cập nhật nội dung hiển thị
            option.textContent = `Giảm ${promo.discountPercentage}% cho sản phẩm ${productName} (-${formattedTienGiam} VND)`;

                option.style.color = productColor; // Áp dụng màu sắc
                option.dataset.productId = productId;
                option.dataset.price = price; // Lưu giá sản phẩm vào data attribute
                option.dataset.promotionDiscountPercentage = promo.discountPercentage;
                comboBox.appendChild(option);
            });
        });
    }

    // Gọi hàm fetch dữ liệu và cập nhật ComboBox
    fetchCartDetailsForPromotion();

// Sự kiện thay đổi của ComboBox
document.getElementById('promotionComboBox').addEventListener('change', function () {
    const selectedOption = this.selectedOptions[0]; // Lấy option được chọn
    const discountElement = document.getElementById('tong-khuyen-mai'); // Lấy phần tử hiển thị khuyến mãi

    // Nếu không chọn khuyến mãi nào (không có option nào được chọn)
    if (!selectedOption) {
        // Khi không chọn khuyến mãi, gán giá trị khuyến mãi là 0
        const discountPercentage = 0;

        // Cập nhật giá trị khuyến mãi
        discountElement.textContent = '0 VND';

        // Cập nhật tổng thanh toán với khuyến mãi = 0
        updateTotalAmount(0);
    } else {
        // Khi có khuyến mãi được chọn
        const discountPercentage = parseFloat(selectedOption.dataset.promotionDiscountPercentage) || 0; // Lấy discountPercentage
        const price = parseFloat(selectedOption.dataset.price) || 0; // Lấy giá sản phẩm từ data attribute

        // Tính toán giá trị khuyến mãi
        const discountAmount = Math.round((discountPercentage * price) / 100 * 100) / 100; //giảm sai số

        // Cập nhật giá trị khuyến mãi
        discountElement.textContent = `${discountAmount.toLocaleString('vi-VN')} VND`;

        // Cập nhật tổng thanh toán
        updateTotalAmount(discountAmount);
    }
});

// Cập nhật tổng tiền sau khi áp dụng khuyến mãi
function updateTotalAmount(discountAmount) {
    // Lấy tổng cộng, loại bỏ "VND", dấu phân cách (",") và dấu thập phân (".")
    const totalAmount = parseFloat(document.querySelector('.total-amount').textContent.replace(' VND', '').replace(/[\.,]/g, '')) || 0;

    // Tính toán tổng tiền thanh toán
    let totalPayable = totalAmount - discountAmount;

    // Đảm bảo tổng thanh toán không nhỏ hơn 0
    if (totalPayable < 0) {
        totalPayable = 0;
    }
    const totalPayableFinal=totalPayable;

    // Cập nhật tổng thanh toán
    document.getElementById('tien-phai-thanh-toan').textContent = `${totalPayableFinal.toLocaleString('vi-VN')} VND`;
}




 

    //lay dia chi
    fetch(`http://localhost:8080/user/shipping-address?customerID=${idCustomer}`, {
        method: 'GET', // Phương thức yêu cầu
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Lỗi kết nối đến API: ' + response.statusText);
        }
        return response.json();  // Chuyển dữ liệu trả về thành JSON
    })
    .then(data => {
        console.log('Danh sách địa chỉ:', data);  // Hiển thị dữ liệu trong console
        if (data && Array.isArray(data)) {
            renderAddresses(data);  // Gọi hàm renderAddresses nếu có dữ liệu
        } else {
            throw new Error('Dữ liệu không hợp lệ');
        }
    })
    .catch(error => {
        console.error('Lỗi khi tải danh sách địa chỉ:', error);
        alert('Không thể tải danh sách địa chỉ. Vui lòng thử lại sau.');
    });

    function renderAddresses(addresses) {
        const addressTable = document.getElementById('address-table'); // Lấy bảng hiển thị dữ liệu
        if (!addressTable) {
            console.error('Không tìm thấy bảng hiển thị địa chỉ với ID "address-table"');
            return;
        }
        
        const tbody = addressTable.querySelector('tbody'); // Lấy phần thân bảng
        if (!tbody) {
            console.error('Không tìm thấy thẻ <tbody> trong bảng');
            return;
        }
    
        // Xóa dữ liệu cũ trong bảng
        tbody.innerHTML = '';
    
        // Duyệt qua từng địa chỉ và tạo dòng hiển thị
        addresses.forEach(address => {
            const row = document.createElement('tr'); // Tạo dòng mới
    
            // Tạo các ô (td) cho từng trường dữ liệu
            const streetCell = document.createElement('td');
            streetCell.textContent = address.streetAddress; // Địa chỉ đường
    
            const wardCell = document.createElement('td');
            wardCell.textContent = address.ward; // Phường
    
            const districtCell = document.createElement('td');
            districtCell.textContent = address.district; // Quận/huyện
    
            const cityCell = document.createElement('td');
            cityCell.textContent = address.city; // Thành phố
    
            // Tạo ô chứa radio button
            const selectCell = document.createElement('td');
            const radioButton = document.createElement('input');
            radioButton.type = 'radio';
            radioButton.name = 'address'; // Đặt nhóm radio button giống nhau
            radioButton.value = address.addressID; // ID địa chỉ làm giá trị
            selectCell.appendChild(radioButton); // Thêm radio button vào ô
    
            // Thêm các ô vào dòng
            row.appendChild(streetCell);
            row.appendChild(wardCell);
            row.appendChild(districtCell);
            row.appendChild(cityCell);
            row.appendChild(selectCell);

            // Thêm dòng vào phần thân bảng
            tbody.appendChild(row);
        });
    }

    async function fetchProducts() {
        const apiUrl = `http://localhost:8080/user/mycart/cart-detail?cartID=${idCart}`;        
        try {
            const response = await fetch(apiUrl, {
                
            });
            if (!response.ok) throw new Error('Failed to fetch products');
            const products = await response.json();
            populateTable(products);
            updateTotal();
        } catch (error) {
            console.error('Error fetching products:', error);
        }
    }
    fetchProducts();

    // Populate table with product data
    function populateTable(products) {
        tableBody.innerHTML = ''; // Clear table
        products.forEach((product, index) => {
            const row = document.createElement('tr');
            row.classList.add('product-row'); // Thêm class 'product-row'
            row.dataset.cartDetailID = product.cartDetailID; // Lưu ID sản phẩm vào dataset
            row.dataset.productId=product.productId;
            row.innerHTML = `
        <td><input type="checkbox" class="product-checkbox"></td>
        <td>${index + 1}</td>
        <td>
            <div class="product-info">
                <img src="${product.productImage}" alt="${product.productName}" class="product-image">
                <span>${product.productName}</span>
            </div>
        </td>
        <td class="product-price" data-price="${product.price}">${product.price.toLocaleString('vi-VN')} VND</td>
        <td>
            <button class="quantity-btn decrease">-</button>
            <input type="number" value="${product.quantity}" min="1" class="quantity-input">
            <button class="quantity-btn increase">+</button>
        </td>
        <td class="item-total">${product.lineTotal.toLocaleString('vi-VN')} VND</td>
        <td>
            <button class="remove-btn" data-id="${product.cartDetailID}"> Xóa </button>
        </td>
        <td>
            <button class="view-details-btn" data-id="${product.productId}">Xem Chi Tiết</button>
        </td>
    `;

            tableBody.appendChild(row);
        });

        initializeRowEvents();
    }

            
    

    // Initialize row events
    function initializeRowEvents() {
        // Quantity input events
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('input', function () {
                // Nếu giá trị nhỏ hơn 1 hoặc không phải số, đặt lại thành 1
                if (parseInt(this.value) < 1 || isNaN(this.value) || this.value==="") {
                    this.value = 1;
                }
                updateRowTotal(this);
                updateTotal();
            });
            
        });

        // Quantity button events
        document.querySelectorAll('.quantity-btn').forEach(button => {
            button.addEventListener('click', function () {
                const input = this.parentElement.querySelector('.quantity-input');
                const currentValue = parseInt(input.value) || 0;
                input.value = this.classList.contains('increase') ? currentValue + 1 : Math.max(1, currentValue - 1);
                updateRowTotal(input);
                updateTotal();
            });
        });
        document.querySelectorAll('.remove-btn').forEach(button => {
            button.addEventListener('click', function () {
                const cartDetailID = this.getAttribute('data-id'); // Lấy cartDetailID từ thuộc tính data-id
                if (cartDetailID) {
                    removeCartDetail(cartDetailID); // Gọi hàm xóa sản phẩm
                } else {
                    console.error('Không tìm thấy cartDetailID cho nút xóa');
                }
            });
        });
        

        // Hàm xóa sản phẩm khỏi giỏ hàng
        function removeCartDetail(cartDetailID) {
            const confirmDelete = confirm('Có chắc chắn muốn xóa sản phẩm này không?');
        
            if (confirmDelete) {
                const url = `http://localhost:8080/user/mycart/remove-cartdetail?cartDetailID=${cartDetailID}`;
                fetch(url, {
                    method: 'DELETE',
                })
                .then(response => {
                    if (response.ok) {
                        return response.json().catch(() => {
                            throw new Error('Dữ liệu trả về không phải JSON');
                        });
                    } else {
                        throw new Error('Không thể xóa sản phẩm ra khỏi giỏ hàng');
                    }
                })
                .then(data => {
                    console.log(data);
                    alert('Đã xóa thành công');
                    const rowToRemove = document.querySelector(`[data-id='${cartDetailID}']`)?.closest('tr');
                    if (rowToRemove) {
                        rowToRemove.remove(); // Xóa dòng trong bảng
                    } else {
                        console.error('Không tìm thấy dòng cần xóa');
                    }
                })
                .catch(error => {
                    console.error('Lỗi:', error);
                    alert('Xóa thành công, vui lòng load lại trang');
                });
            } else {
                console.log('Hành động xóa bị hủy bỏ');
            }
        }

        // Product checkbox events
        document.querySelectorAll('.product-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', updateTotal);
        });

            // Sự kiện cho nút "Xem Chi Tiết"
        document.querySelectorAll('.view-details-btn').forEach(button => {
            button.addEventListener('click', function () {
                const productId = this.getAttribute('data-id');
                console.log(`Navigating to details for product ID: ${productId}`);
                window.location.href = `product-details.html?id=${productId}`;
            });
        });
    }
    
    
    // Update the total for a single row
    function updateRowTotal(input) {
        const row = input.closest('tr');
        const quantity = parseInt(input.value) || 0;
        const price = parseFloat(row.querySelector('.product-price').dataset.price);
        const rowTotalElement = row.querySelector('.item-total');

        const rowTotal = price * quantity;
        rowTotalElement.textContent = rowTotal.toLocaleString('vi-VN') + ' VNĐ';
    }

    // Update total price and amount
    function updateTotal() {
        let total = 0;
    
        document.querySelectorAll('#product-list tr').forEach(row => {
            const checkbox = row.querySelector('.product-checkbox');
            const quantityInput = row.querySelector('.quantity-input');
            const priceElement = row.querySelector('.product-price');
    
            if (checkbox && checkbox.checked) {
                const price = parseFloat(priceElement.dataset.price) || 0; // Giá từ `data-price`
                const quantity = parseInt(quantityInput.value) || 0; // Số lượng
                total += price * quantity;
            }
        });
    
        // Chuyển `Khuyến Mãi` sang số
        const discount = parseCurrency(discountAmount.textContent);
    
        // Tính toán
        const finalTotalPrice = total - discount;
        if(finalTotalPrice<0){
            totalPriceElement.textContent = formatCurrency(0);
        }
        // Cập nhật giao diện
        else totalPriceElement.textContent = formatCurrency(finalTotalPrice);
        totalElement.textContent = formatCurrency(total);
    }
    
    // Chuyển chuỗi tiền tệ thành số
    function parseCurrency(currencyString) {
        return parseFloat(currencyString.replace(/[^0-9,-]+/g, '').replace(',', '.'));
    }
    
    // Định dạng số thành tiền tệ
    function formatCurrency(value) {
        return value.toLocaleString('vi-VN') + ' VND';
    }

    // Select all checkboxes
    selectAllCB.addEventListener('change', function () {
        const checkboxes = document.querySelectorAll('.product-checkbox');
        checkboxes.forEach(checkbox => (checkbox.checked = this.checked));
        updateTotal();
    });

});
