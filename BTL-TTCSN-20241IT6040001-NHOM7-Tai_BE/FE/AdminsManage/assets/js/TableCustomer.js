// API URL để lấy dữ liệu
const apiUrl = 'http://localhost:8080/admin/customer/';

// Lấy các phần tử DOM cần thiết
const customerListDiv = document.getElementById('customer-list');
const top10CustomersList = document.getElementById('top-10-customers-list');
const monthlyNewCustomersChart = document.getElementById('monthly-new-customers-chart');


document.getElementById("add-customer-btn").addEventListener("click", function() {
  const modal = new bootstrap.Modal(document.getElementById("addCustomerModal"));
  modal.show();
});

// Hàm để lấy dữ liệu từ API
async function fetchCustomerData() {
  try {
    const response = await fetch(apiUrl);
    
    // Kiểm tra nếu phản hồi hợp lệ
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }

    // Lấy dữ liệu JSON từ phản hồi
    const data = await response.json();

    // Hiển thị danh sách khách hàng
    displayCustomerList(data.listCustomer);

    // Hiển thị top 10 khách hàng chi tiêu nhiều nhất
    displayTop10Customers(data.findTopCustomerInMonth);

    // Hiển thị biểu đồ khách hàng mới theo tháng
    displayMonthlyCustomerChart(data.countNewCustomerPerMonth);

  } catch (error) {
    console.error('Error fetching data:', error);
  }
}

// Hàm hiển thị danh sách khách hàng
function displayCustomerList(customers) {
  let customerHTML = '';
  customers.forEach((customer, index) => {
    customerHTML += `
      <tr>
        <td>${index + 1}</td>
        <td>${customer.fullName}</td>
        <td>${customer.email}</td>
        <td>
          <!-- Nút Sửa -->
          <button class="btn btn-primary btn-sm" onclick="editCustomer(${customer.customerID})">Sửa</button>
          <!-- Nút Xóa -->
          <button class="btn btn-danger btn-sm" onclick="deleteCustomer(${customer.customerID})">Xóa</button>
        </td>
      </tr>
    `;
  });
  customerListDiv.innerHTML = customerHTML;
}

// Hàm xóa khách hàng
async function deleteCustomer(customerId) {
  if (confirm('Bạn có chắc chắn muốn xóa khách hàng này?')) {
    try {
      const response = await fetch(`http://localhost:8080/admin/customer/${customerId}`, {
        method: 'DELETE', // Phương thức DELETE để xóa khách hàng
      });

      // Kiểm tra nếu phản hồi hợp lệ
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      // Sau khi xóa thành công, gọi lại fetchCustomerData để làm mới danh sách
      fetchCustomerData();
      alert('Khách hàng đã được xóa thành công!');
    } catch (error) {
      console.error('Error deleting customer:', error);
      alert('Có lỗi xảy ra khi xóa khách hàng.');
    }
  }
}

// Hàm hiển thị top 10 khách hàng chi tiêu nhiều nhất
function displayTop10Customers(customers) {
  // Sắp xếp khách hàng theo tổng chi tiêu giảm dần
  const top10 = customers.sort((a, b) => b.totalAmount - a.totalAmount).slice(0, 10);

  let top10HTML = '';
  top10.forEach((customer, index) => {
    top10HTML += `
      <tr>
        <td>${index + 1}</td>  <!-- STT -->
        <td>${customer.fullName}</td>
        <td>${customer.totalAmount.toLocaleString('vi-VN') + ' VNĐ'}</td>
      </tr>
    `;
  });

  // Cập nhật phần thân bảng với dữ liệu mới
  document.getElementById('top-10-customers-list').innerHTML = top10HTML;
}


// Hàm hiển thị biểu đồ khách hàng mới theo tháng
function displayMonthlyCustomerChart(monthlyCounts) {
  const months = monthlyCounts.map(count => count.month);
  const customerCounts = monthlyCounts.map(count => count.customerCount);

  const chartData = {
    labels: months,
    datasets: [{
      label: 'New Customers Per Month',
      data: customerCounts,
      borderColor: 'rgb(75, 192, 192)',
      backgroundColor: 'rgba(75, 192, 192, 0.2)',
      fill: true,
    }]
  };

  const chartOptions = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      tooltip: {
        callbacks: {
          label: function (context) {
            return `${context.dataset.label}: ${context.raw}`;
          }
        }
      }
    }
  };

  // Vẽ biểu đồ sử dụng Chart.js
  new Chart(monthlyNewCustomersChart, {
    type: 'line',
    data: chartData,
    options: chartOptions
  });
}

// Gọi hàm fetchCustomerData khi trang được tải
fetchCustomerData();

// Lấy phần tử DOM của form và nút Lưu
const customerForm = document.getElementById('customerForm');
const saveCustomerBtn = document.getElementById('save-customer-btn');

// Thêm sự kiện submit cho form
customerForm.addEventListener('submit', async function (event) {
  event.preventDefault(); // Ngăn chặn hành vi mặc định (reload trang)

  // Lấy dữ liệu từ form
  const newCustomer = {
    totalAmount: 0,
    userID: parseInt(document.getElementById('userID').value),
    customerID: parseInt(document.getElementById('customerID').value),
    addressID: parseInt(document.getElementById('addressID').value),
    fullName: document.getElementById('fullName').value,
    email: document.getElementById('email').value,
    passWord: document.getElementById('passWord').value,
    phoneNumber: document.getElementById('phoneNumber').value,
    registrationDate: new Date().toISOString(),
    address: null,
    city: null,
    district: null,
    ward: null,
    streetAddress: null
  };

  try {
    // Gửi yêu cầu POST tới API
    const response = await fetch('http://localhost:8080/admin/customer/create-customer/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(newCustomer)
    });

    if (!response.ok) {
      throw new Error('Network response was not ok');
    }

    // Nếu tạo khách hàng thành công, làm mới danh sách và ẩn modal
    alert('Khách hàng đã được thêm thành công!');
    fetchCustomerData(); // Làm mới danh sách khách hàng
    
    const addCustomerModal = bootstrap.Modal.getInstance(document.getElementById('addCustomerModal'));
    addCustomerModal.hide(); // Đóng modal

    // Reset form sau khi thêm thành công
    customerForm.reset();
  } catch (error) {
    console.error('Error creating customer:', error);
    alert('Có lỗi xảy ra khi thêm khách hàng.');
  }
});

// Hàm gọi API để lấy thông tin khách hàng
function editCustomer(customerID) {
  fetch(`http://localhost:8080/admin/customer/update/${customerID}`, {
      method: 'GET', // Lấy dữ liệu từ API
      headers: {
          'Content-Type': 'application/json',
      }
  })
  .then(response => response.json())
  .then(data => {
      // Điền thông tin vào các trường trong modal
      document.getElementById('editUserID').value = data.userID;
      document.getElementById('editCustomerID').value = data.customerID;
     
      document.getElementById('editFullName').value = data.fullName;
      document.getElementById('editEmail').value = data.email;
      document.getElementById('editPassword').value = data.passWord;
      document.getElementById('editPhoneNumber').value = data.phoneNumber;
      document.getElementById('editRegistrationDate').value = data.registrationDate;
    
      
      // Hiển thị modal
      const editModal = new bootstrap.Modal(document.getElementById('editCustomerModal'));
      editModal.show();
  })
  .catch(error => {
      console.error('Error fetching customer data:', error);
  });


// Hàm gửi yêu cầu PUT để cập nhật thông tin khách hàng
// Hàm gửi yêu cầu PUT để cập nhật thông tin khách hàng
document.getElementById('editCustomerForm').addEventListener('submit', function(event) {
  event.preventDefault();


  const updatedCustomerData = {
      totalAmount: 0,  // Cập nhật giá trị
      userID: parseInt(document.getElementById('editUserID').value) ,  // Giữ nguyên userID
      customerID: parseInt(document.getElementById('editCustomerID').value),  // Giữ nguyên customerID
      addressID: 1,  // Giữ nguyên addressID
      fullName: document.getElementById('editFullName').value,  // Cập nhật giá trị
      email: document.getElementById('editEmail').value,  // Cập nhật giá trị
      passWord: document.getElementById('editPassword').value,  // Cập nhật giá trị
      phoneNumber: document.getElementById('editPhoneNumber').value,  // Cập nhật giá trị
      registrationDate:new Date().toISOString() ,  // Cập nhật giá trị
      address: null,  
      city: null,  // Cập nhật giá trị
      district: null,  // Cập nhật giá trị
      ward: null,  // Cập nhật giá trị
      streetAddress: null  // Cập nhật giá trị
  };

  // Log the data being sent to check the object
  console.log("Updated Customer Data:", updatedCustomerData);

  // Gửi yêu cầu PUT để cập nhật dữ liệu khách hàng
  fetch(`http://localhost:8080/admin/customer/update/${customerID}`, {
    method: 'PUT',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(updatedCustomerData) // Dữ liệu gửi đi
})
.then(response => {
  return response.text(); // Thay vì response.json()
})
.then(data => {
  console.log('Server Response:', data); // Log dữ liệu từ server
  if (data === "success") {
      const editModal = new bootstrap.Modal(document.getElementById('editCustomerModal'));
      editModal.hide(); // Đóng modal
      alert('Cập nhật thành công!');
      location.reload(); // Reload trang
  } else {
      throw new Error('Update failed! Unexpected server response.');
  }
})
.catch(error => {
  console.error('Error:', error);
  alert('Có lỗi xảy ra trong quá trình cập nhật!');
});
});

}