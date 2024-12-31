
const importForm = document.getElementById('importForm');
const selectedProductInput = document.getElementById('importSelectedProduct');

const importReceiptUrl = 'http://localhost:8080/admin/warehouse/import-receipt';

importForm.addEventListener('submit', function (event) {
  event.preventDefault(); 
  const urlParams = new URLSearchParams(window.location.search);
  const adminId = 3; 
  const productId = selectedProductInput.getAttribute('data-idProduct');
  const warehouseId = urlParams.get('warehouseID');
  const productBatchCode = document.getElementById('importBatchCode').value;
  const dimension = document.getElementById('importdimension').value;
  const volume = parseFloat(document.getElementById('importvolume').value);
  const minStock = parseInt(document.getElementById('importminStock').value);
  const maxStock = parseInt(document.getElementById('importmaxStock').value);
  const quantity = parseInt(document.getElementById('importQuantity').value);

  
  if (!adminId || !productId || !warehouseId || !productBatchCode || !dimension || isNaN(volume) || isNaN(minStock) || isNaN(maxStock) || isNaN(quantity)) {
    alert('Vui lòng điền đầy đủ thông tin.');
    return;
  }

  const importData = {
    adminId: parseInt(adminId),
    productId: parseInt(productId),
    warehouseId: parseInt(warehouseId),
    productBatchCode: productBatchCode,
    dimension: dimension,
    volume: volume,
    minStock: minStock,
    maxStock: maxStock,
    quantity: quantity
  };

  addImportReceipt(importData);
});
async function addImportReceipt(data) {
  try {
    const response = await fetch(importReceiptUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });

    // Kiểm tra phản hồi từ API
    if (response.ok) {
      const result = await response.text();
      alert('Phiếu nhập đã được thêm thành công!');
      console.log('Phiếu nhập đã được thêm:', result);
      location.reload();
    } else {
      throw new Error('Đã có lỗi xảy ra khi thêm phiếu nhập');
    }
  } catch (error) {
    console.error('Lỗi:', error);
    alert('Có lỗi xảy ra, vui lòng thử lại!');
  }
}

