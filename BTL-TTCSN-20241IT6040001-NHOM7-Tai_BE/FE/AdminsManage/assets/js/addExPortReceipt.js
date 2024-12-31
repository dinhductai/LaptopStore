document.getElementById('exportForm').addEventListener('submit', async function(event) {
    event.preventDefault(); 
    const urlParams = new URLSearchParams(window.location.search);
    const productId = document.getElementById('exportSelectedProduct').getAttribute('data-idProduct');
    const quantity = document.getElementById('exportQuantity').value;
    const adminId = 3;  
    const warehouseId = urlParams.get('warehouseID');

    if (!productId || !quantity) {
        alert("Vui lòng chọn sản phẩm và nhập số lượng!");
        return;
    }

    const exportData = {
        adminId: adminId,
        productId: productId,
        warehouseId: warehouseId,
        quantity: quantity
    };

    try {
        const response = await fetch('http://localhost:8080/admin/warehouse/export-receipt', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(exportData)
        });
        const result = await response.text(); 
        console.log(result)
        if (response.ok) {
            alert('Phiếu xuất kho đã được thêm thành công!');
            console.log('Phiếu xuất kho đã được thêm:', result);
            window.location.reload(); 
        } else {
            if (result === "An error occurred: Requested quantity exceeds available stock") {
                alert('Không thể xuất kho, số lượng xuất lớn hơn số lượng kho đang có');
                window.location.reload();
            } else {
                alert('Đã có lỗi xảy ra khi thêm phiếu xuất');
              
            }
        }
    } catch (error) {
        console.error('Lỗi:', error);
        alert('Có lỗi xảy ra, vui lòng thử lại!');
    }
});
