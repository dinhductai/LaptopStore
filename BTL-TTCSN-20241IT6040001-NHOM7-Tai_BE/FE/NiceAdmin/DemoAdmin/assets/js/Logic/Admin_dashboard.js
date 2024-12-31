document.addEventListener("DOMContentLoaded", function () {
  // Lấy các phần tử HTML theo ID
  const Products_sold_in_the_month = document.getElementById(
    "Quantity_Sell_Product_Current_Month"
  );
  const Total_Customer_In_Current_Month = document.getElementById(
    "Total_Customer_In_Current_Month"
  );
  const Total_New_Customer_In_Current_Month = document.getElementById(
    "Total_New_Customer_In_Current_Month"
  );
  const Total_Amount_InCurrent_Month = document.getElementById(
    "Total_Amount_InCurrent_Month"
  );

  // Gọi API để load sản phẩm khi trang load
  fetch("http://localhost:8080/admin/dashboard/")
    .then((response) => response.json())
    .then((data) => {
      // Cập nhật nội dung của các phần tử
      Products_sold_in_the_month.querySelector("h4").textContent =
        data.quantitySellProductCurrentMonth;
      Total_Customer_In_Current_Month.querySelector("h4").textContent =
        data.totalCustomerInCurrentMonth;
      Total_New_Customer_In_Current_Month.querySelector("h4").textContent =
        data.totalNewCustomerInCurrentMonth;
      Total_Amount_InCurrent_Month.querySelector("h4").textContent =
        data.totalAmountInCurrentMonth;

      // Dữ liệu được trả về từ API (ví dụ: data = List<Customer_CountNewCustomerPerMonthDTO>)
      const labelsDA = data.newCustomerPerMonthMap.map(
        (newCustomerPerMonthMap) => newCustomerPerMonthMap.month
      ); // Lấy các tháng (M, T, W, ...)
      const newCustomerData = data.newCustomerPerMonthMap.map(
        (newCustomerPerMonthMap) => newCustomerPerMonthMap.customerCount
      ); // Lấy số lượng khách hàng mới trong tháng ?????
      //const labels2 = data.map(item => item.month);  // Lấy các tháng (M, T, W, ...)
      const totalAmountData = data.totalAmountPerMonthMap.map(
        (totalAmountPerMonthMap) => totalAmountPerMonthMap.totalAmount
      ); // Lấy danh thu trong tháng ????
      //const labels3 = data.map(item => item.month);  // Lấy các tháng (M, T, W, ...)
      const totalQuantitySellProductData =
        data.totalQuantitySellProductPerMonthMap.map(
          (totalQuantitySellProductPerMonthMap) =>
            totalQuantitySellProductPerMonthMap.totalSold
        ); // Lấy số lượng san pham trong tháng ????
      // Tạo biểu đồ
      var ctx = document.getElementById("chart-bars").getContext("2d");

      new Chart(ctx, {
        type: "bar",
        data: {
          labels: labelsDA, // Sử dụng labels lấy từ dữ liệu
          datasets: [
            {
              label: "New Customers",
              tension: 0.4,
              borderWidth: 0,
              borderRadius: 4,
              borderSkipped: false,
              backgroundColor: "rgba(255, 255, 255, .8)",
              data: newCustomerData, // Dữ liệu số lượng khách hàng mới trong tháng
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
                suggestedMin: 0,
                suggestedMax: 500, // Tùy chỉnh giá trị tối đa
                beginAtZero: true,
                padding: 10,
                font: {
                  size: 14,
                  weight: 300,
                  family: "Roboto",
                  style: "normal",
                  lineHeight: 2,
                },
                color: "#fff",
              },
            },
            x: {
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
          },
        },
      });

      var ctx2 = document.getElementById("chart-line").getContext("2d");

      new Chart(ctx2, {
        type: "line",
        data: {
          labels: labelsDA,
          datasets: [
            {
              label: "Mobile apps",
              tension: 0,
              borderWidth: 0,
              pointRadius: 5,
              pointBackgroundColor: "rgba(255, 255, 255, .8)",
              pointBorderColor: "transparent",
              borderColor: "rgba(255, 255, 255, .8)",
              borderColor: "rgba(255, 255, 255, .8)",
              borderWidth: 4,
              backgroundColor: "transparent",
              fill: true,
              data: totalAmountData,
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

      var ctx3 = document.getElementById("chart-line-tasks").getContext("2d");

      new Chart(ctx3, {
        type: "line",
        data: {
          labels: labelsDA,
          datasets: [
            {
              label: "Mobile apps",
              tension: 0,
              borderWidth: 0,
              pointRadius: 5,
              pointBackgroundColor: "rgba(255, 255, 255, .8)",
              pointBorderColor: "transparent",
              borderColor: "rgba(255, 255, 255, .8)",
              borderWidth: 4,
              backgroundColor: "transparent",
              fill: true,
              data: totalQuantitySellProductData,
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
                padding: 10,
                color: "#f8f9fa",
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
      // --------------------------------------------------------------------------------------------
      const tableBody = document.getElementById("table-body");
      tableBody.innerHTML = ""; // Clear any previous data

      dat.topPurchasedProductInMonth.forEach((topPurchasedProductInMonth) => {
        const row = document.createElement("tr");

        // Create customer name cell
        const productCell = document.createElement("td");
        productCell.innerHTML = `
                    <div class="d-flex px-2 py-1">
                        <div>
                            <img src="${topPurchasedProductInMonth.imageURL}" class="avatar avatar-sm me-3" alt="${topPurchasedProductInMonth.productName}" />
                        </div>
                        <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm">${topPurchasedProductInMonth.productName}</h6>
                        </div>
                    </div>
                `;
        row.appendChild(productCell);

        // Create customer sales cell
        const salesCell = document.createElement("td");
        salesCell.classList.add("align-middle", "text-center", "text-sm");
        salesCell.innerHTML = `
                    <span class="text-xs font-weight-bold">${topPurchasedProductInMonth.quantityOrdered}</span>
                `;
        row.appendChild(salesCell);

        // Append the row to the table
        tableBody.appendChild(row);
      });
    })
    .catch((error) => console.error("Error fetching customer data:", error));

  // Call the fetchCustomerSalesData function when the page loads

  // Function to fetch data from the API and populate the table
  function fetchProductData() {
    fetch("http://localhost:8080/admin/dashboard/") // Replace with your API URL
      .then((response) => response.json()) // Assuming the response is in JSON format
      .then((data) => {
        const tableBody = document.getElementById("table-body");
        tableBody.innerHTML = ""; // Clear any previous data

        data.topCustomerInMonth.forEach((product) => {
          const row = document.createElement("tr");

          // Create product name cell
          const productCell = document.createElement("td");
          productCell.innerHTML = `
                    <div class="d-flex px-2 py-1">
                        <div>
                            <img src="${product.image}" class="avatar avatar-sm me-3" alt="${product.name}" />
                        </div>
                        <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm">${product.name}</h6>
                        </div>
                    </div>
                `;
          row.appendChild(productCell);

          // Create sales value cell
          const salesCell = document.createElement("td");
          salesCell.classList.add("align-middle", "text-center", "text-sm");
          salesCell.innerHTML = `
                    <span class="text-xs font-weight-bold">${product.sales}</span>
                `;
          row.appendChild(salesCell);

          // Append the row to the table
          tableBody.appendChild(row);
        });
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
      });
  }

  // Call the fetchProductData function when the page is loaded
  window.onload = fetchProductData;
});
