// Function to open the edit product form and populate it with data
function editProduct(productId) {

  fetch(`http://localhost:8080/admin/product/update/${productId}`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => {
      const productDetail=data.productDetail[0];
      // Điền thông tin vào các trường trong form sửa
      idProduct= productDetail.productId;
      idProductDes= productDetail.productDescriptionId;
      idSupplier= productDetail.supplierId;
      console.log('id product :',idProduct);
      console.log('id productDes :',idProductDes);
      console.log('id productSuppiler :',idSupplier);
      
      document.getElementById("edit-productName").value = productDetail.productName;
      document.getElementById("edit-productBrand").value = productDetail.productBrand;
      document.getElementById("edit-model").value = productDetail.model;
      document.getElementById("edit-price").value = productDetail.price;
      document.getElementById("edit-stockQuantity").value =
        productDetail.stockQuantity;
      document.getElementById("edit-releaseDate").value = productDetail.releaseDate;
      document.getElementById("edit-warrantyPeriod").value =
        productDetail.warrantyPeriod;
      // document.getElementById("edit-imageUrl").value = productDetail.imageUrl;

      // Điền thông tin CPU, RAM, ổ cứng, màn hình...
      document.getElementById("edit-cpuCompany").value = productDetail.cpuCompany;
      document.getElementById("edit-cpuTechnology").value =
        productDetail.cpuTechnology;
      document.getElementById("edit-cpuType").value = productDetail.cpuType;
      document.getElementById("edit-minimumCPUspeed").value =
        productDetail.minimumCPUspeed;
      document.getElementById("edit-maximunSpeed").value = productDetail.maximunSpeed;
      document.getElementById("edit-multiplier").value = productDetail.multiplier;
      document.getElementById("edit-processorCache").value =
        productDetail.processorCache;
      document.getElementById("edit-brandCardOboard").value =
        productDetail.brandCardOboard;
      document.getElementById("edit-modelCardOboard").value =
        productDetail.modelCardOboard;
      document.getElementById("edit-fullNameCardOboard").value =
        productDetail.fullNameCardOboard;
      document.getElementById("edit-vgaBrand").value = productDetail.vgaBrand;
      document.getElementById("edit-vgaFullName").value = productDetail.vgaFullName;

      document.getElementById("edit-ramCapacity").value = productDetail.ramCapacity;
      document.getElementById("edit-ramType").value = productDetail.ramType;
      document.getElementById("edit-ramSpeed").value = productDetail.ramSpeed;
      document.getElementById("edit-numberOfRemovableSlots").value =
        productDetail.numberOfRemovableSlots;
      document.getElementById("edit-numberOfOnboardRAM").value =
        productDetail.numberOfOnboardRAM;
      document.getElementById("edit-maximumRAMSupport").value =
        productDetail.maximumRAMSupport;
      document.getElementById("edit-totalSSDHDDSlots").value =
        productDetail.totalSSDHDDSlots;
      document.getElementById("edit-numberOfSSDHDDSlotsRemaining").value =
        productDetail.numberOfSSDHDDSlotsRemaining;

      document.getElementById("edit-maximumHardDriveUpgradeCapacity").value =
        productDetail.maximumHardDriveUpgradeCapacity;

      document.getElementById("edit-ssdType").value = productDetail.ssdType;

      document.getElementById("edit-hardDriveType").value =
        productDetail.hardDriveType;
      document.getElementById("edit-capacity").value = productDetail.capacity;

      document.getElementById("edit-screenSize").value = productDetail.screenSize;

      document.getElementById("edit-displayTechnology").value =
        productDetail.displayTechnology;
      document.getElementById("edit-resolution").value = productDetail.resolution;

      document.getElementById("edit-screenType").value = productDetail.screenType;

      document.getElementById("edit-scanningFrequency").value =
        productDetail.scanningFrequency;
      document.getElementById("edit-basePlate").value = productDetail.basePlate;

      document.getElementById("edit-colorCoverage").value =
        productDetail.colorCoverage;

      document.getElementById("edit-screenRatio").value = productDetail.screenRatio;

      document.getElementById("edit-os").value = productDetail.os;

      document.getElementById("edit-version").value = productDetail.version;

      document.getElementById("edit-security").value = productDetail.security;

      document.getElementById("edit-keyboardType").value = productDetail.keyboardType;
      if (productDetail.numericKeypad === true) {
        document.getElementById("edit-numericKeypadTrue").checked = true;
      } else if (productDetail.numericKeypad === false) {
        document.getElementById("edit-numericKeypadFalse").checked = true;
      }

      document.getElementById("edit-keyboardLight").value =
        productDetail.keyboardLight;

      document.getElementById("edit-touchPad").value = productDetail.touchPad;

      document.getElementById("edit-powerSupply").value = productDetail.powerSupply;
      document.getElementById("edit-communicationPort").value =
        productDetail.communicationPort;

      document.getElementById("edit-size").value = productDetail.size;

      document.getElementById("edit-productWeight").value =
        productDetail.productWeight;

      document.getElementById("edit-material").value = productDetail.material;
      document.getElementById("edit-wifi").value = productDetail.wifi;
      document.getElementById("edit-bluetooth").value = productDetail.bluetooth;
      document.getElementById("edit-webcam").value = productDetail.webcam;

      document.getElementById("edit-batteryType").value = productDetail.batteryType;
      document.getElementById("edit-batteryCapacity").value =
        productDetail.batteryCapacity;
      document.getElementById("edit-accessoriesInTheBox").value =
        productDetail.accessoriesInTheBox;

      document.getElementById("edit-color").value =productDetail.color;
      document.getElementById("edit-origin").value = productDetail.origin;
      document.getElementById("edit-pnProductCode").value =
      productDetail.pnProductCode;

      document.getElementById("edit-warrantyPeriodMonths").value =
        productDetail.warrantyPeriodMonths;

      document.getElementById("edit-storageInstructions").value =
        productDetail.storageInstructions;

      document.getElementById("edit-userManual").value = productDetail.userManual;

      document.getElementById("edit-brightness").value = productDetail.brightness;

      // Hiển thị form sửa
      document.getElementById("edit-product-form-container").style.display =
        "block";
      document.getElementById(
        "edit-form-title"
      ).textContent = `Sửa sản phẩm: ${productDetail.productName}`;
    })
    .catch((error) => {
      console.error("Error fetching product data:", error);
    });
}

// // Lấy đối tượng select
// const supplierSelect = document.getElementById("supplier-select");

// // Lắng nghe sự kiện thay đổi của combobox
// supplierSelect.addEventListener("change", function () {
//     // Lấy giá trị supplierID đã chọn
//     const supplierID = supplierSelect.value;

//     // Kiểm tra và in ra ID đã chọn
//     if (supplierID) {
//         console.log("Chọn Nhà Cung Cấp ID:", supplierID);
//         idSupplier = supplierID;  // Lưu lại idSupplier để sử dụng trong các API khác
//     } else {
//         console.log("Chưa chọn nhà cung cấp");
//     }
// });

let idSupplier = null;
let idProduct = null;
let idProductDes = null;

// In ra để kiểm tra giá trị của supplierID
console.log("Supplier ID:", idSupplier);  // Kiểm tra giá trị của supplierID
// Function to close the form
document
  .getElementById("cancel-edit-btn")
  .addEventListener("click", function () {
    document.getElementById("edit-product-form-container").style.display =
      "none";
  });

  async function saveProduct(productId) {
    try {
        console.log('id product trước khi update :',idProduct);
        console.log('id productDes trước khi update  :',idProductDes);
        console.log('id productSuppiler  trước khi update :',idSupplier);
      // Thu thập dữ liệu từ các trường trong form sửa
      const productImageInputEdit = document.getElementById('edit-productImage');

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
      const imageFile = productImageInputEdit.files[0];
      if (!imageFile) {
        alert('Bạn chưa chọn ảnh. Vui lòng chọn ảnh trước khi lưu.');
        return; // Dừng xử lý nếu không có ảnh
    }
      const imageHash = await calculateImageHash(imageFile);

      // Kiểm tra xem hash đã tồn tại trong cache chưa
      let imageUrlEdit = null;
      const cachedImage = uploadedImagesCache.find(item => item.hash === imageHash);

      if (cachedImage) {
          // Nếu hash đã tồn tại, lấy URL từ cache
          console.log('Ảnh đã tồn tại. Sử dụng URL cũ:', cachedImage.url);
          imageUrlEdit = cachedImage.url;
      } else {
          // Nếu chưa tồn tại, tải ảnh lên imgBB
          imageUrlEdit = await uploadImageToImgBB(imageFile);
          if (!imageUrlEdit) {
              alert('Có lỗi xảy ra khi tải ảnh lên imgBB');
              return;
          }

          // Lưu hash và URL mới vào cache
          uploadedImagesCache.push({ hash: imageHash, url: imageUrlEdit });
      }
      console.log("link ảnh đang có ở cloud",uploadedImagesCache);
      console.log("link ảnh để PUT",imageUrlEdit);

      const updatedProduct = {
        productId:idProduct,
        supplierId:idSupplier,
        productDescriptionId:idProductDes,
        productName: document.getElementById("edit-productName").value,
        productBrand: document.getElementById("edit-productBrand").value,
        model: document.getElementById("edit-model").value,
        price: parseFloat(document.getElementById("edit-price").value),
        stockQuantity: parseInt(
          document.getElementById("edit-stockQuantity").value
        ),
        releaseDate: document.getElementById("edit-releaseDate").value,
        warrantyPeriod: document.getElementById("edit-warrantyPeriod").value,
        imageUrl: imageUrlEdit,
        // Các thông số kỹ thuật khác
        cpuCompany: document.getElementById("edit-cpuCompany").value,
        cpuTechnology: document.getElementById("edit-cpuTechnology").value,
        cpuType: document.getElementById("edit-cpuType").value,
        minimumCPUspeed: parseFloat(
          document.getElementById("edit-minimumCPUspeed").value
        ),
        maximunSpeed: parseFloat(
          document.getElementById("edit-maximunSpeed").value
        ),
        multiplier: document.getElementById("edit-multiplier").value,
        processorCache: document.getElementById("edit-processorCache").value,
        brandCardOboard: document.getElementById("edit-brandCardOboard").value,
        modelCardOboard: document.getElementById("edit-modelCardOboard").value,
        fullNameCardOboard: document.getElementById(
          "edit-fullNameCardOboard"
        ).value,
        vgaBrand: document.getElementById("edit-vgaBrand").value,
        vgaFullName: document.getElementById("edit-vgaFullName").value,
        ramCapacity: parseInt(document.getElementById("edit-ramCapacity").value),
        ramType: document.getElementById("edit-ramType").value,
        ramSpeed: document.getElementById("edit-ramSpeed").value,
        numberOfRemovableSlots: parseInt(
          document.getElementById("edit-numberOfRemovableSlots").value
        ),
        numberOfOnboardRAM: parseInt(
          document.getElementById("edit-numberOfOnboardRAM").value
        ),
        maximumRAMSupport: parseInt(
          document.getElementById("edit-maximumRAMSupport").value
        ),
        // Các trường bổ sung
        numericKeypad: document.getElementById("edit-numericKeypadTrue").checked
          ? true
          : false,
        brightness: parseInt(document.getElementById("edit-brightness").value),
        hardDriveType:document.getElementById("edit-hardDriveType").value,
        totalSSDHDDSlots: parseInt(
            document.getElementById("edit-totalSSDHDDSlots").value
          ),

          
          numberOfSSDHDDSlotsRemaining: parseInt(
            document.getElementById("edit-numberOfSSDHDDSlotsRemaining").value
          ),
          
          maximumHardDriveUpgradeCapacity: parseInt(
            document.getElementById("edit-maximumHardDriveUpgradeCapacity").value
          ),
          ssdType:document.getElementById("edit-ssdType").value,
          
          capacity: parseInt(
            document.getElementById("edit-capacity").value
          ),
          screenSize:document.getElementById("edit-screenSize").value,
          displayTechnology:document.getElementById("edit-displayTechnology").value,
          resolution:document.getElementById("edit-resolution").value,
          screenType:document.getElementById("edit-screenType").value,
          basePlate:document.getElementById("edit-basePlate").value,
          colorCoverage:document.getElementById("edit-colorCoverage").value,
          screenRatio: parseInt(
            document.getElementById("edit-screenRatio").value
          ),
          communicationPort:document.getElementById("edit-communicationPort").value,
          wifi:document.getElementById("edit-wifi").value,
          bluetooth:document.getElementById("edit-bluetooth").value,
          webcam:document.getElementById("edit-webcam").value,
          os:document.getElementById("edit-os").value,
          version:document.getElementById("edit-version").value,
          security:document.getElementById("edit-security").value,
          keyboardType:document.getElementById("edit-keyboardType").value,
          keyboardLight:document.getElementById("edit-keyboardLight").value,
          touchPad:document.getElementById("edit-touchPad").value,
          batteryType:document.getElementById("edit-batteryType").value,
          batteryCapacity:parseInt(
            document.getElementById("edit-batteryCapacity").value
          ),
          powerSupply:document.getElementById("edit-powerSupply").value,
          accessoriesInTheBox:document.getElementById("edit-accessoriesInTheBox").value,
          size:parseInt(
            document.getElementById("edit-size").value
          ),
          productWeight:parseInt(
            document.getElementById("edit-productWeight").value
          ),
          material:document.getElementById("edit-material").value,
          pnProductCode:document.getElementById("edit-pnProductCode").value,
          origin:document.getElementById("edit-origin").value,
          warrantyPeriodMonths:parseInt(
            document.getElementById("edit-warrantyPeriodMonths").value
          ),
          storageInstructions:document.getElementById("edit-storageInstructions").value,
          userManual:document.getElementById("edit-userManual").value,
          color:document.getElementById("edit-color").value,

        // Thêm các trường khác theo cấu trúc dữ liệu của bạn
      };
      console.log('sau khi update' ,productId);
      console.log('sau khi update' ,idProductDes);
      console.log('sau khi update',idSupplier);
      // Gửi yêu cầu PUT đến API
      const response = await fetch(
        `http://localhost:8080/admin/product/update/${productId}`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(updatedProduct), // Dữ liệu cần cập nhật
        }
      );
  
      if (!response.ok) {
        const errorDetails = await response.text();  // Lấy thông tin lỗi từ phản hồi
        console.error("Error details:", errorDetails);
        throw new Error("Failed to update product");
    }
  
      const data = await response.json();
  
      // Hiển thị thông báo thành công
      alert("Cập nhật sản phẩm thành công!");
  
      // Đóng form sửa
      document.getElementById("edit-product-form-container").style.display =
        "none";
  
      // Làm mới danh sách sản phẩm (nếu có)
      refreshProductList();
    } catch (error) {
   console.error("Error updating product:", error);
      alert("Đã cập nhật thông tin sản phẩm");
      window.location.reload();
    }
  }
  
  // Gắn sự kiện click vào nút Lưu
  document.getElementById("save-edit-btn").addEventListener("click", async () => {
    const productId = idProduct;
    console.log(productId);
    await saveProduct(productId);
  });
   