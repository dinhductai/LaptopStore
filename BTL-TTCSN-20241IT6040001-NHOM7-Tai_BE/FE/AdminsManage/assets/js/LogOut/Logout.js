document.getElementById("log-out").addEventListener("click", function (event) {
    event.preventDefault(); // Ngăn hành động mặc định của liên kết
    var isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
    // Hiển thị thông báo xác nhận
    const confirmLogout = confirm("Bạn có chắc chắn muốn đăng xuất không?");
    if (confirmLogout) {
        // Xóa các token lưu trữ trong localStorage
        localStorage.removeItem("isLoggedIn");    // Trạng thái đăng nhập
        localStorage.removeItem("userRole");     // Vai trò người dùng
        localStorage.removeItem("authToken");    // Token xác thực
        localStorage.removeItem("id-user");      // ID người dùng
        localStorage.removeItem("id-customer");  // ID khách hàng
        localStorage.removeItem("id-cart");      // ID giỏ hàng

        // Đặt trạng thái đăng nhập thành false (nếu cần)
        isLoggedIn = false;

        // Ghi log để kiểm tra xem token đã bị xóa
        console.log('Token khi tạo đã bị xóa:', localStorage.getItem('authToken'));

        // Hiển thị thông báo thành công
        alert("Đăng xuất thành công!");

        // Điều hướng về trang đăng nhập (hoặc trang chủ)
        window.location.href = "../login.html"; // Thay "login.html" bằng URL trang đăng nhập của bạn
    }
});

