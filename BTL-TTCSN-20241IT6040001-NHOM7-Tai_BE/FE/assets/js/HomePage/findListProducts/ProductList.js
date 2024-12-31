const urlParams = new URLSearchParams(window.location.search);
const queryParam = urlParams.get("q");

const sortOptions = document.getElementById('sort-options');
const filterForm = document.getElementById('filter-form');
const productList = document.getElementById("Find-products-list");

let allProducts = [];


const apiSearchUrl = queryParam ? `http://localhost:8080/user/search?keyword=${queryParam}` : null;

// Hàm gọi API tìm kiếm và hiển thị sản phẩm
async function fetchSearchResults() {
  if (!apiSearchUrl) {
    console.error("Không có tham số tìm kiếm trong URL.");
    return;
  }

  try {
    const response = await fetch(apiSearchUrl);
    if (!response.ok) throw new Error("Lỗi khi gọi API tìm kiếm");

    allProducts = await response.json();
    console.log('Danh sách sản phẩm bằng tìm kiếm :',allProducts)
    displayProducts(allProducts);
  } catch (error) {
    console.error("Có lỗi xảy ra:", error);
  }
}

// Hàm hiển thị sản phẩm
function displayProducts(products) {
  productList.innerHTML = "";

  products.forEach(product => {
    const productItem = document.createElement("div");
    productItem.className = "product-item";
    productItem.innerHTML = `
      <a class="product-link" href="product-details.html?id=${product.productId}">
        <div class="product-image">
          <img src="${product.imageUrl}" alt="${product.productName}">
        </div>
        <div class="product-info">
          <h3 class="product-title">${product.productName}</h3>
          <p class="product-price">Giá: ${(product.price).toLocaleString('vi-VN')} VND</p>
        </div>
      </a>
      <button class="compare-btn" onclick="addToCompare(${product.productId})">
        <div class="icon-circle">
          <i class="fas fa-plus"></i>
        </div>
        So sánh
      </button>
    `;
    productList.appendChild(productItem);
  });
}


function sortProducts(sortCriteria) {
  let sortedProducts = [...allProducts];
  if (sortCriteria === "price-asc") {
    sortedProducts.sort((a, b) => a.price - b.price);
  } else if (sortCriteria === "price-desc") {
    sortedProducts.sort((a, b) => b.price - a.price);
  }
  displayProducts(sortedProducts);
}

// Lấy giá trị từ các checkbox đã chọn
function getSelectedCheckboxes(groupName) {
  const checkboxes = document.querySelectorAll(`input[name="${groupName}"]:checked`);
  return Array.from(checkboxes).map(checkbox => checkbox.value);
}

  // Hàm xây dựng URL API với bộ lọc
  function buildFilterApiUrl() {
    const apiUrl = "http://localhost:8080/user/home";
    const params = new URLSearchParams();

    const brands = getSelectedCheckboxes('brand-filter');
    brands.forEach(brand => params.append('idBrand', brand));

    const prices = getSelectedCheckboxes('price-filter');
    prices.forEach(price => params.append('price', price));

    const cpus = getSelectedCheckboxes('cpu-filter');
    cpus.forEach(cpu => params.append('cpu', cpu));

    const rams = getSelectedCheckboxes('ram-filter');
    rams.forEach(ram => params.append('ram', ram));

    const storages = getSelectedCheckboxes('hardrive-filter');
    storages.forEach(storage => params.append('hardDrive', storage));

    const screenSizes = getSelectedCheckboxes('screen-size-filter');
    screenSizes.forEach(screenSize => params.append('screenSize', screenSize));

    return `${apiUrl}/?${params.toString()}`;
}

// Hàm gọi API lọc và hiển thị sản phẩm
async function fetchFilteredProducts() {
  try {
    const filterApiUrl = buildFilterApiUrl();
    const response = await fetch(filterApiUrl);
    if (!response.ok) throw new Error("Lỗi khi gọi API lọc");

    allProducts = await response.json();
    console.log('Danh sách sản phẩm khi dùng bộ lọc :',allProducts)
    displayProducts(allProducts);
  } catch (error) {
    console.error("Có lỗi xảy ra:", error);
  }
}

// Sự kiện submit form lọc
filterForm.addEventListener('submit', (event) => {
  event.preventDefault();
  fetchFilteredProducts();
});

// Sự kiện thay đổi sắp xếp
sortOptions.addEventListener('change', (event) => {
  sortProducts(event.target.value);
});


if (queryParam) {
  fetchSearchResults();
} else {
  console.log("Không có tham số tìm kiếm trong URL.");
}
