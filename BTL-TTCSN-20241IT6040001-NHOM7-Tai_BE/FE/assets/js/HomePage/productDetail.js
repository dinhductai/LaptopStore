document.addEventListener('DOMContentLoaded', function () {
    // Lấy ProductID từ URL
    const params = new URLSearchParams(window.location.search);
    const productId = params.get('id'); // Lấy giá trị của tham số id từ URL
    const apiUrl = `http://localhost:8080/user/product?id=${productId}`;
    if (productId) {
      // Gọi API để lấy tất cả sản phẩm
      fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
          // Tìm sản phẩm có ProductID khớp với giá trị từ URL
          const product = data[0];
          console.log('thông tin sản phẩm ', product);
          displayProductDetails(product);
          displayProductDescriptions(product)
        })
        .catch(error => console.error('Error fetching product details:', error));
    }
  }); // Đóng hàm addEventListener
  

function displayProductDetails(product) {
    document.getElementById('product-name').textContent = product.productName;
    document.getElementById('product-name-breadcrumb').textContent = product.productName; // Hiển thị tên trong breadcrumb
    document.getElementById('product-image').src = product.imageUrl;
    document.getElementById('product-status').textContent = "Tình Trạng: Còn hàng"; // Sửa lại id ở đây
    document.getElementById('product-price').textContent = `Giá: ${(product.price).toLocaleString('vi-VN')} VND`;
  }

function displayProductDescriptions(productDescription) {
    const tableBody = document.querySelector('#highlight-specs tbody');
    tableBody.innerHTML = '';

  // Thêm các thông số vào bảng
  tableBody.innerHTML += `
    <tr>
      <td>Công nghệ CPU</td>
      <td>${productDescription.cpuCompany}</td>
    </tr>
    <tr>
      <td>Dung lượng RAM</td>
      <td>${productDescription.ramCapacity} GB</td>
    </tr>
    <tr>
      <td>Card đồ họa</td>
      <td>${productDescription.vgaFullName}</td>
    </tr>
    <tr>
      <td>Kích thước màn hình</td>
      <td>${productDescription.screenSize} inch</td>
    </tr>
  `;
    const specsTable = document.getElementById('all-specs');
            specsTable.innerHTML = ''; // Xóa nội dung cũ

            // Tạo các hàng trong bảng với thông tin sản phẩm
            specsTable.innerHTML += `
                <tr class="section-title" data-toggle="cpu">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Bộ xử lý <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="cpu hidden">
                    <td>Hãng CPU</td>
                    <td>${productDescription.cpuCompany}</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Công nghệ CPU</td>
                    <td>${productDescription.cpuTechnology}</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Loại CPU</td>
                    <td>${productDescription.cpuType}</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Tốc độ CPU (tối thiểu)</td>
                    <td>${productDescription.minimumCPUspeed} GHz</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Tốc độ CPU (tối đa)</td>
                    <td>${productDescription.maximunSpeed} GHz</td>
                </tr>
                <tr class="cpu hidden">
                    <td>Nhân CPU</td>
                    <td>${productDescription.multiplier} GHz</td>
                </tr>
                 <tr class="cpu hidden">
                    <td>Bộ nhớ đệm</td>
                    <td>${productDescription.processorCache} GHz</td>
                </tr>



                 <!-- Mục Đồ họa -->
                <tr class="section-title" data-toggle="graphics">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Đồ họa <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr> 

                <tr class="graphics hidden">
                    <td>Hãng (Card Oboard)</td>
                    <td>${productDescription.brandCardOboard}</td>
                </tr>

                <tr class="graphics hidden">
                    <td>Model (Card Oboard)</td>
                    <td>${productDescription.modelCardOboard}</td>
                </tr>

                <tr class="graphics hidden">
                    <td>Tên đầy đủ (Card onbroad)</td>
                    <td>${productDescription.fullNameCardOboard}</td>
                </tr>
                <tr class="graphics hidden">
                    <td>Card VGA</td>
                    <td>${productDescription.vgaFullName}</td>
                </tr>

               

                <!-- Mục RAM -->
                <tr class="section-title" data-toggle="ram">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        RAM <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="ram hidden">
                    <td>Dung lượng RAM</td>
                    <td>${productDescription.ramCapacity} GB</td>
                </tr>
                <tr class="ram hidden">
                    <td>Loại RAM</td>
                    <td>${productDescription.ramType}</td>
                </tr>
                <tr class="ram hidden">
                    <td>Tốc độ RAM</td>
                    <td>${productDescription.ramSpeed}</td>
                </tr>


                 <tr class="ram hidden">
                    <td>Số khe cắm rời</td>
                    <td>${productDescription.numberOfRemovableSlots} </td>
                </tr>

                <tr class="ram hidden">
                    <td>Số RAM onboard</td>
                    <td>${productDescription.numberOfOnboardRAM} </td>
                </tr>

                <tr class="ram hidden">
                    <td>Hỗ trợ RAM tối đa</td>
                    <td>${productDescription.maximumRAMSupport} GB </td>
                </tr>

                <!-- Mục Lưu trữ -->
                <tr class="section-title" data-toggle="storage">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Lưu trữ <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="storage hidden">
                    <td>Kiểu ổ cứng</td>
                    <td>${productDescription.hardDriveType}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Kiểu ổ cứng</td>
                    <td>${productDescription.totalSSDHDDSlots}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Số khe SSD/HDD còn lại</td>
                    <td>${productDescription.numberOfSSDHDDSlotsRemaining}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Dung lượng nâng cấp tối đa ổ cứng</td>
                    <td>${productDescription.maximumHardDriveUpgradeCapacity}</td>
                </tr>

                <tr class="storage hidden">
                    <td>Dung lượng ổ cứng</td>
                    <td>${productDescription.capacity} GB</td>
                </tr>
              

                <!-- Mục Màn hình -->
                <tr class="section-title" data-toggle="screen">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Màn hình <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="screen hidden">
                    <td>Kích thước màn hình</td>
                    <td>${productDescription.screenSize} inch</td>
                </tr>
                <tr class="screen hidden">
                    <td>Công nghệ màn hình</td>
                    <td>${productDescription.displayTechnology}</td>
                </tr>
                <tr class="screen hidden">
                    <td>Độ phân giải</td>
                    <td>${productDescription.resolution}</td>
                </tr>
               

                <tr class="screen hidden">
                    <td>Loại màn hình</td>
                    <td>${productDescription.screenType}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Tần số quét</td>
                    <td>${productDescription.scanningFrequency}</td>
                </tr>

                
                <tr class="screen hidden">
                    <td>Tấm nền</td>
                    <td>${productDescription.basePlate}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Độ sáng</td>
                    <td>${productDescription.brightness}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Độ phủ màu</td>
                    <td>${productDescription.colorCoverage}</td>
                </tr>

                <tr class="screen hidden">
                    <td>Tỷ lệ màn hình</td>
                    <td>${productDescription.screenRatio}</td>
                </tr>

                <!-- Mục Giao tiếp và kết nối -->
                <tr class="section-title" data-toggle="connectivity">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Giao tiếp và kết nối <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="connectivity hidden">
                    <td>Cổng giao tiếp</td>
                    <td>${productDescription.communicationPort}</td>
                </tr>
                <tr class="connectivity hidden">
                    <td>Wi-Fi</td>
                    <td>${productDescription.wifi}</td>
                </tr>
                <tr class="connectivity hidden">
                    <td>Bluetooth</td>
                    <td>${productDescription.bluetooth}</td>
                </tr>

                <tr class="connectivity hidden">
                    <td>Webcam</td>
                    <td>${productDescription.webcam}</td>
                </tr>

                <!-- Mục Hệ điều hành -->
                <tr class="section-title" data-toggle="os">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Hệ điều hành <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="os hidden">
                    <td>Tên hệ điều hành</td>
                    <td>${productDescription.os}</td>
                </tr>
                <tr class="os hidden">
                    <td>Version</td>
                    <td>${productDescription.version}</td>
                </tr>

                <!-- Mục Bảo mật -->
                <tr class="section-title" data-toggle="security">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Bảo mật <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="security hidden">
                    <td>Bảo mật hệ thống</td>
                    <td>${productDescription.security}</td>
                </tr>

                <!-- Mục  Bàn phím & TouchPad -->
                <tr class="section-title" data-toggle="Keyboard-TouchPad">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Bàn phím & TouchPad <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>

                <tr class="Keyboard-TouchPad hidden">
                    <td>Kiểu bàn phím</td>
                    <td>${productDescription.keyboardType}</td>
                </tr>

                <tr class="Keyboard-TouchPad hidden">
                    <td>Bàn phím số</td>
                    <td>${productDescription.numericKeypad}</td>
                </tr>

                <tr class="Keyboard-TouchPad hidden">
                    <td>Đèn bàn phím</td>
                    <td>${productDescription.keyboardLight}</td>
                </tr>

                 <tr class="Keyboard-TouchPad hidden">
                    <td>TouchPad</td>
                    <td>${productDescription.touchPad}</td>
                </tr>

                <!-- Mục  Thông tin pin & sạc -->
                <tr class="section-title" data-toggle="Battery-charging">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Thông tin pin & sạc<span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>

                <tr class="Battery-charging hidden">
                    <td>Loại pin</td>
                    <td>${productDescription.batteryType}</td>
                </tr>

                 <tr class="Battery-charging hidden">
                    <td>Dung lượng pin</td>
                    <td>${productDescription.batteryCapacity} mAh</td>
                </tr>

                 <tr class="Battery-charging hidden">
                    <td>Power Supply</td>
                    <td>${productDescription.powerSupply}</td>
                </tr>

                <!-- Mục Phụ kiện trong hộp -->
                <tr class="section-title" data-toggle="Accessories-in-the-box">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Phụ kiện trong hộp <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="Accessories-in-the-box hidden">
                    <td>Phụ kiện trong hộp</td>
                    <td>${productDescription.accessoriesInTheBox}</td>
                </tr>

                <!-- Mục Thiết kế và trọng lượng -->
                <tr class="section-title" data-toggle="Design-weight">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Thiết kế và trọng lượng <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="Design-weight hidden">
                    <td>Kích thước</td>
                    <td>${productDescription.size}</td>
                </tr>

                <tr class="Design-weight hidden">
                    <td>Trọng lượng sản phẩm</td>
                    <td>${productDescription.productWeight}</td>
                </tr>

                <tr class="Design-weight hidden">
                    <td>Chất liệu</td>
                    <td>${productDescription.material}</td>
                </tr>

                <!-- Mục Thông tin hàng hóa -->
                <tr class="section-title" data-toggle="product-info">
                    <td colspan="2" style="font-weight: bold; cursor: pointer;">
                        Thông tin hàng hóa <span class="arrow" data-direction="down">▼</span>
                    </td>
                </tr>
                <tr class="product-info hidden">
                    <td>P/N</td>
                    <td>${productDescription.pnProductCode}</td>
                </tr>

                <tr class="product-info hidden">
                    <td>Xuất xứ</td>
                    <td>${productDescription.origin}</td>
                </tr>
                <tr class="product-info hidden">
                    <td>Thời gian bảo hành</td>
                    <td>${productDescription.warrantyPeriodMonths} tháng</td>
                </tr>

                <tr class="product-info hidden">
                    <td>Hướng dẫn bảo quản</td>
                    <td>${productDescription.storageInstructions} </td>
                </tr>
                <tr class="product-info hidden">
                    <td>Hướng dẫn sử dụng</td>
                    <td>${productDescription.userManual} </td>
                </tr>
                <tr class="product-info hidden">
                    <td>Màu sắc</td>
                    <td>${productDescription.color}</td>
                </tr>
            `;
  }

 // Hàm để hiển thị thông số nổi bật
        function showHighlightSpecs() {
            console.log("showHighlightSpecs called"); // Ghi log khi gọi hàm
            document.getElementById('highlight-specs').classList.remove('hidden');
            document.getElementById('all-specs').classList.add('hidden');
            document.getElementById('highlight-btn').classList.add('active');
            document.getElementById('all-spec-btn').classList.remove('active');
        }

        // Hàm để hiển thị tất cả thông số
        function showAllSpecs() {
            console.log("showAllSpecs called"); // Ghi log khi gọi hàm
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
          showHighlightSpecs(); // Gọi hàm để hiển thị thông số nổi bật
        });

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
        


