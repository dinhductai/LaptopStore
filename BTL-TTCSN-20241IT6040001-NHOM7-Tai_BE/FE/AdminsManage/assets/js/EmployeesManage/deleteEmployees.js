
const apiDelete = "http://localhost:8080/admin/employee/delete/";

async function deleteEmployee(employeeId) {
  const confirmDelete = confirm("Bạn có chắc chắn muốn xóa nhân viên này không?");
  if (!confirmDelete) return;

  try {
    const response = await fetch(`${apiDelete}${employeeId}`, {
      method: "DELETE",
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const responseText = await response.text();
    
    if (responseText === "success") {
      alert("Xóa nhân viên thành công!");
      window.location.reload();
    } else {
      alert("Có lỗi khi xóa nhân viên!");
    }

  } catch (error) {
    console.error("Error deleting employee:", error);
    alert("Xóa nhân viên thất bại!");
  }
}
