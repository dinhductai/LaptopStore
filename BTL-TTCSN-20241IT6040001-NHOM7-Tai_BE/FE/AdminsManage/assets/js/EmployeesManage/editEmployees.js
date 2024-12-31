
const apiUpDate = "http://localhost:8080/admin/employee/update/";

async function updateEmployee(event) {
  event.preventDefault();
  const employeeId = document.getElementById("editEmployeeId").value;
  const name = document.getElementById("editEmployeeName").value;
  const email = document.getElementById("editEmployeeEmail").value;
  const phoneNumber = document.getElementById("editEmployeePhone").value;
  const password = document.getElementById("editEmployeePassword").value;
  const status = document.getElementById("editEmployeeStatus").value;

  const employeeData = {
    name,
    email,
    phoneNumber,
    password,
    status,
    employeeId
  };

  try {
    const response = await fetch(`${apiUpDate}${employeeId}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(employeeData)
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const responseText = await response.text();
    
    if (responseText === "success") {
      alert("Cập nhật nhân viên thành công!");
      window.location.reload();
    } else {
      alert("Có lỗi khi cập nhật nhân viên!");
    }

  } catch (error) {
    console.error("Error updating employee:", error);
    alert("Cập nhật nhân viên thất bại!");
  }
}
document.getElementById("editEmployeeForm").addEventListener("submit", updateEmployee);
