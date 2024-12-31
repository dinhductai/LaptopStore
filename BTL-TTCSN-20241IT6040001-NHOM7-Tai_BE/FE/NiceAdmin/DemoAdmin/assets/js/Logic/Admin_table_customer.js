// Hàm lấy và hiển thị Top 10 khách hàng chi tiêu nhiều nhất
async function fetchCustomerData() {
  try {
    const response = await fetch("http://localhost:8080/admin/customers"); // Đổi URL API

    if (!response.ok) throw new Error("Lỗi kết nối mạng");

    let data = await response.json();

    // Sắp xếp và lấy Top 10 khách hàng chi tiêu nhiều nhất
    data.sort((a, b) => b.expenditure - a.expenditure);
    const topCustomers = data.slice(0, 10);

    // Lấy phần tử body của bảng Top 10 khách hàng
    const tableBody = document.getElementById("customer-table-body");
    tableBody.innerHTML = "";

    topCustomers.forEach((customer) => {
      const row = document.createElement("tr");
      row.innerHTML = `
                <td>
                    <div class="d-flex px-2 py-1">
                        <div>
                            <img src="${
                              customer.avatarUrl ||
                              ".../assets/img/default-avatar.png"
                            }" class="avatar avatar-sm me-3 border-radius-lg" alt="user">
                        </div>
                        <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm">${customer.name}</h6>
                            <p class="text-xs text-secondary mb-0">${
                              customer.email
                            }</p>
                        </div>
                    </div>
                </td>
                <td><p class="text-xs font-weight-bold mb-0">${
                  customer.city
                }</p></td>
                <td class="align-middle text-center text-sm">
                    <span class="text-secondary text-xs font-weight-bold">$${
                      customer.expenditure
                    }</span>
                </td>
                <td class="align-middle text-center">
                    <span class="text-secondary text-xs font-weight-bold">${
                      customer.customerId
                    }</span>
                </td>
            `;
      tableBody.appendChild(row);
    });
  } catch (error) {
    console.error("Failed to fetch customer data:", error);
  }
}

// Hàm lấy và hiển thị Thông tin khách hàng chi tiết
async function fetchCustomerInfo() {
  try {
    const response = await fetch(
      "http://localhost:8080/test/admin/customerinfor/"
    ); // Đổi URL API

    if (!response.ok) throw new Error("Lỗi kết nối mạng");

    const data = await response.json();

    const infoTableBody = document.getElementById("customer-info-table-body");
    infoTableBody.innerHTML = "";

    data.forEach((customer) => {
      const row = document.createElement("tr");
      row.innerHTML = `
                <td>
                    <div class="d-flex px-2">
                        
                        <div class="my-auto">
                            <h6 class="mb-0 text-sm">${customer.fullName}</h6>
                        </div>
                    </div>
                </td>
                <td><p class="text-sm font-weight-bold mb-0">${customer.customerID}</p></td>
                <td><span class="text-xs font-weight-bold">${customer.city}</span></td>
                <td><span class="text-xs font-weight-bold">${customer.district}</span></td>
                <td><span class="text-xs font-weight-bold">${customer.ward}</span></td>
                <td><span class="text-xs font-weight-bold">${customer.streetAddress}</span></td>
                <td><span class="text-xs font-weight-bold">${customer.registrationDate}</span></td>
                <td><span class="text-xs font-weight-bold">${customer.status}</span></td>
                
            `;
      infoTableBody.appendChild(row);
    });
  } catch (error) {
    console.error("Failed to fetch customer info:", error);
  }
}

// Hàm lấy dữ liệu khách hàng mới mỗi tháng từ API và vẽ biểu đồ
async function fetchChartData() {
  try {
    const response = await fetch(
      "http://localhost:8080/test/admin/countcustomer/"
    ); // Đổi URL API

    if (!response.ok) throw new Error("Lỗi kết nối mạng");
    const data = await response.json();

    // Tạo mảng tháng và số lượng khách hàng từ dữ liệu API
    const months = data.map((item) => {
      switch (item.month) {
        case 2:
          return "Feb";
        case 3:
          return "Mar";
        case 4:
          return "Apr";
        case 5:
          return "May";
        case 6:
          return "Jun";
        case 7:
          return "Jul";
        case 8:
          return "Aug";
        case 9:
          return "Sep";
        case 10:
          return "Oct";
        case 11:
          return "Nov";
        default:
          return `Month ${item.month}`;
      }
    }); // Tên các tháng
    const customerCounts = data.map((item) => item.customerCount); // Số lượng khách hàng mới mỗi tháng

    drawChart(months, customerCounts); // Gọi hàm vẽ biểu đồ với dữ liệu lấy từ API
  } catch (error) {
    console.error("Failed to fetch chart data:", error);
  }
}

// Hàm vẽ biểu đồ nhận dữ liệu từ API
function drawChart(months, customerCounts) {
  var ctx2 = document.getElementById("chart-line").getContext("2d");

  new Chart(ctx2, {
    type: "line",
    data: {
      labels: months, // Sử dụng tên tháng lấy từ API
      datasets: [
        {
          label: "Khách hàng mới",
          tension: 0,
          borderWidth: 0,
          pointRadius: 5,
          pointBackgroundColor: "rgba(255, 255, 255, .8)",
          pointBorderColor: "transparent",
          borderColor: "rgba(255, 255, 255, .8)",
          borderWidth: 4,
          backgroundColor: "transparent",
          fill: true,
          data: customerCounts,
          maxBarThickness: 6,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
      interaction: {
        intersect: false,
        mode: "index",
      },
      scales: {
        y: {
          grid: {
            drawBorder: false,
            display: true,
            drawOnChartArea: true,
            drawTicks: false,
            borderDash: [5, 5],
            color: "rgba(255, 255, 255, .2)",
          },
          ticks: {
            display: true,
            color: "#f8f9fa",
            padding: 10,
            font: {
              size: 14,
              weight: 300,
              family: "Roboto",
              style: "normal",
              lineHeight: 2,
            },
          },
        },
        x: {
          grid: {
            drawBorder: false,
            display: false,
            drawOnChartArea: false,
            drawTicks: false,
            borderDash: [5, 5],
          },
          ticks: {
            display: true,
            color: "#f8f9fa",
            padding: 10,
            font: {
              size: 14,
              weight: 300,
              family: "Roboto",
              style: "normal",
              lineHeight: 2,
            },
          },
        },
      },
    },
  });
}

// Gọi tất cả các hàm khi trang tải xong
document.addEventListener("DOMContentLoaded", () => {
  fetchCustomerData(); // Gọi hàm lấy dữ liệu khách hàng chi tiêu nhiều nhất
  fetchCustomerInfo(); // Gọi hàm lấy dữ liệu khách hàng chi tiết
  fetchChartData(); // Gọi hàm lấy dữ liệu biểu đồ khách hàng mới
});
