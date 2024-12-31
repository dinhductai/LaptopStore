async function register(event) {
  event.preventDefault();

  // Lấy dữ liệu từ form
  const fullname = document.getElementById("fullName").value;
  const Email = document.getElementById("email").value;
  const PassWord = document.getElementById("password").value;
  const confirmPassword = document.getElementById("confirmPassword").value;
  const PhoneNumber = document.getElementById("phoneNumber").value;

  // Kiểm tra mật khẩu
  if (PassWord !== confirmPassword) {
      alert("Mật khẩu không khớp. Vui lòng kiểm tra lại!");
      return;
  }

  // Chuẩn bị dữ liệu để gửi
  const RegisterDate = new Date().toISOString(); // Thời gian hiện tại theo chuẩn ISO 8601
  const userData = {
      id: null,
      fullName: fullname,
      email: Email,
      password: PassWord,
      phoneNumber: PhoneNumber,
      registerDate: RegisterDate
  };

  // In dữ liệu gửi đi
  console.log("Dữ liệu gửi đi:", userData);

  // Gửi dữ liệu tới API
  try {
    const response = await fetch("http://localhost:8080/register", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(userData)
    });

    if (response.ok) {
      const contentType = response.headers.get("Content-Type");
      // Kiểm tra xem response có phải là JSON không
      if (contentType && contentType.includes("application/json")) {
        const result = await response.json(); // Đọc JSON nếu có
        console.log("Phản hồi JSON từ server:", result);
        alert(result.message || "Đăng ký thành công!");
      } else if (contentType && contentType.includes("text/plain")) {
        const result = await response.text(); 
        console.log("Phản hồi từ server:", result);
        alert(result); 
      } else {
        alert("Định dạng phản hồi không được hỗ trợ.");
      }
      window.location.href = "login.html"; 
    } else {
      
      const error = await response.text(); // Đọc lỗi nếu phản hồi là text
      alert("Đăng ký thất bại: " + (error || "Vui lòng thử lại."));
    }
  } catch (error) {
    console.error("Lỗi khi gọi API:", error);
    alert("Có lỗi xảy ra. Vui lòng thử lại.");
  }
}
