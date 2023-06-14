<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <button id="rzp-button1" onclick="openCheckout('${orderId}')">Pay</button>

    <form action="OrderCreation" method="POST" name="razorpayForm">
        <input id="razorpay_payment_id" type="hidden" name="razorpay_payment_id" />
        <input id="razorpay_order_id" type="hidden" name="razorpay_order_id" />
        <input id="razorpay_signature" type="hidden" name="razorpay_signature" />
    </form>

    <script>
        function openCheckout(orderId) {
            var options = {
                key: "rzp_test_Xe8wdVU6XUBoBd",
                name: "E-Cart",
                amount: <%= request.getParameter("amount") %>,
                description: "SLAM payments",
                image: "https://s29.postimg.org/r6dj1g85z/daft_punk.jpg",
                prefill: {
                    name: "<%= request.getParameter("username") %>",
                    email: "<%= request.getParameter("email") %>",
                    contact: "<%= request.getParameter("phone") %>"
                },
                notes: {
                    address: "Hello World",
                    merchant_order_id: "12312321"
                },
                theme: {
                    color: "#F37254"
                },
                order_id: orderId,
                handler: function (response) {
                    document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                    document.getElementById('razorpay_order_id').value = orderId;
                    document.getElementById('razorpay_signature').value = response.razorpay_signature;
                    document.razorpayForm.submit();
                },
                modal: {
                    ondismiss: function () {
                        console.log("This code runs when the popup is closed");
                    },
                    escape: true,
                    backdropclose: false
                }
            };

            var rzpButton = document.getElementById("rzp-button1");
            rzpButton.addEventListener("click", function (e) {
                e.preventDefault();

                // Open Razorpay checkout with updated options
                var rzp = new Razorpay(options);
                rzp.open();
            });
        }
    </script>
</body>
</html>