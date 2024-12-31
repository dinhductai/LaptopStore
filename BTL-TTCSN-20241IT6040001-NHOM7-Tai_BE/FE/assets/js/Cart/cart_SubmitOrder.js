let cartDetails = []; // Biến global để lưu trữ dữ liệu

// Hàm tải dữ liệu từ API
async function fetchCartDetails() {
    const cartID = localStorage.getItem("id-cart");
    if (!cartID) {
        console.error("cartID không tồn tại trong localStorage.");
        return;
    }

    try {
        const response = await fetch(`http://localhost:8080/user/mycart/cart-detail?cartID=${cartID}`);
        if (response.ok) {
            cartDetails = await response.json();
            console.log("Dữ liệu cartDetails:", cartDetails); // Kiểm tra dữ liệu
        } else {
            console.error("Không thể tải cartDetails:", response.statusText);
        }
    } catch (error) {
        console.error("Lỗi khi gọi API:", error);
    }
}

// Gọi hàm khi trang được tải
document.addEventListener("DOMContentLoaded", async () => {
    await fetchCartDetails();
});

document.addEventListener("DOMContentLoaded", () => {
    const submitButton = document.getElementById("btn-submit");

    const idCustomer = localStorage.getItem('id-customer');
    if (!idCustomer) {
        alert("Không tìm thấy thông tin khách hàng. Vui lòng đăng nhập lại.");
        return;
    }

    submitButton.addEventListener("click", async (event) => {
        event.preventDefault();
    const comboBox = document.getElementById('promotionComboBox');
    const validPromotionIDs = [];
    const productRows = document.querySelectorAll(".product-row");

    productRows.forEach(row => {
        const checkbox = row.querySelector(".product-checkbox");
        if (checkbox && checkbox.checked && row.dataset.productId) {
            const productId = parseInt(row.dataset.productId, 10);
            if (!isNaN(productId)) {
                const cartDetail = cartDetails.find(detail => detail.productId === productId);
                if (cartDetail && Array.isArray(cartDetail.promotion)) {
                    cartDetail.promotion.forEach(promo => {
                        validPromotionIDs.push(promo.promotionID);
                    });
                } else {
                    console.warn(`Không tìm thấy thông tin khuyến mãi cho sản phẩm ID=${productId}.`);
                }
            } else {
                console.warn(`Mã sản phẩm không hợp lệ: ${row.dataset.productId}`);
            }
        }
    });

    // Kiểm tra mã giảm giá có hợp lệ với sản phẩm không
    let validPromotion = false;
    validPromotionIDs.forEach(id => {
        if (parseInt(comboBox.value, 10) === id) { // Đảm bảo cả hai đều là kiểu số
            validPromotion = true;
        }
    });

    // Nếu không có mã giảm giá được chọn, xem như hợp lệ
    if (comboBox.value === null || comboBox.value === "") {
        validPromotion = true;
    }

    if (!validPromotion) {
        alert("Vui lòng chọn mã giảm giá đúng với sản phẩm muốn thanh toán.");
        return;
    }
        

        

        const selectedAddress = document.querySelector('input[name="address"]:checked');
        if (!selectedAddress) {
            alert("Vui lòng chọn địa chỉ giao hàng.");
            return;
        }

        const selectedPaymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
        if (!selectedPaymentMethod) {
            alert("Vui lòng chọn phương thức thanh toán.");
            return;
        }

        const totalAmountElement = document.getElementById("tien-phai-thanh-toan");
        if (!totalAmountElement) {
            alert("Không thể lấy tổng tiền. Vui lòng kiểm tra lại giao diện.");
            return;
        }

        const totalAmount = parseFloat(
            totalAmountElement.textContent
                .replace(" VND", "") // Loại bỏ chuỗi " VND"
                .replace(/[.,]/g, "") // Loại bỏ dấu chấm và dấu phẩy
        );
        if (isNaN(totalAmount) || totalAmount <= 0) {
            alert("Vui lòng chọn ít nhất một sản phẩm để mua.");
            return;
        }

        const products = [];
        productRows.forEach(row => {
            const checkbox = row.querySelector(".product-checkbox");
            if (checkbox && checkbox.checked) {
                const productID = row.dataset.productId;
                const quantity = parseInt(row.querySelector(".quantity-input").value, 10);
                const price = parseFloat(
                    row.querySelector(".product-price").textContent.replace(/[.,]/g, "")
                );
                
                if (productID && price > 0 && quantity > 0) {
                    products.push({ productID, quantity, price });
                } else {
                    console.warn(`Sản phẩm không hợp lệ: ID=${productID}, Price=${price}, Quantity=${quantity}`);
                }
            }
        });

        if (products.length === 0) {
            alert("Vui lòng chọn ít nhất một sản phẩm hợp lệ (đảm bảo nhập đúng số lượng và sản phẩm được chọn).");
            return;
        }

        const confirmSubmit = confirm("Bạn có chắc chắn muốn gửi đơn hàng không?");
        if (!confirmSubmit) {
            return;
        }

        const orderData = {
            customerID: idCustomer,
            orderDate: new Date().toISOString().split("T")[0],
            totalAmount: totalAmount,
            shippingFee: 0,
            orderStatus: "Pending",
            estimatedDeliveryDate: new Date().toISOString().split("T")[0],
            actualDeliveryDate: new Date().toISOString().split("T")[0],
            paymentMethodID: selectedPaymentMethod.value === "card" ? 1 : 2,
            addressID: selectedAddress.value,
            orderDetails: products, // ở dòng 64
        };

        try {
            const response = await fetch("http://localhost:8080/user/mycart/create-order", {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(orderData),
            });

            if (response.ok) {
                const result = await response.json();
                alert(result.message || "Đơn hàng đã được gửi thành công!");
            } else {
                const error = await response.json();
                console.error("Lỗi từ API:", error);
                alert(error.message || "Có lỗi xảy ra khi gửi đơn hàng. Vui lòng thử lại!");
            }
        } catch (error) {
            console.error("Lỗi khi gửi API:", error);
            alert("Gửi thành công");
        }
    });
});
