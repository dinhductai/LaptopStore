// Form xuất sản phẩm
const btnExportProduct = document.getElementById('btnExportProduct');
const exportFormModal = document.getElementById('exportFormModal');
const closeExportModal = document.getElementById('closeExportModal');
const exportProductDropdownButton = document.getElementById('exportProductDropdownButton');
const exportProductSelectModal = document.getElementById('exportProductSelectModal');
const closeExportProductModal = document.getElementById('closeExportProductModal');
const exportProductListSelect = document.getElementById('exportProductListSelect');
const exportSelectedProduct = document.getElementById('exportSelectedProduct');
const exportForm = document.getElementById('exportForm');
const exportList = document.getElementById('exportList');


btnExportProduct.addEventListener('click', () => {
    exportFormModal.style.display = 'block';
});


closeExportModal.addEventListener('click', () => {
    exportFormModal.style.display = 'none';
});


exportProductDropdownButton.addEventListener('click', () => {
    exportProductSelectModal.style.display = 'block';
    loadExportProductList(); 
});


closeExportProductModal.addEventListener('click', () => {
    exportProductSelectModal.style.display = 'none';
});

exportProductListSelect.addEventListener('click', (event) => {
    if (event.target.tagName === 'LI') {
        const productId = event.target.getAttribute('data-id');
        const productName = event.target.textContent;
        exportSelectedProduct.value = productName;
        exportSelectedProduct.setAttribute('data-idProduct', productId);
        exportProductSelectModal.style.display = 'none';
    }
});

// Xử lý khi nộp form xuất sản phẩm
exportForm.addEventListener('submit', (event) => {
    event.preventDefault();

    const productName = exportSelectedProduct.value;
    const productId = exportSelectedProduct.getAttribute('data-idProduct');
    const quantity = document.getElementById('exportQuantity').value;

    if (!productName || !productId || !quantity) {
        alert('Vui lòng chọn sản phẩm và nhập số lượng hợp lệ!');
        return;
    }

    const listItem = document.createElement('li');
    listItem.className = 'list-group-item';
    listItem.textContent = `Sản phẩm: ${productName} - Số lượng: ${quantity}`;

    exportList.appendChild(listItem);

    exportFormModal.style.display = 'none';
    exportForm.reset();
    exportSelectedProduct.removeAttribute('data-idProduct');
});

function loadExportProductList() {
    const urlParams = new URLSearchParams(window.location.search);
    const idWarehouse = urlParams.get('warehouseID');
    
    const apiLoadExportProduct = `http://localhost:8080/admin/warehouse/${idWarehouse}`;
    
    fetch(apiLoadExportProduct)
        .then(response => response.json())
        .then(data => {
            const products = data.listProductsInWarehouse;
            const exportProductListSelect = document.getElementById('exportProductListSelect');
            exportProductListSelect.innerHTML = '';  

            products.forEach(product => {
                const listItem = document.createElement('li');
                listItem.innerHTML = `
                    <img src="${product.productImage || 'default-image.jpg'}" alt="${product.productName}" width="50" height="50">
                    <span>${product.productName}</span>
                `;
                listItem.setAttribute('data-id', product.productId);
                listItem.style.cursor = 'pointer';

                exportProductListSelect.appendChild(listItem);

                listItem.addEventListener('click', () => {
                    exportSelectedProduct.value = product.productName;
                    exportSelectedProduct.setAttribute('data-idProduct', product.productId);
                    exportProductSelectModal.style.display = 'none';
                });
            });
        })
        .catch(error => {
            console.error('Error fetching product list:', error);
        });
}

window.addEventListener('click', (event) => {
    if (event.target === exportFormModal) {
        exportFormModal.style.display = 'none';
    }
    if (event.target === exportProductSelectModal) {
        exportProductSelectModal.style.display = 'none';
    }
});