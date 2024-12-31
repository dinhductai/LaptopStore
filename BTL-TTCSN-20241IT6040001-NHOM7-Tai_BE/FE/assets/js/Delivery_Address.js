// Lấy token từ localStorage
const token = localStorage.getItem("authToken");
console.log("Token của khách hàng : ", token);
var tokenRequest = decodeJWT(token);

function decodeJWT(token) {
  const base64Url = token.split('.')[1]; // Lấy phần payload (phần giữa)
  const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
  const jsonPayload = decodeURIComponent(
    atob(base64)
      .split('')
      .map(c => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
      .join('')
  );
  return JSON.parse(jsonPayload);
}

async function fetchUserInfo() {
  // Lấy token từ localStorage
  console.log("Token decode : ", decodeJWT(token))

  var tokenRequest = decodeJWT(token)
  console.log("....")
  console.log("Token id user : ", tokenRequest['id-user'])

  if (!token) {
    console.error("Token không tồn tại. Vui lòng đăng nhập trước.");
    return;
  }

  try {
    // Thêm tham số id-user vào URL
    const userId = tokenRequest['id-user'];
    const response = await fetch(`http://localhost:8080/user/myInfor?id=${userId}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
      },
    });

    // Xử lý phản hồi
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    console.log("User information: ", data);
    // Hiển thị thông tin tài khoản trong console
    document.getElementById("inner-user-name").innerHTML = data.fullName
    document.getElementById("inner-user-phoneNumber").innerHTML = data.phoneNumber
  } catch (error) {
    console.error("Error fetching user information: ", error);
  }

}

// Hiển thị danh sách địa chỉ giao hàng
function GetShippingAddress() {
  try {
    const cusID = tokenRequest['id-customer'];
    fetch(`http://localhost:8080/user/shipping-address?customerID=${cusID}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then(response => response.json())
      .then(function renderShippingAddress(ShippingAddress) {
        const listShippingAddressBlock = document.querySelector('#list-shipping-address');
        const htmls = ShippingAddress.map(function (place) {
          return `
            <li class="shipping-address-item" style="margin-top: 1%;">
              <div class="wrapper-address d-flex justify-content-between align-items-center">
                <div class="box-thong-tin-dia-chi d-flex align-items-center">
                  <div class="box-item-icon-house">
                    <i class="fa-solid fa-house fa-3x"></i>
                  </div>
                  <div class="box-item-infor-address" style="margin-left: 2%;">
                    <h6>Số điện thoại người nhận : <span class="sdt-nguoi-nhan">${place.phoneNumber}</span></h6>
                    <h6>Địa chỉ chi tiết : <span class="dia-chi-nguoi-nhan">${place.address} , ${place.city} , ${place.district} , ${place.streetAddress} , ${place.ward}</span></h6>
                  </div>
                </div>

                <div class="box2">
                  <div class="box-chuc-nang d-flex align-items-center">
                    <button class="btn btn-success" style="width: 100px; height: 40px;" onclick="openEditModal(${place.addressID}, '${place.address}', '${place.city}', '${place.district}', '${place.ward}', '${place.streetAddress}')">Sửa</button>
                    <button class="btn btn-warning" style="width: 100px; height: 40px;" onclick="XoaDiaChiNhanHang(${place.addressID})">Xóa</button>
                  </div>
                </div>
              </div>
            </li>
          `;
        });
        listShippingAddressBlock.innerHTML = htmls.join('');
      })
      .catch(err => console.error('Lỗi khi lấy danh sách địa chỉ:', err));
  } catch (err) {
    console.error(err);
  }
}

// Hiển thị modal thêm địa chỉ
function themDiaChi() {
  const addressModal = new bootstrap.Modal(document.getElementById('addressModal'));
  addressModal.show();
}

// Lưu địa chỉ mới
function luuDiaChi() {
  const address = document.getElementById("address").value;
  const city = document.getElementById("city").value;
  const district = document.getElementById("district").value;
  const ward = document.getElementById("ward").value;
  const streetAddress = document.getElementById("streetAddress").value;

  const cusID = tokenRequest['id-customer'];

  fetch(`http://localhost:8080/user/add-shipping-address/${cusID}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({ address, city, district, ward, streetAddress }),
  })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      alert('Địa chỉ đã được thêm thành công');
      location.reload();
    })
    .catch(error => console.error('Lỗi khi thêm địa chỉ:', error));
}

// Hiển thị modal sửa địa chỉ
function openEditModal(addressID, address, city, district, ward, streetAddress) {
  document.getElementById("editAddressID").value = addressID;
  document.getElementById("editAddress").value = address;
  document.getElementById("editCity").value = city;
  document.getElementById("editDistrict").value = district;
  document.getElementById("editWard").value = ward;
  document.getElementById("editStreetAddress").value = streetAddress;

  const editModal = new bootstrap.Modal(document.getElementById('editAddressModal'));
  editModal.show();
}

// Cập nhật địa chỉ
function submitEditAddressForm() {
  const addressID = document.getElementById("editAddressID").value;
  const address = document.getElementById("editAddress").value;
  const city = document.getElementById("editCity").value;
  const district = document.getElementById("editDistrict").value;
  const ward = document.getElementById("editWard").value;
  const streetAddress = document.getElementById("editStreetAddress").value;

  fetch(`http://localhost:8080/user/update-shipping-address`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({ addressID, address, city, district, ward, streetAddress }),
  })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      alert('Địa chỉ đã được cập nhật thành công');
      location.reload();
    })
    .catch(error => console.error('Lỗi khi cập nhật địa chỉ:', error));
}

// Xóa địa chỉ
function XoaDiaChiNhanHang(addressID) {
  fetch(`http://localhost:8080/user/remove-shipping-address?addressID=${addressID}`, {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
  })
    .then(() => {
      alert('Địa chỉ đã được xóa thành công');
      location.reload();
    })
    .catch(error => console.error('Lỗi khi xóa địa chỉ:', error));
}

// Khởi chạy ứng dụng
function start() {
  fetchUserInfo() 
  GetShippingAddress();
}

start();