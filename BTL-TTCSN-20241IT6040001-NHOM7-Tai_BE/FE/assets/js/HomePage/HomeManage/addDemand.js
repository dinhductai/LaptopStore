
const demandImages = {
  "DOANHNHAN": "https://cdn2.fptshop.com.vn/unsafe/64x0/filters:quality(100)/Doanh_nhan_cate_thumb_f47056c47e.png",
  "GAMING_DOHOA": "https://cdn2.fptshop.com.vn/unsafe/64x0/filters:quality(100)/Gaming_do_hoa_cate_thumb_a6a745b7ed.png",
  "SINHVIEN_VANPHONG": "https://cdn2.fptshop.com.vn/unsafe/64x0/filters:quality(100)/Sinh_vien_van_phong_cate_thumb_b3d4859418.png",
  "MONGNHE": "https://cdn2.fptshop.com.vn/unsafe/64x0/filters:quality(100)/Mong_nhe_cate_thumb_0ecf5ddc73.png"
};


// Hàm hiển thị danh mục lên HTML
function renderCustomerDemand(customerDemandData) {
  const customerDemandContainer = document.getElementById("customer-demand");

  if (!customerDemandContainer) {
    console.error("Phần tử container không tồn tại trên trang.");
    return;
  }

  // Xóa nội dung cũ trước khi thêm mới
  customerDemandContainer.innerHTML = "";

  Object.keys(customerDemandData).forEach(key => {
    const demandName = customerDemandData[key];
    const demandImage = demandImages[key] || ""; // Lấy ảnh tương ứng hoặc để trống

    // Tạo phần tử HTML
    const demandItem = document.createElement("div");
    demandItem.className = "col-3 d-flex justify-content-center align-items-center custom-grid-item";
    demandItem.setAttribute("data-id", key); // Gắn id vào data-id

    demandItem.innerHTML = `
      <img src="${demandImage}" alt="${demandName}">
      <span>${demandName}</span>
    `;

    // Lắng nghe sự kiện click vào mỗi mục
    demandItem.addEventListener("click", function () {
      const selectedId = this.getAttribute("data-id");
      console.log("ID được chọn:", selectedId);

      // Gọi API hoặc chuyển màn khác với `selectedId`
      window.location.href = `product-list.html?q=${selectedId}`;
    });

    // Thêm vào container
    customerDemandContainer.appendChild(demandItem);
  });
}


