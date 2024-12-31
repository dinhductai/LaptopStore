
document.addEventListener("DOMContentLoaded", function () {
    const addEmployeeForm = document.getElementById("addEmployeeForm");
    addEmployeeForm.addEventListener("submit", function (e) {
      e.preventDefault();
  
      const name = document.getElementById("addEmployeeName").value;
      const email = document.getElementById("addEmployeeEmail").value;
      const phone = document.getElementById("addEmployeePhone").value;
      const password = document.getElementById("addEmployeePassword").value;
      const status = document.getElementById("addEmployeeStatus").value;
  
      const newEmployee = { name, email, phoneNumber: phone,password, status };
      fetch("http://localhost:8080/admin/employee/create", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(newEmployee),
      })
        .then((response) => response.text()) 
        .then((message) => {
          if (message.toLowerCase().includes("success")) {
            alert("Thêm nhân viên thành công!");
          } else {
            alert("Thêm nhân viên thất bại: " + message);
          }
          window.location.reload();
        })
        .catch((error) => {
          console.error("Error:", error);
          alert("Thêm nhân viên thất bại! Vui lòng thử lại.");
        });
    });
  });
  