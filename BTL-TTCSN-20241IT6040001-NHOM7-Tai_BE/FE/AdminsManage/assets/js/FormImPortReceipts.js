// Form nhập sản phẩm
const btnImportProduct = document.getElementById('btnImportProduct');
const importFormModal = document.getElementById('importFormModal');
const closeImportModal = document.getElementById('closeImportModal');
const importProductDropdownButton = document.getElementById('importProductDropdownButton');
const importProductSelectModal = document.getElementById('importProductSelectModal');
const closeImportProductModal = document.getElementById('closeImportProductModal');
const importProductListSelect = document.getElementById('importProductListSelect');
const importSelectedProduct = document.getElementById('importSelectedProduct');

// Hiển thị modal nhập sản phẩm
btnImportProduct.addEventListener('click', () => {
    importFormModal.style.display = 'block';
});

// Đóng modal nhập sản phẩm
closeImportModal.addEventListener('click', () => {
    importFormModal.style.display = 'none';
});

// Hiển thị modal chọn sản phẩm cho nhập
importProductDropdownButton.addEventListener('click', () => {
    importProductSelectModal.style.display = 'block';
    getProducts(); // Gọi API tải danh sách sản phẩm
});

// Đóng modal chọn sản phẩm cho nhập
closeImportProductModal.addEventListener('click', () => {
    importProductSelectModal.style.display = 'none';
});

// Hàm gọi API để tải danh sách sản phẩm (nhập)
async function getProducts() {
    try {
        const response = await fetch('http://localhost:8080/admin/warehouse/allproduct');
        const products = await response.json();

        importProductListSelect.innerHTML = '';

        products.forEach(product => {
            const li = document.createElement('li');
            li.classList.add('product-item');

            // Tạo hình ảnh sản phẩm
            const img = document.createElement('img');
            img.src = product.productImage;
            img.alt = product.productName;
            img.style.width = '50px';
            img.style.height = 'auto';

            // Tạo tên sản phẩm
            const span = document.createElement('span');
            span.textContent = product.productName;

            li.appendChild(img);
            li.appendChild(span);

            li.addEventListener('click', function () {
                importSelectedProduct.value = product.productName;
                importSelectedProduct.setAttribute('data-idProduct', product.productId);
                importProductSelectModal.style.display = 'none';
            });

            importProductListSelect.appendChild(li);
        });
    } catch (error) {
        console.error('Có lỗi xảy ra khi lấy sản phẩm:', error);
    }
}

// Đóng modal khi nhấp ngoài modal (nhập)
window.addEventListener('click', (event) => {
    if (event.target === importFormModal) {
        importFormModal.style.display = 'none';
    }
    if (event.target === importProductSelectModal) {
        importProductSelectModal.style.display = 'none';
    }
});
