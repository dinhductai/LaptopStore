// Các phần tử HTML
const deleteModeBtn = document.getElementById('delete-mode-btn');
const deleteSelectedBtn = document.getElementById('delete-selected-btn');
const supplierTableDelete = document.getElementById('supplier-list');

// Biến trạng thái để kiểm tra chế độ xóa
let isDeleteMode = false;

// Thêm cột checkbox khi ấn vào "Xóa nhà cung cấp"
deleteModeBtn.addEventListener('click', () => {
  isDeleteMode = !isDeleteMode;

  if (isDeleteMode) {
    deleteModeBtn.textContent = 'Hủy chế độ xóa';
    deleteSelectedBtn.style.display = 'inline-block';

    // Thêm cột checkbox vào mỗi dòng
    const rows = supplierTableDelete.querySelectorAll('tr');
    rows.forEach((row) => {
      const checkboxCell = document.createElement('td');
      checkboxCell.innerHTML = '<input type="checkbox" class="delete-checkbox">';
      row.appendChild(checkboxCell);
    });
  } else {
    deleteModeBtn.textContent = 'Xóa nhà cung cấp';
    deleteSelectedBtn.style.display = 'none';

    // Xóa cột checkbox
    const rows = supplierTableDelete.querySelectorAll('tr');
    rows.forEach((row) => {
      const lastCell = row.lastElementChild;
      if (lastCell.querySelector('.delete-checkbox')) {
        lastCell.remove();
      }
    });
  }
});

// Xử lý "Xóa các nhà cung cấp đã chọn"
deleteSelectedBtn.addEventListener('click', async () => {
  // Lấy danh sách các nhà cung cấp được chọn
  const selectedCheckboxes = document.querySelectorAll('.delete-checkbox:checked');
  const supplierIDsToDelete = Array.from(selectedCheckboxes).map((checkbox) =>
    checkbox.closest('tr').cells[0].innerText // Lấy ID từ cột đầu tiên
  );

  if (supplierIDsToDelete.length === 0) {
    alert('Vui lòng chọn ít nhất một nhà cung cấp để xóa.');
    return;
  }

  const confirmDelete = confirm(`Bạn có chắc chắn muốn xóa ${supplierIDsToDelete.length} nhà cung cấp?`);
  if (confirmDelete) {
    try {
      // Gửi yêu cầu DELETE với danh sách ID
      const ids = supplierIDsToDelete.join(',');
      const response = await fetch(`http://localhost:8080/admin/supplier/${ids}`, {
        method: 'DELETE',
      });

      if (response.ok) {
        alert('Xóa thành công các nhà cung cấp đã chọn!');

        // Xóa các dòng đã chọn khỏi bảng
        selectedCheckboxes.forEach((checkbox) => {
          const row = checkbox.closest('tr');
          row.remove();
        });
      } else {
        alert('Xóa nhà cung cấp thất bại. Vui lòng thử lại.');
      }
    } catch (error) {
      console.error('Error deleting suppliers:', error);
      alert('Có lỗi xảy ra khi xóa các nhà cung cấp.');
    }
  }
});
