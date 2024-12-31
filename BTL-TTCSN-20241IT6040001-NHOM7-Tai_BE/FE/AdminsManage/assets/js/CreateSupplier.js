
// Lấy các phần tử HTML
const modal = document.getElementById('supplier-modal');
const openModalBtn = document.getElementById('open-modal');
const closeModalBtn = document.getElementById('close-modal');
const form = document.getElementById('supplier-form');
const tableBody = document.getElementById('supplier-list');

// Hiển thị modal khi nhấn nút
openModalBtn.addEventListener('click', () => {
  modal.style.display = 'flex';
});

// Đóng modal khi nhấn nút "X"
closeModalBtn.addEventListener('click', () => {
  modal.style.display = 'none';
});

// Đóng modal khi click ra ngoài nội dung
modal.addEventListener('click', (event) => {
  if (event.target === modal) {
    modal.style.display = 'none';
  }
});

// Hàm tải lại danh sách supplier
async function fetchAndRenderSuppliers() {
  try {
    const response = await fetch('http://localhost:8080/admin/supplier/');
    if (response.ok) {
      const suppliers = await response.json();
      
      // Xóa nội dung cũ trong bảng
      tableBody.innerHTML = '';

      // Thêm từng supplier vào bảng
      suppliers.forEach((supplier) => {
        const newRow = document.createElement('tr');
        newRow.innerHTML = `
          <td>${supplier.supplierID}</td>
          <td>${supplier.supplierName}</td>
          <td>${supplier.email}</td>
          <td>${supplier.phoneNumber}</td>
          <td>${supplier.address}</td>
          <td>${supplier.taxcode}</td>
          <td>${supplier.website}</td>
          <td>${new Date(supplier.partnershipStartDate).toLocaleDateString()}</td>
        `;
        tableBody.appendChild(newRow);
      });
    } else {
      alert('Không thể tải danh sách nhà cung cấp. Vui lòng thử lại.');
    }
  } catch (error) {
    console.error('Error fetching suppliers:', error);
    alert('Có lỗi xảy ra khi tải danh sách nhà cung cấp.');
  }
}

// Xử lý form submit
form.addEventListener('submit', async (event) => {
  event.preventDefault(); // Ngăn reload trang

  // Lấy dữ liệu từ form
  const formData = {
    // supplierID: document.getElementById('supplierID').value, 
    supplierName: document.getElementById('supplierName').value,
    address: document.getElementById('address').value,
    phoneNumber: document.getElementById('phoneNumber').value,
    email: document.getElementById('email').value,
    taxCode: document.getElementById('taxCode').value,
    website: document.getElementById('website').value,
    representative: document.getElementById('representative').value,
    partnershipStartDate: document.getElementById('partnershipStartDate').value,
    status: document.getElementById('status').value,
  };

  try {
    // Gửi dữ liệu tới API bằng phương thức POST
    const response = await fetch('http://localhost:8080/admin/supplier/create', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formData),
    });

    if (response.ok) {
      alert('Nhà cung cấp đã được thêm thành công!');

      // Sau khi nhấn OK, tải lại danh sách supplier
      fetchAndRenderSuppliers();

      modal.style.display = 'none'; // Đóng modal
      form.reset(); // Reset form
    } else {
      alert('Thêm nhà cung cấp thất bại. Vui lòng kiểm tra lại.');
    }
  } catch (error) {
    console.error('Error:', error);
    alert('Có lỗi xảy ra.');
  }
});

// Tải danh sách supplier khi trang được load
fetchAndRenderSuppliers();

