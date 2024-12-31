document.addEventListener('DOMContentLoaded', () => {
  const featuredList = document.getElementById('featured-products-list');
  const regularList = document.getElementById('regular-products-list');
  const loadMoreBtn = document.getElementById('load-more-btn');
  const sortOptions = document.getElementById('sort-options');

  // Biến toàn cục
  window.allProducts = [];
  window.displayedProducts = []; // Kết quả lọc
  window.filteredProducts = []; // Kết quả lọc sau khi áp dụng bộ lọc
  let productOffset = 0; // Chỉ số offset để lấy sản phẩm tiếp theo
  const productsPerPage = 6; // Số sản phẩm hiển thị mỗi lần
  let currentSortOption = 'default';

  // Hàm khởi tạo
const initialize = async () => {
  try {
    const response = await fetch('http://localhost:8080/user/home');
    const data = await response.json();

    allProducts = data.getProductForHomePage || [];
    const productFeatured = data.getOutstandingProducts || [];
    const ListDemand = data.getCustomerDemandForCheckBox || {};
    console.log('Danh sách sản phẩm', allProducts);
    console.log('Danh sách sản phẩm nổi bật', productFeatured);
    console.log(ListDemand);

    // Hiển thị sản phẩm
    displayFeaturedProducts(productFeatured);
    renderCustomerDemand(ListDemand);

    // Kiểm tra và hiển thị sản phẩm sau khi load trang hoặc áp dụng bộ lọc
    if (filteredProducts.length > 0) {
      displayedProducts = filteredProducts.slice(0, productsPerPage);
    } else {
      displayedProducts = allProducts.slice(0, productsPerPage); // Nếu chưa có lọc, hiển thị sản phẩm mặc định
    }

    productOffset = displayedProducts.length; // Cập nhật offset
    sortAndDisplayProducts(); // Áp dụng sắp xếp và hiển thị sản phẩm
    toggleLoadMoreButton(); // Kiểm tra và hiển thị nút "Load More"
  } catch (error) {
    console.error('Error fetching products:', error);
  }
};

  // Hàm hiển thị sản phẩm nổi bật
  const displayFeaturedProducts = (products) => {
    const featuredSection = document.getElementById('featured-products');
    if (products.length >= 4) {
      featuredSection.style.display = 'block'; // Hiển thị nếu có từ 4 sản phẩm trở lên
      featuredList.innerHTML = products
        .slice(0, 4) // Lấy tối đa 4 sản phẩm
        .map(product => createProductHTML(product, true)) // Tạo HTML cho mỗi sản phẩm
        .join('');
    } else {
      featuredSection.style.display = 'none'; // Ẩn nếu có ít hơn 4 sản phẩm
    }
  };

 // Hàm hiển thị sản phẩm thông thường
const displayRegularProducts = (products) => {
  if (products.length === 0) {
    regularList.innerHTML = `
      <div class="empty-message">
        <img src="empty-box.png" alt="Không có sản phẩm" class="empty-image">
        <p>Hiện không có sản phẩm nào để hiển thị.</p>
       
      </div>
    `;
  } else {
    regularList.innerHTML = products
      .map(product => createProductHTML(product, false)) // Tạo HTML cho mỗi sản phẩm
      .join('');
  }
};

// Hàm tạo HTML cho sản phẩm
const createProductHTML = (product, isFeatured) => `
  <div class="${isFeatured ? 'featured-item' : 'product-item'}">
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
  </div>
`;


  // Hàm tải sản phẩm ban đầu
  const loadInitialProducts = () => {
    displayedProducts = allProducts.slice(0, productsPerPage); // Lấy sản phẩm đầu tiên
    productOffset = productsPerPage; // Cập nhật offset
    sortAndDisplayProducts(); // Áp dụng sắp xếp trước khi hiển thị
    toggleLoadMoreButton();
  };



  // Hàm sắp xếp và hiển thị sản phẩm
  const sortAndDisplayProducts = () => {
    let sortedProducts = [...displayedProducts]; // Sắp xếp bản sao của mảng displayedProducts
    switch (currentSortOption) {
      case 'price-asc':
        sortedProducts.sort((a, b) => a.price - b.price); // Sắp xếp theo giá tăng dần
        break;
      case 'price-desc':
        sortedProducts.sort((a, b) => b.price - a.price); // Sắp xếp theo giá giảm dần
        break;
      default:
        break; // Giữ nguyên thứ tự ban đầu nếu không có sắp xếp
    }

    displayRegularProducts(sortedProducts);
  };
  let isFiltering = false;
  const toggleLoadMoreButton = () => {
    
    if (isFiltering&filteredProducts.length === 0) {
        loadMoreBtn.style.display = 'none';
        console.log("No products to display after filtering.");
        return; 
    }
  
    // Nếu danh sách không rỗng, kiểm tra số lượng sản phẩm hiển thị
    const productsToCheck = filteredProducts.length > 0 ? filteredProducts : allProducts;
    loadMoreBtn.style.display = productOffset >= productsToCheck.length ? 'none' : 'block';
};

    // Hàm tải thêm sản phẩm
const loadMoreProducts = () => {
  const productsToLoad = filteredProducts.length > 0 ? filteredProducts : allProducts; // Kiểm tra nếu có bộ lọc, nếu không thì dùng allProducts
  const newProducts = productsToLoad.slice(productOffset, productOffset + productsPerPage);
  
  displayedProducts = [...displayedProducts, ...newProducts];
  productOffset += productsPerPage;

  sortAndDisplayProducts(); // Áp dụng sắp xếp trước khi hiển thị
  toggleLoadMoreButton();
};

  

  // Gắn sự kiện cho nút "Load More"
  loadMoreBtn.addEventListener('click', loadMoreProducts);

  // Xử lý sự kiện thay đổi sắp xếp
  sortOptions.addEventListener('change', (event) => {
    currentSortOption = event.target.value; // Cập nhật lựa chọn sắp xếp hiện tại
    sortAndDisplayProducts(); // Áp dụng sắp xếp mới ngay lập tức
  });

  // Khởi chạy
  initialize();

  // Hàm lấy checkbox đã chọn
  function getSelectedCheckboxes(groupName) {
    const checkboxes = document.querySelectorAll(`input[name="${groupName}"]:checked`);
    return Array.from(checkboxes).map(checkbox => checkbox.value);
  }

  // Hàm xây dựng URL API với bộ lọc
  function buildApiUrl() {
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


  // Xử lý sự kiện submit form lọc
  document.getElementById('filter-form').addEventListener('submit', function (event) {
    event.preventDefault();
    const updatedApiUrl = buildApiUrl();
    console.log('Updated API URL:', updatedApiUrl);
    isFiltering=true;
    fetch(updatedApiUrl)
      .then(response => response.json())
      .then(data => {
        console.log('Filtered Data:', data);

        filteredProducts = data; // Cập nhật danh sách sản phẩm đã lọc
        displayedProducts = filteredProducts.slice(0, productsPerPage); // Lấy 6 sản phẩm đầu tiên
        productOffset = productsPerPage; // Cập nhật offset
        sortAndDisplayProducts(); // Áp dụng sắp xếp và hiển thị sản phẩm
        toggleLoadMoreButton();
      })
      .catch(error => console.error('Lỗi khi gọi API:', error));
  });
});
