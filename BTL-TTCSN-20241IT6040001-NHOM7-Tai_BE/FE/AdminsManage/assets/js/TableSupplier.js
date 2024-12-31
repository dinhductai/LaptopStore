// Hàm lấy dữ liệu từ API
async function fetchSuppliers() {
    try {
      const response = await fetch('http://localhost:8080/admin/supplier/');
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      // Chuyển đổi dữ liệu JSON
      const suppliers = await response.json();

      // Gọi hàm hiển thị dữ liệu
      displaySuppliers(suppliers);

    } catch (error) {
      console.error('Error fetching supplier data:', error);
    }
  }

// Hàm hiển thị dữ liệu ra bảng
function displaySuppliers(suppliers) {
    const tableBody = document.querySelector('#supplier-list');

    suppliers.forEach(supplier => {
      const row = document.createElement('tr');
      row.innerHTML = `
        <td>${supplier.supplierID}</td>
        <td>${supplier.supplierName}</td>
        <td>${supplier.email}</td>
        <td>${supplier.phoneNumber}</td>
        <td>${supplier.address}</td>
        <td>${supplier.taxCode}</td>
        <td>${supplier.website}</td>
        <td>${new Date(supplier.partnershipStartDate).toLocaleDateString()}</td>
      `;
      tableBody.appendChild(row);
    });
}

// Gọi hàm fetchSuppliers khi tải trang
fetchSuppliers();

