async function loadDashboardData() {
  try {
    const response = await fetch("http://localhost:8080/admin/dashboard/");
    const data = await response.json();

    // Cập nhật số liệu tổng quan
    document.getElementById("quantity-sell-product-current-month").innerText =
      data.quantitySellProductCurrentMonth;
    document.getElementById("total-customer-in-current-month").innerText =
      data.totalCustomerInCurrentMonth;
    document.getElementById("total-new-customer-in-current-month").innerText =
      data.totalNewCustomerInCurrentMonth;
    document.getElementById(
      "total-amount-in-current-month"
    ).innerText = `${data.totalAmountInCurrentMonth.toLocaleString()} VND`;

    // Dữ liệu cho biểu đồ khách hàng mới
    const newCustomerLabels = data.newCustomerPerMonthMap.map(
      (item) => ` ${item.month}`
    );
    const newCustomerData = data.newCustomerPerMonthMap.map(
      (item) => item.customerCount
    );

    const ctx1 = document
      .getElementById("new-customers-chart")
      .getContext("2d");
    new Chart(ctx1, {
      type: "line", // Chọn kiểu biểu đồ đường đi
      data: {
        labels: newCustomerLabels, // Tháng
        datasets: [
          {
            label: "Khách hàng mới",
            data: newCustomerData, // Số lượng khách hàng mới
            borderColor: "rgba(75, 192, 192, 1)", // Màu đường
            fill: false, // Không tô màu dưới đường
            tension: 0.1, // Làm mượt đường nối giữa các điểm
            borderWidth: 2, // Độ dày đường
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: "top",
          },
          tooltip: {
            callbacks: {
              label: function (tooltipItem) {
                return `${tooltipItem.raw} khách hàng`; // Hiển thị số khách hàng
              },
            },
          },
        },
        scales: {
          x: {
            title: {
              display: true,
              text: "Tháng",
            },
          },
          y: {
            title: {
              display: true,
              text: "Số lượng khách hàng",
            },
            beginAtZero: true,
          },
        },
      },
    });

    // Dữ liệu cho biểu đồ doanh thu (biểu đồ đường thay vì cột)
    const revenueLabels = data.totalAmountPerMonthMap.map(
      (item) => ` ${item.month}`
    );
    const revenueData = data.totalAmountPerMonthMap.map(
      (item) => item.totalAmount
    );

    const ctx2 = document.getElementById("revenue-chart").getContext("2d");
    new Chart(ctx2, {
      type: "line", // Đổi thành biểu đồ đường
      data: {
        labels: revenueLabels,
        datasets: [
          {
            label: "Doanh thu (VND)",
            data: revenueData,
            borderColor: "rgba(54, 162, 235, 1)", // Màu đường cho doanh thu
            fill: false, // Không tô màu dưới đường
            tension: 0.1, // Làm mượt đường nối
            borderWidth: 2,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: "top",
          },
          tooltip: {
            callbacks: {
              label: function (tooltipItem) {
                return `${tooltipItem.raw.toLocaleString()} VND`; // Hiển thị doanh thu
              },
            },
          },
        },
        scales: {
          x: {
            title: {
              display: true,
              text: "Tháng",
            },
          },
          y: {
            title: {
              display: true,
              text: "Doanh thu (VND)",
            },
            beginAtZero: true,
          },
        },
      },
    });

    // Dữ liệu cho biểu đồ sản phẩm bán (biểu đồ đường thay vì pie)
    const productsSoldLabels = data.totalQuantitySellProductPerMonthMap.map(
      (item) => ` ${item.month}`
    );
    const productsSoldData = data.totalQuantitySellProductPerMonthMap.map(
      (item) => item.totalSold
    );

    const ctx3 = document
      .getElementById("products-sold-chart")
      .getContext("2d");
    new Chart(ctx3, {
      type: "line", 
      data: {
        labels: productsSoldLabels,
        datasets: [
          {
            label: "Sản phẩm bán",
            data: productsSoldData,
            borderColor: "#FF5733", // Màu đường cho sản phẩm bán
            fill: false, // Không tô màu dưới đường
            tension: 0.1, // Làm mượt đường nối
            borderWidth: 2,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: "top",
          },
          tooltip: {
            callbacks: {
              label: function (tooltipItem) {
                return `${tooltipItem.raw} sản phẩm`; // Hiển thị số sản phẩm
              },
            },
          },
        },
        scales: {
          x: {
            title: {
              display: true,
              text: "Tháng",
            },
          },
          y: {
            title: {
              display: true,
              text: "Số lượng sản phẩm",
            },
            beginAtZero: true,
          },
        },
      },
    });

    const TopProductsList = document.getElementById("top-products-list");
TopProductsList.innerHTML = "";

// Duyệt qua danh sách sản phẩm từ API
data.topPurchasedProductInMonth.forEach((product) => {
  // Tạo một phần tử danh sách
  const li = document.createElement("li");
  li.classList.add("list-group-item");

  // Thêm nội dung gồm tên sản phẩm, ảnh và giá
  li.innerHTML = `
    <div><strong>${product.productName}</strong></div>
    <div><img src="${product.imageUrl}" alt="${product.productName}" style="width: 100px; height: auto;"></div>
    <div>Giá: ${product.price.toLocaleString()} VND</div>
  `;

  // Thêm vào danh sách
  TopProductsList.appendChild(li);
});

    // Cập nhật danh sách top khách hàng trong tháng
const topCustomersList = document.getElementById("top-customers-list");
topCustomersList.innerHTML = "";

// Lọc và hiển thị thông tin top khách hàng từ API
data.topCustomerInMonth.forEach((customer) => {
  const li = document.createElement("li");
  li.classList.add("list-group-item");
  li.innerHTML = `
    <div><strong>${customer.fullName}</strong></div>
    <div>Email: ${customer.email}</div>
    <div>Số điện thoại: ${customer.phoneNumber}</div>
    <div>Địa chỉ: ${customer.streetAddress}, ${customer.ward}, ${customer.district}, ${customer.city}, ${customer.address}</div>
    <div>Tổng chi tiêu: ${customer.totalAmount.toLocaleString()} VND</div>
  `;
  topCustomersList.appendChild(li);
});
  } catch (error) {
    console.error("Lỗi khi tải dữ liệu từ API:", error);
  }
}


document.addEventListener("DOMContentLoaded", loadDashboardData);

//   sidebar

const sidebar = document.getElementById('sidebar');
const wrapper = document.getElementById('wrapper');
const menuToggle = document.getElementById('menu-toggle');

// nút sidebar
menuToggle.addEventListener('click', function() {
  sidebar.classList.toggle('collapsed');
  // màn di động
  if (window.innerWidth <= 768) {
    wrapper.classList.toggle('collapsed');
  }
});

//  sidebar
