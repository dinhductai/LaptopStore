const API_URL = "http://localhost:8080/admin/employee/";

async function fetchEmployees() {
  try {
    const response = await fetch(API_URL);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const employees = await response.json();
    renderEmployeeTable(employees);
 
  } catch (error) {
    console.error("Error fetching employees:", error);
  }
}

function renderEmployeeTable(employees) {
  const tableBody = document.getElementById("employeeTableBody");
  tableBody.innerHTML = ""; 

  employees.forEach((employee, index) => {
    const row = document.createElement("tr");

    row.innerHTML = `
      <td>${index + 1}</td>
      <td>${employee.name}</td>
      <td>${employee.email}</td>
      <td>${employee.phoneNumber}</td>
      <td>${employee.status === "active" ? "Active" : "Inactive"}</td>
      <td>
        <button class="btn btn-primary btn-sm edit-btn" data-id="${employee.employeeId}" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">Sửa</button>
        <button class="btn btn-danger btn-sm delete-btn" data-delete-id="${employee.employeeId}">Xóa</button>
      </td>
    `;

    const editButton = row.querySelector(".edit-btn");
    editButton.addEventListener("click", () => {
      const employeeId = editButton.dataset.id;
      fetchEmployeeDetails(employeeId);
    });
    
    const deleteButton = row.querySelector(".delete-btn");
    deleteButton.addEventListener("click", function () {
    const employeeId = deleteButton.getAttribute("data-delete-id");
    deleteEmployee(employeeId);
    });

    tableBody.appendChild(row);
  });
}

async function fetchEmployeeDetails(employeeId) {
  try {
    const response = await fetch(`http://localhost:8080/admin/employee/update/${employeeId}`);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const employee = await response.json();
    document.getElementById("editEmployeeId").value = employee.employeeId;
    document.getElementById("editEmployeeName").value = employee.name;
    document.getElementById("editEmployeeEmail").value = employee.email;
    document.getElementById("editEmployeePhone").value = employee.phoneNumber;
    document.getElementById("editEmployeePassword").value = employee.password;
    document.getElementById("editEmployeeStatus").value = employee.status;
  } catch (error) {
    console.error("Error fetching employee details:", error);
  }
}

window.onload = fetchEmployees;
