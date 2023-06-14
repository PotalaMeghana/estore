<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <style>
        .container {
            margin-top: 50px;
            text-align: center;
        }

        .row {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            width: 300px;
            padding: 20px;
            margin: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
        }

        /* .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
        } */

        .card-title {
            font-size: 20px;
            font-weight: bold;
            margin-top: 10px;
        }

        .card-text {
            margin-top: 10px;
        }

        .btn {
            margin-top: 10px;
        }

        .overall-cost {
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
        }

        .buyButton {
            margin-top: 20px;
        }
    </style>
    
</head>
<body>
    <div class="container">
        <h2>Cart</h2>
        <div class="row">
            <%-- Iterate over the products and render the HTML content --%>
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
            double overallCost = 0.0;
            if(products!=null){
                

                for (Product product : products) {
                    overallCost += product.getPrice();
            %>
            <div class="card">
                <img class="card-img-top" src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <p class="card-text"><%= product.getPrice() %></p>
                    <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getId() %>">Remove from Cart</button>
                    <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getId() %>">Add to Wishlist</button>
                </div>
            </div>
            <%
                }}
            %>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <p class="overall-cost">Overall Cost: <%= overallCost %></p>
                <button class="btn btn-success buyButton" onclick="showPaymentPage()">Buy</button>
            </div>
        </div>
    </div>
    <script>
    function showPaymentPage() {
    	//console.log("buy button");
        $.ajax({
          url: "payment",
          method: 'post',
          data: { userId: 1 },
          success: function(response) {
        	 // window.location.href = "cart.jsp";
        	  $('#prod').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }
    
    </script>
</body>
</html>
 