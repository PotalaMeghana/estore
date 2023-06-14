<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Catalog</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $('form.myForm').each(function() {
        $(this).submit(function(event) {
            event.preventDefault(); // Prevent default form submission

            var productId = $(this).find('input[name="productId"]').val();
            loadPrice(productId); // Call the loadPrice function with the productId
        });
    });

    function loadPrice(productId) {
        // AJAX call to retrieve the session variable
        $.ajax({
            url: "getProductDisplayed",
            method: 'GET',
            data: {
                productDisplayed: productId
            },
            success: function(response) {
                console.log("Price received for product ID " + productId + ": " + response);
                var responseData = JSON.parse(response); // Parse the response as JSON
                var price = responseData.price;
                console.log("price "+price);
                $("#prodprice").text(price);
            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });
    }

    function showProductDetails(productId) {
        window.location.href = "prodDescription?productId=" + productId;
    }
});
</script>
</head>
<body>
<div class="container mt-5">
    <h2>Product Catalog</h2>
    <div class="row mt-4">
        <%-- Iterate over the products and render the HTML content --%>
        <%
            List<Product> products = (List<Product>) request.getAttribute("products");

            for (Product product : products) {
        %>
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <a href="javascript:void(0)" onclick="showProductDetails('<%= product.getProd_id() %>')">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                </a>
                <div class="card-body">
                    <h5 class="card-title"><%= product.getProd_title() %></h5>
                    <p class="card-text"><%= product.getProd_desc() %></p>
                    <form class="myForm">
                        <input type="hidden" name="productId" value="<%= product.getProd_id() %>">
                    </form>
                    <p class="card-text" id="prodprice"></p>
                    <button class="btn btn-primary addToCartButton" data-product-id="<%= product.getProd_id() %>">Add To Cart</button>
                    <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                $('form.myForm').submit(); // Trigger form submission
            });
        </script>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
