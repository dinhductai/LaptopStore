document.addEventListener("DOMContentLoaded", function () {
    // Lấy các phần tử HTML theo ID
    const totalAmountPayOnline = document.getElementById("total_Amount_Pay_Online");
    const totalAmountPayOffline = document.getElementById("total_Amount_Pay_Offline");

    // Gọi API để lấy dữ liệu khi trang load
    fetch("http://localhost:8080/admin/bill/")
        .then((response) => response.json())  // Chuyển dữ liệu JSON từ response
        .then((data) => {
            // Lấy giá trị totalAmountPayOnline và totalAmountPayOffline từ API
            const onlineAmount = data.totalAmountPayOnline;
            const offlineAmount = data.totalAmountPayOffline;

            // Cập nhật giá trị vào phần tử HTML
            totalAmountPayOnline.innerText = `$${onlineAmount}`;
            totalAmountPayOffline.innerText = `$${offlineAmount}`;

            data.listInvoiceDetail.forEach((invoice) => {
                const { orderDate, fullName, totalAmount, orderId } = invoice;

                // Tạo phần tử HTML cho từng dòng hóa đơn
                const invoiceItem = document.createElement("li");
                invoiceItem.className = "list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg";
                
                // Cấu trúc HTML cho nội dung hóa đơn
                invoiceItem.innerHTML = `
                    <div class="d-flex flex-column">
                        <h6 class="mb-1 text-dark font-weight-bold text-sm">
                            ${new Date(orderDate).toLocaleDateString()}
                        </h6>
                        <span class="text-xs">${fullName}</span>
                    </div>
                    <div class="d-flex align-items-center text-sm">
                        $${totalAmount}
                        <button class="btn btn-link text-dark text-sm mb-0 px-0 ms-4" onclick="showInvoiceDetails(${orderId})">
                            <i class="material-icons text-lg position-relative me-1">picture_as_pdf</i>
                        </button>
                    </div>
                `;
                
                // Thêm dòng hóa đơn vào danh sách
                listInvoiceDetail.querySelector(".list-group").appendChild(invoiceItem);
            });
        })
        .catch((error) => {
            console.error("Lỗi khi lấy dữ liệu từ API:", error);
        });
});


function showInvoiceDetails(orderId) {
    fetch(`http://localhost:8080/admin/bill/${orderId}`)
        .then((response) => response.json())
        .then((invoice) => {
            const details = `
                Order Date: ${new Date(invoice.orderDate).toLocaleDateString()}<br>
                Customer: ${invoice.fullName}<br>g
                Phone: ${invoice.phoneNumber}<br>
                Address: ${invoice.shippingAddress || "N/A"}, ${invoice.shippingCity || "N/A"}<br>
                Product: ${invoice.productName} - ${invoice.model} (${invoice.brand})<br>
                Price: $${invoice.price}<br>
                Quantity: ${invoice.quantity}<br>
                Line Total: $${invoice.lineTotal}<br>
                Shipping Fee: $${invoice.shippingFee}<br>
                Total Amount: $${invoice.totalAmount}<br>
                Estimated Delivery: ${new Date(invoice.estimatedDeliveryDate).toLocaleDateString()}<br>
                Status: ${invoice.orderStatus}
            `;

            // Hiển thị thông tin chi tiết (ở đây đơn giản là alert; bạn có thể thay bằng modal hoặc phần tử HTML khác)
            alert(details);
        })
        .catch((error) => console.error("Lỗi khi lấy chi tiết hóa đơn:", error));
}