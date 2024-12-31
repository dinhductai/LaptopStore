const apiUrl = "http://localhost:8080/user/home";

// Hàm để thêm các mục vào một nhóm bộ lọc
function addFilterItems(filterGroupId, items, valueKey, labelKey) {
    const filterGroup = document.getElementById(filterGroupId);
    if (!filterGroup) return;

    // Xóa nội dung cũ trước khi thêm
    filterGroup.innerHTML = '';

    items.forEach(item => {
        const value = item[valueKey]; // Dùng giá trị key từ API
        const label = item[labelKey]; // Dùng giá trị label từ API
        const checkbox = `
            <label>
                <input type="checkbox" name="${filterGroupId}" value="${value}"> ${label}
            </label><br>
        `;
        filterGroup.innerHTML += checkbox;
    });
}

// Lấy dữ liệu từ API và thêm vào các bộ lọc
fetch(apiUrl)
    .then(response => response.json())
    .then(data => {
        // Thêm mục vào từng bộ lọc
        addFilterItems(
            'brand-filter', 
            Object.entries(data.getSuppliersForCheckboxAndBtn).map(([key, value]) => ({ id: key, name: value })), 
            'id', 
            'name'
        );
        addFilterItems(
            'price-filter', 
            Object.entries(data.getPriceProductForCheckbox).map(([key, value]) => ({ id: key, name: value })), 
            'id', 
            'name'
        );
        addFilterItems(
            'cpu-filter', 
            Object.entries(data.getCPUForCheckbox).map(([key, value]) => ({ id: key, name: value })), 
            'id', 
            'name'
        );
        addFilterItems(
            'ram-filter', 
            Object.entries(data.getRamForCheckbox).map(([key, value]) => ({ id: key, name: value })), 
            'id', 
            'name'
        );
        addFilterItems(
            'hardrive-filter', 
            Object.entries(data.getHardDriveForCheckbox).map(([key, value]) => ({ id: key, name: value })), 
            'id', 
            'name'
        );
        addFilterItems(
            'screen-size-filter', 
            Object.entries(data.getScreenSizeForCheckbox).map(([key, value]) => ({ id: key, name: value })), 
            'id', 
            'name'
        );
    })
    .catch(error => console.error('Lỗi khi lấy dữ liệu từ API:', error));

// Hàm toggle hiển thị nhóm bộ lọc
function toggleFilter(filterId) {
    const filterElement = document.getElementById(filterId);
    if (filterElement) {
        filterElement.style.display = filterElement.style.display === 'none' ? 'block' : 'none';
    }
}
