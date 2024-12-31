document.addEventListener("DOMContentLoaded", function () {
    var userAccount = document.getElementById("userAccount");
    var userMenu = document.getElementById("userMenu");
    var loginLink = document.getElementById("loginLink");
    var userInfo = document.getElementById("userInfo");
    var orders = document.getElementById("orders");
    var logout = document.getElementById("logout");

   
    var isLoggedIn = localStorage.getItem("isLoggedIn") === "true";

    // Cập nhật giao diện dựa trên trạng thái đăng nhập
    function updateMenu() {
        if (isLoggedIn) {
            loginLink.style.display = "none"; // Ẩn nút Đăng nhập
            userInfo.style.display = "block"; // Hiển thị Thông tin cá nhân
            orders.style.display = "block"; // Hiển thị Đơn hàng
            logout.style.display = "block"; // Hiển thị Đăng xuất
            console.log('Đây là token khi đăng nhập :', localStorage.getItem("authToken"));
            console.log('User ID đang đăng nhập:', localStorage.getItem('id-user'));
            console.log('Customer ID đang đăng nhập:', localStorage.getItem('id-customer'));
            console.log('Cart ID đang đăng nhập:', localStorage.getItem('id-cart'));
        } else {
            loginLink.style.display = "block"; // Hiển thị Đăng nhập
            userInfo.style.display = "none"; // Ẩn Thông tin cá nhân
            orders.style.display = "none"; // Ẩn Đơn hàng
            logout.style.display = "none"; // Ẩn Đăng xuất
        }
    }

    userAccount.addEventListener("click", function () {
        if (userMenu.style.display === "none" || userMenu.style.display === "") {
            userMenu.style.display = "block";
        } else {
            userMenu.style.display = "none";
        }
    });

    loginLink.addEventListener("click", function (event) {
        event.preventDefault();
        window.location.href = "login.html"; 
    });

    userInfo.addEventListener("click", function (event) {
        event.preventDefault();
        window.location.href = "inforUserDetail_Main.html"; 
    });

   
    orders.addEventListener("click", function (event) {
        event.preventDefault();
        window.location.href = "My_Order.html"; 
    });

    
    logout.addEventListener("click", function (event) {
        event.preventDefault();
        alert("Đăng xuất thành công!");
        localStorage.removeItem("isLoggedIn"); // Xóa trạng thái đăng nhập
        localStorage.removeItem("userRole");
        localStorage.removeItem('authToken');
        localStorage.removeItem('id-user');
        localStorage.removeItem('id-customer');
        localStorage.removeItem('id-cart');
        isLoggedIn = false;
        console.log('Token sau khi đăng xuất:', localStorage.getItem('authToken'));
        updateMenu();
        window.location.href = "../index.html"; 
    });

    updateMenu();
});
