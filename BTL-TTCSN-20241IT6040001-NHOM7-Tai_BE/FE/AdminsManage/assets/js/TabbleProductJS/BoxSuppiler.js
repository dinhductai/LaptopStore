// TableProduct.js

document.addEventListener('DOMContentLoaded', () => {
    const supplierSelect = document.getElementById('supplier-select');
    
    // Clear existing combobox options
    supplierSelect.innerHTML = '<option value="">Chọn Nhà Cung Cấp</option>'; // Ensure "Chọn Nhà Cung Cấp" is the first option
  
    // Fetch suppliers from the API
    fetch('http://localhost:8080/admin/supplier/')
      .then(response => response.json())
      .then(suppliers => {
        // Loop through the suppliers and add them to the combobox
        suppliers.forEach(supplier => {
          const option = document.createElement('option');
          option.value = supplier.supplierID;  // Set supplierID as the value
          option.textContent = supplier.supplierName;  // Set supplierName as the option text
          supplierSelect.appendChild(option);
        });
      })
      .catch(error => console.error('Error fetching suppliers:', error));
  
    // Add event listener to set SupplierID when a supplier is selected
    supplierSelect.addEventListener('change', (event) => {
      const selectedSupplierID = event.target.value;
      if (selectedSupplierID) {
        console.log('Selected SupplierID:', selectedSupplierID);
        // Update the URL with the selected supplierID
        const currentUrl = new URL(window.location.href);
        currentUrl.searchParams.set('supplierID', selectedSupplierID);  // Add or update supplierID parameter
        window.history.replaceState({}, '', currentUrl);  // Update the URL without reloading the page
      }
    });
  });
  