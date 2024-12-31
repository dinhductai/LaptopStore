
const productApiUrl = 'http://localhost:8080/admin/product/';


const productListDiv = document.getElementById('product-list');
const top10ProductsList = document.getElementById('top-10-products-list');
const monthlyNewProductsChart = document.getElementById('monthly-new-products-chart');


async function fetchProductData() {
  try {
    const response = await fetch(productApiUrl);
    
    // Kiểm tra nếu phản hồi hợp lệ
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }

    // Lấy dữ liệu JSON từ phản hồi
    const data = await response.json();
    console.log('Fetched Product Data:', data); 

    
    displayProductList(data.listProductDetail);
    displayTop10Products(data.listTopProductSell);
    displayMonthlyProductChart(data.quantityProductForChart);
  } catch (error) {
    console.error('Error fetching product data:', error);
  }
}


function displayProductList(products) {
  const productHTML = products.map((product, index) => {
    console.log('Product ID:', product.productId); 
    return `
      <tr>
        <td>${index + 1}</td>
        <td>${product.productName}</td>
        <td><img src="${product.imageUrl}" alt="${product.productName}" style="width: 50px; height: auto;" /></td>
        <td>${product.productBrand}</td>
        <td>${product.stockQuantity}</td>
        <td>${product.price.toLocaleString()} VND</td>
        <td>
          <input type="checkbox" class="product-checkbox" value="${product.productId}">
        </td>
        <td>
          <button class="btn btn-primary btn-sm" onclick="editProduct('${product.productId}')">Sửa</button>
        </td>
      </tr>
    `;
  }).join('');

  const productListDiv = document.getElementById('product-list');
  productListDiv.innerHTML = productHTML;
}



function editProduct(productId) {
  console.log('Edit Product ID:', productId); 
 
}

// Hàm hiển thị top 10 sản phẩm bán chạy nhất
function displayTop10Products(products) {
  
  const top10 = products.sort((a, b) => b.quantityOrdered - a.quantityOrdered).slice(0, 10);

  
  const top10HTML = `
    <table class="table table-striped">
      <thead>
        <tr>
          <th>#</th>
          <th>Tên sản phẩm</th>
          <th>Ảnh</th>
          <th>Giá</th>
        </tr>
      </thead>
      <tbody>
        ${top10.map((product, index) => `
          <tr>
            <td>${index + 1}</td>
            <td>${product.productName}</td>
            <td><img src="${product.imageUrl}" alt="${product.productName}" /></td>
            <td>${product.price.toLocaleString()} VND</td>
          </tr>
        `).join('')}
      </tbody>
    </table>
  `;

  // Hiển thị bảng trong phần tử HTML
  document.getElementById("top-10-products-list").innerHTML = top10HTML;
}


// Hàm hiển thị biểu đồ doanh thu sản phẩm theo tháng
function displayMonthlyProductChart(monthlyData) {
  const months = monthlyData.map(data => `Tháng ${data.month}`);
  const salesData = monthlyData.map(data => data.totalSold);

  const chartData = {
    labels: months,
    datasets: [{
      label: 'Sản phẩm bán theo tháng',
      data: salesData,
      borderColor: 'rgb(75, 192, 192)',
      backgroundColor: 'rgba(75, 192, 192, 0.2)',
      fill: true,
    }]
  };

  const chartOptions = {
    responsive: true,
    plugins: {
      legend: { position: 'top' },
      tooltip: {
        callbacks: {
          label: function (context) {
            return `${context.dataset.label}: ${context.raw}`;
          }
        }
      }
    }
  };

  new Chart(monthlyNewProductsChart, {
    type: 'line',
    data: chartData,
    options: chartOptions
  });
}

// Gọi hàm fetchProductData khi trang được tải
fetchProductData();
