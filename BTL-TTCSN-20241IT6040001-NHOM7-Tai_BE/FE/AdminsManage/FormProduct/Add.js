let uploadedImagesCache = [];
console.log("link ảnh đang có ở cloud",uploadedImagesCache);
async function addproduct() {
  try {
      // Thu thập dữ liệu từ các trường trong form
      if(idSupplier==null){
        alert('Bạn chưa chọn nhà cung cấp');
        return;
        // location.reload();
      }
      const productImageInput = document.getElementById('productImage');

      // Hàm tính hash của ảnh (sử dụng FileReader)
      async function calculateImageHash(file) {
          return new Promise((resolve, reject) => {
              const reader = new FileReader();
              reader.onload = function () {
                  // Tính hash bằng cách băm nội dung ảnh (arrayBuffer)
                  const arrayBuffer = reader.result;
                  const hash = CryptoJS.MD5(CryptoJS.lib.WordArray.create(arrayBuffer)).toString();
                  resolve(hash);
              };
              reader.onerror = reject;
              reader.readAsArrayBuffer(file);
          });
      }

      // Hàm tải ảnh lên imgBB
      async function uploadImageToImgBB(file) {
          const apiKey = '47d7b1dbc4df2574ecd46a6940f1f7b0'; // Thay bằng API Key của bạn

          const formData = new FormData();
          formData.append('image', file);

          try {
              const response = await fetch(`https://api.imgbb.com/1/upload?key=${apiKey}`, {
                  method: 'POST',
                  body: formData,
              });

              const data = await response.json();
              if (data.success) {
                  return data.data.url; // Trả về URL của ảnh
              } else {
                  console.error('Lỗi tải ảnh lên imgBB:', data.message);
                  return null;
              }
          } catch (error) {
              console.error('Có lỗi khi gửi yêu cầu tới imgBB:', error);
              return null;
          }
      }

      // Tính hash của ảnh
      const imageFile = productImageInput.files[0];
      const imageHash = await calculateImageHash(imageFile);

      // Kiểm tra xem hash đã tồn tại trong cache chưa
      let imageUrl = null;
      const cachedImage = uploadedImagesCache.find(item => item.hash === imageHash);

      if (cachedImage) {
          // Nếu hash đã tồn tại, lấy URL từ cache
          console.log('Ảnh đã tồn tại. Sử dụng URL cũ:', cachedImage.url);
          imageUrl = cachedImage.url;
      } else {
          // Nếu chưa tồn tại, tải ảnh lên imgBB
          imageUrl = await uploadImageToImgBB(imageFile);
          if (!imageUrl) {
              alert('Có lỗi xảy ra khi tải ảnh lên imgBB');
              return;
          }

          // Lưu hash và URL mới vào cache
          uploadedImagesCache.push({ hash: imageHash, url: imageUrl });
      }
      const now = new Date();
      const updatedProduct = {
          productId:null,
          supplierId: idSupplier, // ID nhà cung cấp
          productDescriptionId: null, // ID mô tả sản phẩm
          productName: document.getElementById("productName").value,
          productBrand: document.getElementById("productBrand").value,
          model: document.getElementById("model").value,
          price: parseFloat(document.getElementById("price").value),
          stockQuantity: 0,
          releaseDate: now.toISOString().slice(0, 16),
          warrantyPeriod: document.getElementById("warrantyPeriod").value,
          imageUrl,
          // Các thông số kỹ thuật khác
          cpuCompany: document.getElementById("cpuCompany").value,
          cpuTechnology: document.getElementById("cpuTechnology").value,
          cpuType: document.getElementById("cpuType").value,
          minimumCPUspeed: parseFloat(document.getElementById("minimumCPUspeed").value),
          maximunSpeed: parseFloat(document.getElementById("maximunSpeed").value),
          multiplier: document.getElementById("multiplier").value,
          processorCache: document.getElementById("processorCache").value,
          brandCardOboard: document.getElementById("brandCardOboard").value,
          modelCardOboard: document.getElementById("modelCardOboard").value,
          fullNameCardOboard: document.getElementById("fullNameCardOboard").value,
          vgaBrand: document.getElementById("vgaBrand").value,
          vgaFullName: document.getElementById("vgaFullName").value,
          ramCapacity: parseInt(document.getElementById("ramCapacity").value),
          ramType: document.getElementById("ramType").value,
          ramSpeed: document.getElementById("ramSpeed").value,
          numberOfRemovableSlots: parseInt(document.getElementById("numberOfRemovableSlots").value),
          numberOfOnboardRAM: parseInt(document.getElementById("numberOfOnboardRAM").value),
          maximumRAMSupport: parseInt(document.getElementById("maximumRAMSupport").value),
          hardDriveType: document.getElementById("hardDriveType").value,
          totalSSDHDDSlots: parseInt(document.getElementById("totalSSDHDDSlots").value),
          numberOfSSDHDDSlotsRemaining: parseInt(document.getElementById("numberOfSSDHDDSlotsRemaining").value),
          maximumHardDriveUpgradeCapacity: parseInt(document.getElementById("maximumHardDriveUpgradeCapacity").value),
          ssdType: document.getElementById("ssdType").value,
          capacity: parseInt(document.getElementById("capacity").value),
          screenSize: document.getElementById("screenSize").value,
          displayTechnology: document.getElementById("displayTechnology").value,
          resolution: document.getElementById("resolution").value,
          screenType: document.getElementById("screenType").value,
          scanningFrequency:document.getElementById('scanningFrequency').value,
          basePlate: document.getElementById("basePlate").value,
          brightness: parseInt(document.getElementById("brightness").value),
          colorCoverage: document.getElementById("colorCoverage").value,
          screenRatio: parseInt(document.getElementById("screenRatio").value),
          communicationPort: document.getElementById("communicationPort").value,
          wifi: document.getElementById("wifi").value,
          bluetooth: document.getElementById("bluetooth").value,
          webcam: document.getElementById("webcam").value,
          os: document.getElementById("os").value,
          version: document.getElementById("version").value,
          security: document.getElementById("security").value,
          keyboardType: document.getElementById("keyboardType").value,
          numericKeypad: document.getElementById("numericKeypadTrue").checked ? true : false,
          keyboardLight: document.getElementById("keyboardLight").value,
          touchPad: document.getElementById("touchPad").value,
          batteryType: document.getElementById("batteryType").value,
          batteryCapacity: parseInt(document.getElementById("batteryCapacity").value),
          powerSupply: document.getElementById("powerSupply").value,
          accessoriesInTheBox: document.getElementById("accessoriesInTheBox").value,
          size: parseInt(document.getElementById("size").value),
          productWeight: parseInt(document.getElementById("productWeight").value),
          material: document.getElementById('material').value,
          pnProductCode: document.getElementById("pnProductCode").value,
          origin: document.getElementById("origin").value,
          warrantyPeriodMonths: parseInt(document.getElementById("warrantyPeriodMonths").value),
          storageInstructions: document.getElementById("storageInstructions").value,
          userManual: document.getElementById("userManual").value,
          color: document.getElementById("color").value,
      };

      // Gửi yêu cầu POST đến API để thêm sản phẩm mới
      const response = await fetch("http://localhost:8080/admin/product/create", {
          method: "POST",
          headers: {
              "Content-Type": "application/json",
          },
          body: JSON.stringify(updatedProduct), // Dữ liệu cần thêm
      });

      if (!response.ok) {
          const errorDetails = await response.text();  // Lấy thông tin lỗi từ phản hồi
          console.error("Error details:", errorDetails);
          throw new Error("Failed to add product");
      }

      const data = await response.json();

      // Hiển thị thông báo thành công
      alert("Sản phẩm đã được thêm thành công!");

      // Đóng form thêm sản phẩm
      document.getElementById("add-product-form-container").style.display = "none";

      // Làm mới danh sách sản phẩm (nếu có)
      refreshProductList();
  } catch (error) {
      console.error("Lỗi khi thêm sản phẩm:", error);
      alert("Thêm sản phẩm thành công");
      location.reload();
  }
}


// Lắng nghe sự kiện khi người dùng nhấn nút "Thêm Sản phẩm"
document.getElementById("add-product-btn").addEventListener("click", function() {
  // Hiển thị form thêm sản phẩm
  document.getElementById("add-product-form-container").style.display = "block";
});

// Đảm bảo rằng hàm này được gọi khi DOM đã sẵn sàng
document.addEventListener("DOMContentLoaded", function() {
  const submitButton = document.getElementById("submit-btn");
  
  // Lắng nghe sự kiện click trên nút Thêm sản phẩm (submit-btn)
  submitButton.addEventListener("click", async function(event) {
      event.preventDefault();  // Ngừng hành động mặc định (ví dụ: gửi form)
      await addproduct();     // Gọi hàm addproduct
  });
});

// Lấy đối tượng select
const supplierSelect = document.getElementById("supplier-select");

// Lắng nghe sự kiện thay đổi của combobox
supplierSelect.addEventListener("change", function () {
    // Lấy giá trị supplierID đã chọn
    const supplierID = supplierSelect.value;

    // Kiểm tra và in ra ID đã chọn
    if (supplierID) {
        console.log("Chọn Nhà Cung Cấp ID:", supplierID);
        idSupplier = supplierID;  // Lưu lại idSupplier để sử dụng trong các API khác
    } else {
        console.log("Chưa chọn nhà cung cấp");
        alert('Bạn chưa chọn nhà cung cấp sản phẩm');
        return;
        
    }
});

// Lắng nghe sự kiện khi người dùng nhấn nút "Hủy"
document.getElementById("cancel-btn").addEventListener("click", function() {
    // Ẩn form thêm sản phẩm
    document.getElementById("add-product-form-container").style.display = "none";
});
