async function deleteSelectedProducts() {
  const checkboxes = document.querySelectorAll('.product-checkbox:checked'); // Lấy tất cả các checkbox được chọn
  const selectedProductIds = Array.from(checkboxes).map(checkbox => checkbox.value); // Lấy giá trị ID sản phẩm

  if (selectedProductIds.length === 0) {
    alert('Vui lòng chọn ít nhất một sản phẩm để xóa.');
    return;
  }

  try {
    // Gửi API xóa nhiều sản phẩm
    const response = await fetch(`http://localhost:8080/admin/product/${selectedProductIds.join(',')}`, {
      method: 'DELETE',
    });

    // Kiểm tra nếu phản hồi hợp lệ
    if (!response.ok) {
      throw new Error('Failed to delete selected products');
    }

    alert('Các sản phẩm đã được xóa thành công!');
    fetchProductData(); // Cập nhật danh sách sản phẩm sau khi xóa
  } catch (error) {
    console.error('Error deleting selected products:', error);
    alert('Xóa các sản phẩm thất bại!');
  }
}
