// Xử lý lọc đơn hàng
document.querySelectorAll('#filter-nav .nav-link').forEach(navLink => {
    navLink.addEventListener('click', function (e) {
        e.preventDefault();

        // Loại bỏ lớp active khỏi các tab
        document.querySelectorAll('#filter-nav .nav-link').forEach(link => link.classList.remove('active'));
        
        // Thêm lớp active cho tab được chọn
        this.classList.add('active');

        // Lấy bộ lọc
        const filter = this.getAttribute('data-filter');

        // Lọc danh sách đơn hàng
        renderOrders(orders, filter);
    });
});

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

fetch(`http://localhost:8080/user/myInfor?id=${tokenRequest['id-user']}`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
    },
  })
  .then(response => response.json())
  .then(function(data){
    console.log(data);
    document.getElementById("inner-user-name").innerHTML = data.fullName
    document.getElementById("inner-user-phoneNumber").innerHTML = data.phoneNumber
  });

function renderOrders(orders, filter = "all") {
    // Tìm phần tử DOM để hiển thị danh sách orders
    var listOrderBlock = document.querySelector("#list-orders");
    // Tìm phần tử DOM để hiển thị tổng tiền
    var totalAmountBlock = document.querySelector("#value-TotalAmount");

    // Biến lưu tổng tiền
    let totalAmount = 0;

    // Tạo HTML cho danh sách orders
    var htmls = orders
        .filter(order => filter === "all" || order.status === filter) // Lọc theo trạng thái
        .map(order => {
            const orderdetail = order.orderdetail[0];
            console.log("orderdetail  " , orderdetail)
            console.log("order : " , order ) 
            // Cộng dồn vào tổng tiền
            totalAmount += orderdetail.lineTotal ;

            return `
                <li class="order-item" data-category="${order.status}">
                    <div class="Cell-Order d-flex justify-content-between align-items-center">
                        <div class="block-image-name-quantity-Order align-items-center">
                            <div class="order-image">
                                <img src="${orderdetail.imageURL}" alt="Ảnh product ${orderdetail.productName}">
                            </div> 
                            <div class="order-infor">
                                <h6 class="order-product-name">${orderdetail.productName}</h6>
                                <h6 class="order-quantity">Số lượng: ${orderdetail.quantity}</h6>
                            </div>
                        </div>

                        <div class="block-Linetotal-Order d-flex flex-row">
                            <div>
                                <button 
                                    onclick="CancelOrder('${order.orderID}', '${order.status}')" 
                                    class="red-button" 
                                    style="display: ${order.status === 'Canceled' ? 'none' : 'inline-block'};">
                                    Hủy đơn
                                </button>
                            </div>
                            <div>
                                <h4 class="order-status">${order.status}</h4>
                                <h6 class="order-Linetotal">${orderdetail.lineTotal.toLocaleString()} VNĐ</h6>
                            </div>
                        </div>
                    </div>
                </li>
            `;
        });

    // Gắn HTML danh sách vào DOM
    listOrderBlock.innerHTML = htmls.join("");
    // Gắn tổng tiền vào DOM
    totalAmountBlock.textContent = totalAmount.toLocaleString() + " VNĐ";
}

// Sự kiện hủy đơn hàng
function CancelOrder(orderID, orderStatus) {
    if (orderStatus === 'Canceled') {
        console.log("Đơn hàng này đã hủy rồi, không thể hủy lại.");
        return; // Không thực hiện hủy đơn nữa nếu trạng thái là "Canceled"
    }

    orderID = parseInt(orderID);
    console.log("Hủy đơn hàng có status:", orderStatus);
    console.log("Nút hủy đơn cho đơn có ID:", orderID);
    console.log(typeof orderID);

    fetch(`http://localhost:8080/user/cancel-order/${orderID}`, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
        },
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Failed to cancel order");
        }
        window.location.reload(); // Tải lại trang sau khi hủy đơn thành công
        return response;
    })
    .then(function(response){
        renderOrders(response); // Cập nhật lại giao diện đơn hàng
    })
    .catch(function(err){
        console.log(err);
    });
}

function GetOrders(callback) {
    const cusID = tokenRequest['id-customer'];
    fetch(`http://localhost:8080/user/my-orders?customerID=${cusID}`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
        },
    })
    .then(response => response.json())
    .then(callback);
}

// Hàm lấy tất cả đơn hàng
function GetAllOrder() {
    console.log("all")
    GetOrders(renderOrders);
}

// Hàm lấy đơn hàng có trạng thái Pending
function GetPendingOrder() {
    console.log("Pending")
    const cusID = tokenRequest['id-customer'];
    fetch(`http://localhost:8080/user/my-orders/?customerID=${cusID}&status=Pending`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
        },
    })
    .then(response => response.json())
    .then(function(response){
        renderOrders(response)
    })
}

// Hàm lấy đơn hàng có trạng thái Confirmed
function GetConfirmedOrder() {
    console.log("Confirmed")
    const cusID = tokenRequest['id-customer'];
    fetch(`http://localhost:8080/user/my-orders/?customerID=${cusID}&status=Confirmed`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
        },
    })
    .then(response => response.json())
    .then(function(response){
        renderOrders(response)
    })
}

// Hàm lấy đơn hàng có trạng thái Shipped
function GetShippedOrder() {
    const cusID = tokenRequest['id-customer'];
    fetch(`http://localhost:8080/user/my-orders/?customerID=${cusID}&status=Shipped`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
        },
    })
    .then(response => response.json())
    .then(function(response){
        renderOrders(response)
    })
}

// Hàm lấy đơn hàng có trạng thái Delivered
function GetDeliveredOrder() {
    console.log("Delivered")
    const cusID = tokenRequest['id-customer'];
    fetch(`http://localhost:8080/user/my-orders/?customerID=${cusID}&status=Delivered`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
        },
    })
    .then(response => response.json())
    .then(function(response){
        renderOrders(response)
    })
}

// 
function GetCanceledOrder() {
    console.log("Canceled")
    const cusID = tokenRequest['id-customer'];
    fetch(`http://localhost:8080/user/my-orders/?customerID=${cusID}&status=Canceled`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
        },
    })
    .then(response => response.json())
    .then(function(response){
        renderOrders(response)
    })
}

function start() {
    GetOrders(renderOrders); // Gọi hàm renderOrders khi có dữ liệu
}

start(); // Bắt đầu








// try {
//     // Thêm tham số id-user vào URL
//     const cusID = tokenRequest['id-customer'];
//     fetch(`http://localhost:8080/user/my-orders?customerID=${cusID}`, {
//       method: "GET",
//       headers: {
//         "Content-Type": "application/json",
//         Authorization: `Bearer ${tokenRequest}`, // Gửi token trong header
//       },
//     })
//     .then(response => response.json())
//     .then(function(data){
//         console.log("Đơn hàng của tôi : " , data)
//         // var orders = data;
//         // renderOrders(orders);
//     });
// } catch(err) {
//     console.log(err)
// }