
// function getSelectedCheckboxes(groupName) {
//   const checkboxes = document.querySelectorAll(`input[name="${groupName}"]:checked`);
//   return Array.from(checkboxes).map(checkbox => checkbox.value);
// }

// function buildApiUrl() {
//   const apiUrl = "http://localhost:8080/user/home";
//   const params = new URLSearchParams();

 
//   const brands = getSelectedCheckboxes('brand-filter');
//   console.log('Selected brands:', brands);
//   if (brands.length) params.append('idBrand', brands.join(','));

//   const prices = getSelectedCheckboxes('price-filter');
//   console.log('Selected prices:', prices);
//   if (prices.length) params.append('price', prices.join(','));

//   const cpus = getSelectedCheckboxes('cpu-filter');
//   console.log('Selected CPUs:', cpus);
//   if (cpus.length) params.append('cpu', cpus.join(','));

//   const rams = getSelectedCheckboxes('ram-filter');
//   console.log('Selected RAMs:', rams);
//   if (rams.length) params.append('ram', rams.join(','));

//   const storages = getSelectedCheckboxes('hardrive-filter');
//   console.log('Selected storages:', storages);
//   if (storages.length) params.append('hardDrive', storages.join(','));

//   const screenSizes = getSelectedCheckboxes('screen-size-filter');
//   console.log('Selected screen sizes:', screenSizes);
//   if (screenSizes.length) params.append('screenSize', screenSizes.join(','));

  
//   const builtUrl = `${apiUrl}/?${params.toString()}`;
//   console.log('Built API URL:', builtUrl);
//   return builtUrl;
// }


// document.getElementById('filter-form').addEventListener('submit', function (event) {
//   event.preventDefault(); 

//   const updatedApiUrl = buildApiUrl();
//   console.log('Updated API URL:', updatedApiUrl);

//   fetch(updatedApiUrl)
//       .then(response => response.json())
//       .then(data => {
//           console.log('Filtered Data:', data);

//           displayResults(data);
//           displayRegularProducts(data)
          
//       })
//       .catch(error => console.error('Lỗi khi gọi API:', error));
// });

// function displayResults(data) {
 
//   console.log('Kết quả tìm kiếm:', data);
// }
