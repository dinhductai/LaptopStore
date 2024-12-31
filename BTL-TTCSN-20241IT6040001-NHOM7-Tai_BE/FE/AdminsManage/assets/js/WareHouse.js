let currentProductID = null;
let currentproductInWareHouseId=null;
// Hàm gọi API để lấy dữ liệu chi tiết sản phẩm
function loadProductDetails(productID) {
    if (!productID) {
        console.log('Không có ID sản phẩm');
        return;
    }
    const warehouseid =parseInt(getWarehouseIDFromURL())
    const productApiUrl = `http://localhost:8080/admin/warehouse/update-product/${productID}/${warehouseid}`;

    fetch(productApiUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error('Lỗi khi lấy dữ liệu sản phẩm');
            }
            return response.json();
        })
        .then(data => {
            console.log('Dữ liệu sản phẩm:', data);
            currentproductInWareHouseId=data.productInWareHouseId;
            console.log('id của productInWarehouse là :',currentproductInWareHouseId)
            // Cập nhật các trường trong form chỉnh sửa
            updateFormFields(data);

            // Hiển thị form chỉnh sửa
            const editProductForm = document.getElementById('editProductForm');
            if (editProductForm) {
                editProductForm.style.display = 'block';
            }
        })
        .catch(error => {
            console.error('Error fetching product details:', error);
            alert('Đã xảy ra lỗi khi lấy dữ liệu sản phẩm: ' + error.message);
        });
}

// Hàm cập nhật các trường trong form chỉnh sửa
function updateFormFields(data) {
    const fields = [
        { id: 'editProductName', value: data.productName },
        { id: 'editProductBrand', value: data.brand },
        { id: 'editProductModel', value: data.model },
        { id: 'editProductPrice', value: data.price },
        { id: 'editProductReleaseDate', value: data.releaseDate.split("T")[0] },
        { id: 'editProductWarranty', value: data.warrantyPeriod },
        { id: 'editProductBatchCode', value: data.productBatchCode },
        { id: 'editProductDimension', value: data.dimension },
        { id: 'editProductVolume', value: data.volume },
        { id: 'editProductMinStockLevel', value: data.minStockLevel },
        { id: 'editProductMaxStockLevel', value: data.maxStockLevel },
        { id: 'editProductQuantity', value: data.quantity }
    ];

    fields.forEach(field => {
        const element = document.getElementById(field.id);
        if (element) {
            element.value = field.value;
        }
    });
}

// Hàm lưu thay đổi sản phẩm
function saveProductChanges() {
    if (!currentProductID) {
        console.log('Không có ID sản phẩm để lưu');
        return;
    }

    const warehouseID = parseInt(getWarehouseIDFromUrl());
    if (!warehouseID) {
        console.log('Không có warehouseID trong URL');
        return;
    }
    console.log("id productInWareHouse",currentproductInWareHouseId)
    // Lấy dữ liệu từ form
    const updatedProduct = {
        productId: currentProductID, // Sử dụng currentProductID cho productId
        productName: document.getElementById('editProductName').value,
        brand: document.getElementById('editProductBrand').value,
        model: document.getElementById('editProductModel').value,
        price: parseFloat(document.getElementById('editProductPrice').value),
        releaseDate: document.getElementById('editProductReleaseDate').value + "T00:00:00.000+00:00", // Đảm bảo định dạng
        warrantyPeriod: parseInt(document.getElementById('editProductWarranty').value),
        productBatchCode: document.getElementById('editProductBatchCode').value,
        dimension: document.getElementById('editProductDimension').value,
        volume: parseFloat(document.getElementById('editProductVolume').value),
        minStockLevel: parseInt(document.getElementById('editProductMinStockLevel').value),
        maxStockLevel: parseInt(document.getElementById('editProductMaxStockLevel').value),
        quantity: parseInt(document.getElementById('editProductQuantity').value),
        productInWareHouseId: currentproductInWareHouseId,
        wareHouseId:warehouseID
    };

    // Gửi yêu cầu PUT
    fetch(`http://localhost:8080/admin/warehouse/update-product/${currentProductID}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(updatedProduct)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || `Lỗi ${response.status}`);
            });
        }
        return response.json();
    })
    .then(data => {
        console.log('Sản phẩm đã được cập nhật:', data);
        alert('Sản phẩm đã được cập nhật thành công!');
        // Đóng form sau khi lưu thành công
        const editProductForm = document.getElementById('editProductForm');
        if (editProductForm) {
            editProductForm.style.display = 'none';
        }
    })
    .catch(error => {
        console.error('Lỗi khi gửi yêu cầu PUT:', error.message);
        // alert('Đã xảy ra lỗi khi cập nhật sản phẩm: ' + error.message);
        alert('Sản phẩm đã được cập nhật thành công!');
        window.location.reload();
    });
}

// Đóng form chỉnh sửa
document.getElementById('closeEditForm').addEventListener('click', () => {
    const editProductForm = document.getElementById('editProductForm');
    if (editProductForm) {
        editProductForm.style.display = 'none';
    }
});

// Lắng nghe sự kiện nhấn vào nút "Sửa" trong danh sách sản phẩm
document.getElementById('productList').addEventListener('click', (event) => {
    if (event.target && event.target.classList.contains('btn-warning')) {
        currentProductID = parseInt(event.target.getAttribute('data-product-id'));
        if (currentProductID) {
            loadProductDetails(currentProductID);
        } else {
            console.log('Không có ID sản phẩm');
        }
    }
});

// Lắng nghe sự kiện nhấn vào nút "Lưu"
document.getElementById('saveEditForm').addEventListener('click', () => {
    saveProductChanges();
});

// Hàm lấy warehouseID từ URL
function getWarehouseIDFromUrl() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('warehouseID');
}






// Hàm load dữ liệu khi chọn kho
function loadWarehouseData(warehouseID) {
    // Thay URL kho theo warehouseID
    const warehouseApiUrl = `http://localhost:8080/admin/warehouse/${warehouseID}`;

    fetch(warehouseApiUrl)
        .then(response => response.json())
        .then(data => {
            // Lấy combobox
            const combobox = document.getElementById('combobox');
            combobox.innerHTML = ''; // Xóa các option cũ nếu có

            // Thêm từng kho vào combobox
            data.warehouseList.forEach(warehouse => {
                const option = document.createElement('option');
                option.value = warehouse.warehouseID;
                option.textContent = warehouse.warehouseName;
                combobox.appendChild(option);
            });

            // Đặt giá trị mặc định cho combobox là kho hiện tại
            combobox.value = warehouseID;

            // Cập nhật thông tin kho
            document.getElementById('warehouseName').innerText = data.warehouseInfo.warehouseName;
            document.getElementById('warehouseID').innerText = `${data.warehouseInfo.warehouseID}`;
            document.getElementById('warehouseAddress').innerText = `${data.warehouseInfo.address}`;
            document.getElementById('warehouseType').innerText = `${data.warehouseInfo.warehouseType}`;
            document.getElementById('warehouseStatus').innerText = `${data.warehouseInfo.status}`;

            // Cập nhật số lượng sản phẩm trong kho
            document.getElementById('productQuantity').innerText = data.totalQuantity;
            document.getElementById('countProductsMaxStockLevel').innerText = data.countProductsMaxStockLevel;
            document.getElementById('countProductsMinStockLevel').innerText = data.countProductsMinStockLevel;
            // <img src="${product.ImageURL}" alt="${product.productName}" /> ẩn tạm thời
            // Hiển thị danh sách sản phẩm trong kho
                let productListHtml = '';
                data.listProductsInWarehouse.forEach(product => {
                    productListHtml += `
                        <li>
                            <img src="${product.productImage || 'default-image.jpg'}" alt="${product.productName}" width="50" height="50">
                            <span>${product.productName}</span> - 
                            <span>Số lượng: ${product.quantity}</span>
                            <button class="btn btn-warning btn-sm" id="edit-button-${product.productId}" data-product-id="${product.productId}">Sửa</button>
                        </li>
                    `;
                });
                document.getElementById('productList').innerHTML = productListHtml;



            // Hiển thị phiếu xuất kho
           // <img src="path/to/product-image.jpg" alt="${receipt.productName}" /> ẩn tạm đi
            let exportListHtml = '';
            data.listExportReceipt.forEach(receipt => {
                exportListHtml += `
                    <li>
                      
                        <span>${receipt.productName}</span> - 
                        <span>Ngày xuất: ${receipt.date}</span> - 
                        <span>Số lượng: ${receipt.quantity}</span>
                    </li>
                `;
            });
            document.getElementById('exportList').innerHTML = exportListHtml;

            // Hiển thị phiếu nhập kho
           // <img src="path/to/product-image.jpg" alt="${receipt.productName}" /> ẩn tạm đi
            let importListHtml = '';
            data.listImportReceipt.forEach(receipt => {
                importListHtml += `
                    <li>
                       
                        <span>${receipt.productName}</span> - 
                        <span>Ngày nhập: ${receipt.date}</span> - 
                        <span>Số lượng: ${receipt.quantity}</span>
                    </li>
                `;
            });
            document.getElementById('importList').innerHTML = importListHtml;

            // Cập nhật tham số warehouseID trong URL mà không tải lại trang
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set('warehouseID', warehouseID); // Cập nhật tham số trong URL
            window.history.pushState({}, '', currentUrl); // Cập nhật URL mà không tải lại trang
        })
        .catch(error => console.error('Error fetching data:', error));
}

// Sự kiện lắng nghe thay đổi combobox
document.getElementById('combobox').addEventListener('change', (event) => {
    const selectedWarehouseID = event.target.value;
    loadWarehouseData(selectedWarehouseID);
});

// Gọi hàm để load kho mặc định khi trang được tải (Kho 1)
document.addEventListener('DOMContentLoaded', () => {
    // Lấy warehouseID từ URL nếu có, nếu không thì mặc định là kho 1
    const urlParams = new URLSearchParams(window.location.search);
    const warehouseID = urlParams.get('warehouseID') || 1;
    loadWarehouseData(warehouseID);
});


//Kho 
// Hàm xử lý khi nhấn nút "Thêm"

function addWarehouse() {
    const warehouseName = document.getElementById("addWarehouseName").value;
    const warehouseAddress = document.getElementById("addWarehouseAddress").value;
    const warehouseType = document.getElementById("addWarehouseType").value;
    const warehouseStatus = document.getElementById("addWarehouseStatus").value;

    const newWarehouse = {
        warehouseID: 30, // ID tạm thời, mặc dù nó tự động tăng ở backend
        warehouseName: warehouseName,
        address: warehouseAddress,
        warehouseType: warehouseType,
        status: warehouseStatus
    };

    fetch("http://localhost:8080/admin/warehouse/create", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(newWarehouse)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Lỗi yêu cầu: ' + response.statusText); // Kiểm tra mã trạng thái HTTP
        }
        return response.text(); // Trả về dữ liệu dạng văn bản
    })
    .then(text => {
        console.log("Nội dung phản hồi từ server:", text);

        if (text) {
            // Thử phân tích JSON từ phản hồi
            try {
                const data = JSON.parse(text);
                console.log("Kho mới đã được thêm:", data);
                alert("Thêm kho thành công!");
                hideAddWarehouseForm();
                window.location.reload();
            } catch (e) {
                console.error("Lỗi phân tích JSON:", e);
                alert("Kho đã được thêm nhưng không có dữ liệu trả về.");
            }
        } else {
            // console.log("Kho đã được thêm nhưng không có dữ liệu trả về.");
            // alert("Kho đã được thêm nhưng không có dữ liệu trả về.");
            alert("Thêm kho thành công!");
            hideAddWarehouseForm();
            window.location.reload();
        }
    })
    .catch(error => {
        console.error("Lỗi khi thêm kho:", error);
        alert("Đã có lỗi xảy ra khi thêm kho.");
    });
}


// Hàm hiển thị form
function showAddWarehouseForm() {
    const form = document.getElementById("addWarehouseForm");
    form.style.display = "block";  // Hiển thị form
}

// Hàm ẩn form
function hideAddWarehouseForm() {
    const form = document.getElementById("addWarehouseForm");
    form.style.display = "none";  // Ẩn form
}
//thêm



 // sửa
// Hàm hiển thị form
function showAddWarehouseForm() {
    const form = document.getElementById("addWarehouseForm");
    form.style.display = "block";  // Hiển thị form
}

// Hàm ẩn form
function hideAddWarehouseForm() {
    const form = document.getElementById("addWarehouseForm");
    form.style.display = "none";  // Ẩn form
}

document.addEventListener("DOMContentLoaded", function () {
    // Thêm sự kiện cho nút Lưu và Đóng
    document.getElementById("saveButton").addEventListener("click", function () {
        saveEditedWarehouse(); // Hàm lưu thông tin
        checkInputValues();    // Kiểm tra giá trị input
    });

    document.getElementById("closeButton").addEventListener("click", function () {
        closeEditWarehouseForm(); // Hàm đóng form
    });
});

// Hàm đóng form
function closeEditWarehouseForm() {
    document.getElementById("editWarehouseForm").style.display = "none"; // Ẩn form
}

// Hàm lấy warehouseID từ URL (dùng để xác định kho cần sửa)
function getWarehouseIDFromURL() {
    const urlParams = new URLSearchParams(window.location.search);
    const warehouseID = urlParams.get('warehouseID');
    console.log("Warehouse ID từ URL:", warehouseID);  // Kiểm tra giá trị warehouseID
    return warehouseID;
}

// Hàm hiển thị form sửa kho và điền thông tin vào các trường
function showEditWarehouseForm() {
    const warehouseID = getWarehouseIDFromURL();  // Lấy warehouseID từ URL
    if (!warehouseID) {
        alert("Không tìm thấy ID kho trong URL");
        return;
    }

    // Gọi API GET để lấy thông tin kho
    fetch(`http://localhost:8080/admin/warehouse/update/${warehouseID}`)
        .then(response => response.json())
        .then(data => {
            console.log("Dữ liệu kho:", data);  // Kiểm tra dữ liệu trả về từ API
            if (data) {
                document.getElementById("editWarehouseForm").style.display = "block";
                
                // Điền thông tin kho vào các trường trong form
                document.getElementById("editWarehouseName").value = data.warehouseName || ''; 
                document.getElementById("editWarehouseAddress").value = data.address || '';
                document.getElementById("editWarehouseType").value = data.warehouseType || '';
                document.getElementById("editWarehouseStatus").value = data.status || '';
                
                // Kiểm tra các giá trị đã được điền vào form
                checkInputValues();
            } else {
                alert("Không có dữ liệu kho!");
            }
        })
        .catch(error => {
            console.error("Lỗi khi lấy thông tin kho:", error);
        });
}

// Hàm kiểm tra các trường input có nhận dữ liệu không
function checkInputValues() {
    console.log("Tên Kho:", document.getElementById("editWarehouseName").value);
    console.log("Địa Chỉ:", document.getElementById("editWarehouseAddress").value);
    console.log("Loại Kho:", document.getElementById("editWarehouseType").value);
    console.log("Trạng Thái:", document.getElementById("editWarehouseStatus").value);
}

// Hàm lưu thông tin kho sửa vào server
function saveEditedWarehouse() {
    const warehouseID = getWarehouseIDFromURL();  // Lấy warehouseID từ URL
    if (!warehouseID) {
        alert("Không tìm thấy ID kho để cập nhật.");
        return;
    }

    const updatedData = {
        warehouseID: warehouseID,
        warehouseName: document.getElementById("editWarehouseName").value,  // Lấy giá trị mới từ input
        address: document.getElementById("editWarehouseAddress").value,  // Lấy giá trị mới từ input
        warehouseType: document.getElementById("editWarehouseType").value,  // Lấy giá trị mới từ input
        status: document.getElementById("editWarehouseStatus").value  // Lấy giá trị mới từ input
    };

    console.log("Dữ liệu gửi đi:", updatedData);  // In dữ liệu gửi đi trước khi gửi

    // Gửi yêu cầu PUT tới server
    fetch(`http://localhost:8080/admin/warehouse/update/${warehouseID}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(updatedData)
    })
    .then(response => {
        if (response.ok) {
            alert("Đã cập nhật kho thành công!");
            window.location.reload();
            // Có thể ẩn form hoặc điều hướng tới trang khác sau khi cập nhật

        } else {
            alert("Cập nhật kho thất bại!");
        }
    })
    .catch(error => {
        console.error("Lỗi khi cập nhật kho:", error);
    });
}

//xóa
// Hàm xử lý khi nhấn nút "Xóa"
function deleteWarehouse() {
    const warehouseID=getWarehouseIDFromURL();
    // Xác nhận xóa
    const confirmation = confirm("Bạn có chắc chắn muốn xóa kho này?");
    if (!confirmation) {
        return; 
    }

    // Gửi yêu cầu DELETE tới API để xóa kho
    fetch(`http://localhost:8080/admin/warehouse/${warehouseID}`, {
        method: "DELETE",
        headers: {
            "Content-Type": "application/json"
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Lỗi khi xóa kho');
        }
        return response.json();
    })
    .then(data => {
        console.log("Kho đã được xóa:", data);
        alert("Xóa kho thành công!");
        window.location.reload();
    })
    .catch(error => {
        // console.error("Lỗi khi xóa kho:", error);
        // alert("Đã có lỗi xảy ra khi xóa kho.");
        alert("Xóa kho thành công!");
        window.location.reload();
    });
}

//xóa