// Các phần tử HTML
const editModeBtn = document.getElementById('toggle-edit-mode');
const supplierTableUpdate = document.getElementById('supplier-list');
let   editModeActive = false; // Biến theo dõi trạng thái chế độ sửa

// Thêm hoặc gỡ cột "Sửa" khi nhấn nút "Sửa nhà cung cấp"
editModeBtn.addEventListener('click', () => {
  editModeActive = !editModeActive;
  if (editModeActive) {
    enableEditMode(); // Thêm cột "Sửa"
    editModeBtn.innerText = "Thoát sửa";
  } else {
    disableEditMode(); // Gỡ cột "Sửa"
    editModeBtn.innerText = "Sửa nhà cung cấp";
  }
});

// Thêm cột "Sửa"
function enableEditMode() {
  const rows = supplierTableUpdate.querySelectorAll('tr');
  rows.forEach((row) => {
    const editCell = document.createElement('td');
    const editButton = document.createElement('button');
    editButton.className = "btn btn-primary btn-sm";
    editButton.innerText = "Sửa";
    editButton.addEventListener('click', () => fetchAndOpenEditForm(row)); // Gắn sự kiện mở form sửa
    editCell.appendChild(editButton);
    row.appendChild(editCell); // Thêm ô "Sửa" vào dòng
  });
}

// Gỡ cột "Sửa"
function disableEditMode() {
  const rows = supplierTableUpdate.querySelectorAll('tr');
  rows.forEach((row) => {
    if (row.lastChild.querySelector('button')) {
      row.removeChild(row.lastChild); // Xóa ô cuối cùng
    }
  });
}

// Lấy thông tin nhà cung cấp bằng API GET và mở form sửa
async function fetchAndOpenEditForm(row) {
  const cells = row.querySelectorAll('td');
  const supplierID = cells[0].innerText;

  try {
    // Gọi API GET để lấy thông tin nhà cung cấp
    const response = await fetch(`http://localhost:8080/admin/supplier/update/${supplierID}`);
    if (!response.ok) throw new Error('Không thể lấy thông tin nhà cung cấp.');

    const supplier = await response.json();

    // Điền thông tin vào form
    document.getElementById('edit-supplier-id').value = supplier.supplierID; // ID
    document.getElementById('edit-supplier-name').value = supplier.supplierName; // Tên
    document.getElementById('edit-address').value = supplier.address; // Địa chỉ
    document.getElementById('edit-phone-number').value = supplier.phoneNumber; // Số điện thoại
    document.getElementById('edit-email').value = supplier.email; // Email
    document.getElementById('edit-taxcode').value = supplier.taxCode; // Taxcode
    document.getElementById('edit-website').value = supplier.website; // Website
    document.getElementById('edit-representative').value = supplier.representative; // Representative
    document.getElementById('edit-partnership-date').value = supplier.partnershipStartDate.split('T')[0]; // Date
    document.getElementById('edit-status').value = supplier.status; // Trạng thái

    // Hiển thị modal
    document.getElementById('edit-form-modal').style.display = 'block';
  } catch (error) {
    console.error('Lỗi khi lấy thông tin nhà cung cấp:', error);
    alert('Có lỗi xảy ra khi lấy thông tin nhà cung cấp.');
  }
}

// Đóng form sửa thông tin
document.getElementById('cancel-edit').addEventListener('click', () => {
  document.getElementById('edit-form-modal').style.display = 'none';
});

// Cập nhật thông tin nhà cung cấp bằng API PUT
document.getElementById('edit-supplier-form').addEventListener('submit', async (e) => {
  e.preventDefault();
  const row = e.target.closest('tr'); // Lấy dòng cha của form
  const supplierID = document.getElementById('edit-supplier-id').value;
  const updatedData = {
    supplierId: document.getElementById('edit-supplier-id').value,
    supplierName: document.getElementById('edit-supplier-name').value,
    address: document.getElementById('edit-address').value,
    phoneNumber: document.getElementById('edit-phone-number').value,
    email: document.getElementById('edit-email').value,
    taxCode: document.getElementById('edit-taxcode').value,
    website: document.getElementById('edit-website').value,
    representative: document.getElementById('edit-representative').value,
    partnershipStartDate: document.getElementById('edit-partnership-date').value,
    status: document.getElementById('edit-status').value,
  };

  try {
    const response = await fetch(`http://localhost:8080/admin/supplier/update/${supplierID}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(updatedData),
    });

    if (response.ok) {
      alert('Cập nhật thành công!');
      document.getElementById('edit-form-modal').style.display = 'none';

      // Cập nhật dữ liệu trong bảng
      const cells = row.querySelectorAll('td');

      // Ánh xạ dữ liệu từ `updatedData` vào các ô tương ứng
      cells[0].innerText = updatedData.supplierId; // ID Nhà Cung Cấp
      cells[1].innerText = updatedData.supplierName; // Tên Nhà Cung Cấp
      cells[2].innerText = updatedData.email; // Email
      cells[3].innerText = updatedData.phoneNumber; // Số Điện Thoại
      cells[4].innerText = updatedData.address; // Địa Chỉ
      cells[5].innerText = updatedData.taxCode; // Taxcode
      cells[6].innerText = updatedData.website; // Website
      cells[7].innerText = updatedData.partnershipStartDate; // PartnershipStartDate

    } else {
      const error = await response.json();
      alert('Cập nhật thất bại: ' + (error.message || 'Lỗi không xác định'));
    }
  } catch (error) {
    // console.error('Lỗi khi cập nhật nhà cung cấp:', error);
    // alert('Có lỗi xảy ra.');
    window.location.reload() ;
  }
}); 