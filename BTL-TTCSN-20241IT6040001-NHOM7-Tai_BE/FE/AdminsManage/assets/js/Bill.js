document.addEventListener("DOMContentLoaded", function () {
 
    fetch("http://localhost:8080/admin/bill/")
      .then(response => response.json())
      .then(data => {
        
        const totalAmountPayOnline = data.totalAmountPayOnline;
        const totalAmountPayOffline = data.totalAmountPayOffline;
  
        
        document.querySelector(".totalAmountPayOnline").innerHTML = `${totalAmountPayOnline.toLocaleString()} VND`;
        document.querySelector(".totalAmountPayOffline").innerHTML = `${totalAmountPayOffline.toLocaleString()} VND`;
  
        const invoiceDetails = data.listInvoiceDetail;
        console.log(invoiceDetails)
       
        const invoiceListContainer = document.querySelector(".card-body .list-group");
  
        
        invoiceDetails.forEach(invoice => {
          const listItem = document.createElement("li");
          listItem.classList.add("list-group-item", "d-flex", "justify-content-between", "align-items-center");
  
          listItem.innerHTML = `
            <div>
              <h6 class="mb-1 order-Date">${invoice.orderDate}</h6>
              <small id="order-id">${invoice.orderId}</small>
            </div>
            <div id="Total-Amount">
              ${invoice.totalAmount.toLocaleString()} VND
            </div>
          `;
  
         
          invoiceListContainer.appendChild(listItem);
        });
  
       
        const invoiceContainer = document.querySelector(".card-body.pt-4.p-3");
  
        invoiceDetails.forEach(invoice => {
          const invoiceItem = document.createElement("div");
          invoiceItem.classList.add("invoice-item");
          
          invoiceItem.innerHTML = `
            <h6>Order ID: ${invoice.orderId}</h6>
            <p><strong>Customer:</strong> ${invoice.fullName}</p>
            <p><strong>Quốc gia:</strong> ${invoice.shippingAddress}</p>
            <p><strong>Thành Phố:</strong> ${invoice.shippingCity}</p>
            <p><strong>Quận huyện:</strong> ${invoice.shippingDistrict}</p>
            <p><strong>Phường xã:</strong> ${invoice.shippingWard}</p>
            <p><strong>Số Đường:</strong> ${invoice.shippingStreet}</p>
            <p><strong>Product:</strong> ${invoice.productName} (${invoice.model})</p>
            <p><strong>Price:</strong> ${invoice.price.toLocaleString()} VND</p>
            <p><strong>Quantity:</strong> ${invoice.quantity}</p>
            <p><strong>Total Amount:</strong> ${invoice.totalAmount.toLocaleString()} VND</p>
            <p><strong>Shipping Fee:</strong> ${invoice.shippingFee.toLocaleString()} VND</p>
            <p><strong>Estimated Delivery Date:</strong> ${invoice.estimatedDeliveryDate}</p>
            <p><strong>Status:</strong> ${invoice.orderStatus}</p>
            <hr>
          `;
  
          // Append the invoice item to the container
          invoiceContainer.appendChild(invoiceItem);
        });
      })
      .catch(error => {
        console.error('Error fetching invoice data:', error);
      });
  });
  