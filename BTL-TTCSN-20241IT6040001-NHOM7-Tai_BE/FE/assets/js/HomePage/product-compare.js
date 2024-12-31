// Lấy tham số từ URL
const params = new URLSearchParams(window.location.search);
const product1ID = params.get('product1');
const product2ID = params.get('product2');

// Kiểm tra nếu có ID sản phẩm
if (product1ID && product2ID) {
    // Gọi API với các sản phẩm cần so sánh
    fetch(`http://localhost:8080/user/compare?ids=${product1ID}&ids=${product2ID}`)
        .then(response => response.json())
        .then(data => {
            // Lấy dữ liệu sản phẩm từ API trả về
            const product1 = data[0];
            const product2 = data[1];

            // Cập nhật tên sản phẩm trong phần content-compare
            document.getElementById('product1__name').textContent = product1.productName;
            document.getElementById('product2__name').textContent = product2.productName;

            // Cập nhật thông tin sản phẩm 1
            document.getElementById('product1__image').src = product1.imageUrl;
            document.getElementById('product1__productName').textContent = product1.productName;
            document.getElementById('product1__price').textContent = `${product1.price.toLocaleString()} VND`;

            // Cập nhật thông tin sản phẩm 2
            document.getElementById('product2__image').src = product2.imageUrl;
            document.getElementById('product2__productName').textContent = product2.productName;
            document.getElementById('product2__price').textContent = `${product2.price.toLocaleString()} VND`;

             // Gắn ID sản phẩm vào nút "Thêm vào giỏ hàng"
             const addToCartButton1 = document.getElementById('add-to-cart-product1');
             const addToCartButton2 = document.getElementById('add-to-cart-product2');
 
             // Gán ID của sản phẩm vào nút
             addToCartButton1.setAttribute('data-product-id', product1.productId);
             addToCartButton2.setAttribute('data-product-id', product2.productId);
            displayProductDescriptions(product1,product2)
            updateProductComparison(product1,product2)
        })
        .catch(error => {
            console.error('Lỗi khi gọi API:', error);
        });
}

// Hàm cập nhật thông tin sản phẩm
function updateProductComparison(product1, product2) {
  // Cập nhật tên sản phẩm trong phần content-compare
  document.getElementById('header__product1').textContent = product1.productName; 
  document.getElementById('header__product2').textContent = product2.productName; 

  // Cập nhật thông số kỹ thuật vào bảng
  document.getElementById('product1__cpuTech').textContent = product1.cpuTechnology || 'N/A';
  document.getElementById('product2__cpuTech').textContent = product2.cpuTechnology || 'N/A';

  document.getElementById('product1__ram').textContent = product1.ramCapacity || 'N/A';
  document.getElementById('product2__ram').textContent = product2.ramCapacity || 'N/A';

  document.getElementById('product1__gpu').textContent = product1.vgaFullName || 'N/A';
  document.getElementById('product2__gpu').textContent = product2.vgaFullName || 'N/A';

  document.getElementById('product1__screen').textContent = product1.screenSize || 'N/A';
  document.getElementById('product2__screen').textContent = product2.screenSize || 'N/A';
}

// Hàm hiển thị thông số sản phẩm
function displayProductDescriptions(product1Description, product2Description) {
  document.getElementById('All-header__product1').textContent = product1Description.productName; 
  document.getElementById('All-header__product2').textContent = product2Description.productName; 
  const specsTable = document.getElementById('all-specs').querySelector('tbody');
  specsTable.innerHTML = ''; // Xóa nội dung cũ

  // Tạo các hàng trong bảng với thông tin sản phẩm 1 và sản phẩm 2
  specsTable.innerHTML += `
      <tr class="section-title" data-toggle="cpu">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Bộ xử lý <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="cpu hidden">
                    <td>Hãng CPU</td>
                    <td>${product1Description.cpuCompany}</td>
                    <td>${product2Description.cpuCompany}</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Công nghệ CPU</td>
                    <td>${product1Description.cpuTechnology}</td>
                    <td>${product2Description.cpuTechnology}</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Loại CPU</td>
                    <td>${product1Description.cpuType}</td>
                    <td>${product2Description.cpuType}</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Tốc độ CPU (tối thiểu)</td>
                    <td>${product1Description.minimumCPUspeed} GHz</td>
                    <td>${product2Description.minimumCPUspeed} GHz</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Tốc độ CPU (tối đa)</td>
                    <td>${product1Description.maximunSpeed} GHz</td>
                    <td>${product2Description.maximunSpeed} GHz</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Nhân CPU</td>
                    <td>${product1Description.multiplier} GHz</td>
                    <td>${product2Description.multiplier} GHz</td>
                </tr>
                 <tr class="cpu hidden">
                    <td>Bộ nhớ đệm</td>
                    <td>${product1Description.processorCache} GHz</td>
                    <td>${product2Description.processorCache} GHz</td>
                </tr>



                 <!-- Mục Đồ họa -->
                <tr class="section-title" data-toggle="graphics">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Đồ họa <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr> 

                <tr class="graphics hidden">
                    <td>Hãng (Card Oboard)</td>
                    <td>${product1Description.brandCardOboard}</td>
                    <td>${product2Description.brandCardOboard}</td>
                </tr>

                <tr class="graphics hidden">
                    <td>Model (Card Oboard)</td>
                    <td>${product1Description.modelCardOboard}</td>
                    <td>${product2Description.modelCardOboard}</td>
                </tr>

                <tr class="graphics hidden">
                    <td>Tên đầy đủ (Card onbroad)</td>
                    <td>${product1Description.fullNameCardOboard}</td>
                    <td>${product2Description.fullNameCardOboard}</td>
                </tr>
                <tr class="graphics hidden">
                    <td>Card VGA</td>
                    <td>${product1Description.vgaFullName}</td>
                    <td>${product2Description.vgaFullName}</td>
                </tr>

               

                <!-- Mục RAM -->
                <tr class="section-title" data-toggle="ram">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        RAM <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="ram hidden">
                    <td>Dung lượng RAM</td>
                    <td>${product1Description.ramCapacity} GB</td>
                    <td>${product2Description.ramCapacity} GB</td>
                </tr>
                <tr class="ram hidden">
                    <td>Loại RAM</td>
                    <td>${product1Description.ramType}</td>
                    <td>${product2Description.ramType}</td>
                </tr>
                <tr class="ram hidden">
                    <td>Tốc độ RAM</td>
                    <td>${product1Description.ramSpeed}</td>
                    <td>${product2Description.ramSpeed}</td>
                </tr>


                 <tr class="ram hidden">
                    <td>Số khe cắm rời</td>
                    <td>${product1Description.numberOfRemovableSlots} </td>
                    <td>${product2Description.numberOfRemovableSlots} </td>
                </tr>

                <tr class="ram hidden">
                    <td>Số RAM onboard</td>
                    <td>${product1Description.numberOfOnboardRAM} </td>
                    <td>${product2Description.numberOfOnboardRAM} </td>
                </tr>

                <tr class="ram hidden">
                    <td>Hỗ trợ RAM tối đa</td>
                    <td>${product1Description.maximumRAMSupport} GB </td>
                    <td>${product2Description.maximumRAMSupport} GB </td>
                </tr>

                <!-- Mục Lưu trữ -->
                <tr class="section-title" data-toggle="storage">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Lưu trữ <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="storage hidden">
                    <td>Kiểu ổ cứng</td>
                    <td>${product1Description.hardDriveType}</td>
                    <td>${product2Description.hardDriveType}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Kiểu ổ cứng</td>
                    <td>${product1Description.totalSSDHDDSlots}</td>
                    <td>${product2Description.totalSSDHDDSlots}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Số khe SSD/HDD còn lại</td>
                    <td>${product1Description.numberOfSSDHDDSlotsRemaining}</td>
                    <td>${product2Description.numberOfSSDHDDSlotsRemaining}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Dung lượng nâng cấp tối đa ổ cứng</td>
                    <td>${product1Description.maximumHardDriveUpgradeCapacity}</td>
                    <td>${product2Description.maximumHardDriveUpgradeCapacity}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Dung lượng ổ cứng</td>
                    <td>${product1Description.capacity} GB</td>
                    <td>${product2Description.capacity} GB</td>
                </tr>
              

                <!-- Mục Màn hình -->
                <tr class="section-title" data-toggle="screen">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Màn hình <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="screen hidden">
                    <td>Kích thước màn hình</td>
                    <td>${product1Description.screenSize} inch</td>
                    <td>${product2Description.screenSize} inch</td>
                </tr>
                <tr class="screen hidden">
                    <td>Công nghệ màn hình</td>
                    <td>${product1Description.displayTechnology}</td>
                    <td>${product2Description.displayTechnology}</td>
                </tr>
                <tr class="screen hidden">
                    <td>Độ phân giải</td>
                    <td>${product1Description.resolution}</td>
                    <td>${product2Description.resolution}</td>
                </tr>
               

                <tr class="screen hidden">
                    <td>Loại màn hình</td>
                    <td>${product1Description.screenType}</td>
                    <td>${product2Description.screenType}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Tần số quét</td>
                    <td>${product1Description.scanningFrequency}</td>
                    <td>${product2Description.scanningFrequency}</td>
                </tr>

                
                <tr class="screen hidden">
                    <td>Tấm nền</td>
                    <td>${product1Description.basePlate}</td>
                    <td>${product2Description.basePlate}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Độ sáng</td>
                    <td>${product1Description.brightness}</td>
                    <td>${product2Description.brightness}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Độ phủ màu</td>
                    <td>${product1Description.colorCoverage}</td>
                    <td>${product2Description.colorCoverage}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Tỷ lệ màn hình</td>
                    <td>${product1Description.screenRatio}</td>
                    <td>${product2Description.screenRatio}</td>
                </tr>

                <!-- Mục Giao tiếp và kết nối -->
                <tr class="section-title" data-toggle="connectivity">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Giao tiếp và kết nối <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="connectivity hidden">
                    <td>Cổng giao tiếp</td>
                    <td>${product1Description.communicationPort}</td>
                    <td>${product2Description.communicationPort}</td>
                </tr>
                <tr class="connectivity hidden">
                    <td>Wi-Fi</td>
                    <td>${product1Description.wifi}</td>
                    <td>${product2Description.wifi}</td>
                </tr>
                <tr class="connectivity hidden">
                    <td>Bluetooth</td>
                    <td>${product1Description.bluetooth}</td>
                    <td>${product2Description.bluetooth}</td>
                </tr>

                <tr class="connectivity hidden">
                    <td>Webcam</td>
                    <td>${product1Description.webcam}</td>
                    <td>${product2Description.webcam}</td>
                </tr>

                <!-- Mục Hệ điều hành -->
                <tr class="section-title" data-toggle="os">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Hệ điều hành <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="os hidden">
                    <td>Tên hệ điều hành</td>
                    <td>${product1Description.os}</td>
                    <td>${product2Description.os}</td>
                </tr>
                <tr class="os hidden">
                    <td>Version</td>
                    <td>${product1Description.version}</td>
                    <td>${product2Description.version}</td>
                </tr>

                <!-- Mục Bảo mật -->
                <tr class="section-title" data-toggle="security">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Bảo mật <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="security hidden">
                    <td>Bảo mật hệ thống</td>
                    <td>${product1Description.security}</td>
                    <td>${product2Description.security}</td>
                </tr>

                <!-- Mục  Bàn phím & TouchPad -->
                <tr class="section-title" data-toggle="Keyboard-TouchPad">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Bàn phím & TouchPad <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>

                <tr class="Keyboard-TouchPad hidden">
                    <td>Kiểu bàn phím</td>
                    <td>${product1Description.keyboardType}</td>
                    <td>${product2Description.keyboardType}</td>
                </tr>

                <tr class="Keyboard-TouchPad hidden">
                    <td>Bàn phím số</td>
                    <td>${product1Description.numericKeypad}</td>
                    <td>${product2Description.numericKeypad}</td>
                </tr>

                <tr class="Keyboard-TouchPad hidden">
                    <td>Đèn bàn phím</td>
                    <td>${product1Description.keyboardLight}</td>
                    <td>${product2Description.keyboardLight}</td>
                </tr>

                 <tr class="Keyboard-TouchPad hidden">
                    <td>TouchPad</td>
                    <td>${product1Description.touchPad}</td>
                    <td>${product2Description.touchPad}</td>
                </tr>

                <!-- Mục  Thông tin pin & sạc -->
                <tr class="section-title" data-toggle="Battery-charging">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Thông tin pin & sạc<span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>

                <tr class="Battery-charging hidden">
                    <td>Loại pin</td>
                    <td>${product1Description.batteryType}</td>
                    <td>${product2Description.batteryType}</td>
                </tr>

                 <tr class="Battery-charging hidden">
                    <td>Dung lượng pin</td>
                    <td>${product1Description.batteryCapacity} mAh</td>
                    <td>${product2Description.batteryCapacity} mAh</td>
                </tr>

                 <tr class="Battery-charging hidden">
                    <td>Power Supply</td>
                    <td>${product1Description.powerSupply}</td>
                    <td>${product2Description.powerSupply}</td>
                </tr>

                <!-- Mục Phụ kiện trong hộp -->
                <tr class="section-title" data-toggle="Accessories-in-the-box">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Phụ kiện trong hộp <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="Accessories-in-the-box hidden">
                    <td>Phụ kiện trong hộp</td>
                    <td>${product1Description.accessoriesInTheBox}</td>
                    <td>${product2Description.accessoriesInTheBox}</td>
                </tr>

                <!-- Mục Thiết kế và trọng lượng -->
                <tr class="section-title" data-toggle="Design-weight">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Thiết kế và trọng lượng <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="Design-weight hidden">
                    <td>Kích thước</td>
                    <td>${product1Description.size}</td>
                    <td>${product2Description.size}</td>
                </tr>

                <tr class="Design-weight hidden">
                    <td>Trọng lượng sản phẩm</td>
                    <td>${product1Description.productWeight}</td>
                    <td>${product2Description.productWeight}</td>
                </tr>

                <tr class="Design-weight hidden">
                    <td>Chất liệu</td>
                    <td>${product1Description.material}</td>
                    <td>${product2Description.material}</td>
                </tr>

                <!-- Mục Thông tin hàng hóa -->
                <tr class="section-title" data-toggle="product-info">
                    <td colspan="3" style="font-weight: bold; cursor: pointer;">
                        Thông tin hàng hóa <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="product-info hidden">
                    <td>P/N</td>
                    <td>${product1Description.pnProductCode}</td>
                    <td>${product2Description.pnProductCode}</td>
                </tr>

                <tr class="product-info hidden">
                    <td>Xuất xứ</td>
                    <td>${product1Description.origin}</td>
                    <td>${product2Description.origin}</td>
                </tr>
                <tr class="product-info hidden">
                    <td>Thời gian bảo hành</td>
                    <td>${product1Description.warrantyPeriodMonths} tháng</td>
                    <td>${product2Description.warrantyPeriodMonths} tháng</td>
                </tr>

                <tr class="product-info hidden">
                    <td>Hướng dẫn bảo quản</td>
                    <td>${product1Description.storageInstructions} </td>
                    <td>${product2Description.storageInstructions} </td>
                </tr>
                <tr class="product-info hidden">
                    <td>Hướng dẫn sử dụng</td>
                    <td>${product1Description.userManual} </td>
                    <td>${product2Description.userManual} </td>
                </tr>
                <tr class="product-info hidden">
                    <td>Màu sắc</td>
                    <td>${product1Description.color}</td>
                    <td>${product2Description.color}</td>
                </tr>
            `;
}

// Hàm để hiển thị thông số nổi bật
function showHighlightSpecs() {
  document.getElementById('highlight-specs').classList.remove('hidden');
  document.getElementById('all-specs').classList.add('hidden');
  document.getElementById('highlight-btn').classList.add('active');
  document.getElementById('all-spec-btn').classList.remove('active');
}

// Hàm để hiển thị tất cả thông số
function showAllSpecs() {
  document.getElementById('all-specs').classList.remove('hidden');
  document.getElementById('highlight-specs').classList.add('hidden');
  document.getElementById('all-spec-btn').classList.add('active');
  document.getElementById('highlight-btn').classList.remove('active');
}

// Thêm sự kiện click cho các nút hiển thị
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('highlight-btn').addEventListener('click', showHighlightSpecs);
  document.getElementById('all-spec-btn').addEventListener('click', showAllSpecs);

  // Mặc định hiển thị thông số nổi bật khi tải trang
  showHighlightSpecs(); 
});

// Mở rộng/thu gọn các mục trong bảng thông số
document.addEventListener('click', function (event) {
  if (event.target.closest('.section-title')) {
      const section = event.target.closest('.section-title');
      const sectionClass = section.getAttribute('data-toggle');
      const rows = document.querySelectorAll(`.${sectionClass}`);
      const arrow = section.querySelector('.arrow');

      // Ẩn/hiện các hàng có liên quan
      rows.forEach(row => row.classList.toggle('hidden'));

      // Đổi mũi tên
      if (arrow.getAttribute('data-direction') === 'down') {
          arrow.textContent = '▲';
          arrow.setAttribute('data-direction', 'up');
      } else {
          arrow.textContent = '▼';
          arrow.setAttribute('data-direction', 'down');
      }
  }
});


