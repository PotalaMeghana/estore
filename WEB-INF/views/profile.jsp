<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.custCredModel" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<style>
    /* CSS styles */
    * {
        box-sizing: border-box;
    }
    
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f2f2f2;
    }
    
    header {
        background-color: #333;
        color: #fff;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    nav ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }
    
    nav ul li {
        display: inline;
    }
    
    nav ul li a {
        color: #fff;
        text-decoration: none;
        padding: 10px 20px;
    }
    
    nav ul li a:hover {
        background-color: #555;
    }
    
    h1 {
        color: #ffffff;
    }
    
    .container {
      position: relative;
      width: 100%;
      max-width: 800px;
      margin: 0 auto;
    
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    
    th,
    td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }
    
    button {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    
    form label {
        display: block;
        margin-bottom: 10px;
        font-weight: bold;
    }
    
    form input[type="text"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    
    form input[type="submit"] {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
</style>
</head>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>

<script>

function addToCart(productId) {
	
	  console.log("Add to cart called");

		  $.ajax({
    		    url: "addToCart",
    		    method: 'GET',
    		    data: { productId: productId },
    		    success: function(response) {
    		    	if(response.success)
    		    		{
    		    		var bt='<button class="removeFromCart" data-product-id="+ productId+">Remove from Cart</button>';

    		    		$(".addToCartButton").html(bt);
    		    		}
    		    },
    		    error: function(xhr, status, error) {
    		      console.log('AJAX Error: ' + error);
    		    }
    		  });
	}

  function addToWishlist(productId) {
	 
	  $.ajax({
	    url: "addToWishlist",
	    method: 'GET',
	    data: {productId: productId },
	    success: function(response) {
	      $('#display').html(response); // Set the response HTML as the inner HTML of the cart items element
	    },
	    error: function(xhr, status, error) {
	      console.log('AJAX Error: ' + error);
	    }
	  });
  }
  
  function removeFromCart(productId) {
	  console.log("Remove from cart called");
	  $.ajax({
	    url: "removeFromCart",
	    method: 'GET',
	    data: { productId: productId },
	    success: function(response) {
	      showCart(); // Set the response HTML as the inner HTML of the cart items element
	    },
	    error: function(xhr, status, error) {
	      console.log('AJAX Error: ' + error);
	    }
	  });
	}
  
  function removeFromWishlist(productId) {
	  console.log("Remove from wishlist called");
	  $.ajax({
	    url: "removeFromWishlist",
	    method: 'GET',
	    data: { productId: productId },
	    success: function(response) {
	      showCart(); // Set the response HTML as the inner HTML of the cart items element
	    },
	    error: function(xhr, status, error) {
	      console.log('AJAX Error: ' + error);
	    }
	  });
	}
  
  
  function showCart() {
	  console.log("show cart called");

	  $.ajax({
	    url: "cartItems",
	    method: 'GET',
	    data:{userId: 1},
	    success: function(response) {
	      $('#container').html(response); // Set the response HTML as the inner HTML of the cart items element
	    },
	    error: function(xhr, status, error) {
	      console.log('AJAX Error: ' + error);
	    }
	  });
	}
  
  function showWishlist() {
	  $.ajax({
	    url: "wishlistItems",
	    method: 'GET',
	    data:{userId: 1},
	    success: function(response) {
	  	  console.log("profile wishlist");

	      $('#container').html(response); 
	    },
	    error: function(xhr, status, error) {
	      console.log('AJAX Error: ' + error);
	    }
	  });
  }
  function buynow()
  {
	  console.log("buy now");

	  	window.location.href="buycartitems";  
	    }
	

// Add event listener for the "Add to Cart" button
$(document).ready(function() {
	$(document).on('click', '.buyid', function(event) {
		    event.preventDefault();
buynow()
});
	  
	  $(document).on('click', '.addToCartButton', function(event) {
	    event.preventDefault();
	    var productId = $(this).data('product-id');
	    console.log(productId);
	    addToCart(productId);
	  });
	  
	  $(document).on('click', '.removeFromCart', function(event) {
	    event.preventDefault();
	    var productId = $(this).data('product-id');
	    console.log(productId);
	    removeFromCart(productId);
	  });
	  
	  $(document).on('click', '.addToWishlistButton', function(event) {
		    event.preventDefault();
		    var productId = $(this).data('product-id');
		    console.log(productId);
		    addToWishlist(productId);
		});
	  
	  $(document).on('click', '.removeFromWishlist', function(event) {
	    event.preventDefault();
	    var productId = $(this).data('product-id');
	    console.log(productId);
	    removeFromWishlist(productId);
	  });
	  

	  $('#cart-button').click(function() {
	      showCart();
	  });
	  $('#Wishlist-button').click(function() {
	      showWishlist();
	  });
});
</script>
<script>
function updateQuantity(input) {
    var quantity = input.value;
    var productId = input.getAttribute('data-product-id');
    console.log(quantity);
    console.log("product no="+productId);
    $.ajax({
      url: 'updateQuantity',
      method: 'POST',
      data: { productId: productId, quantity: quantity },
      success: function(response) {
        console.log(response);
        $("#cst").html("TotalCost: $" + response);
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
  }
  
</script>
<body>
    <header>
        <!-- Display the customer name -->
        <h1>Hey! ${cust != null ? cust.custName : ""}</h1>
        <nav>
            <ul>
                <li><a href="loggedIn">Home</a></li>
                <li><a href="#">&#128142; Orders</a></li>
                <li><a href="#">&#x1F381; Cupons</a></li>
        <li><a href="#">&#128722; <button type="button" id="cart-button" class="btn btn-primary">Cart</button></a></li>
        <li><a href="#">&#10084; <button type="button" id="Wishlist-button" class="btn btn-primary">Wishlist</button> </a></li>
                <li><a href="logout">LogOut</a></li>
            </ul>
        </nav>
    </header>
    <main id="mainid">
        <div id="container">
            <h1>Customer Profile</h1>
            <table>
                <tr>
                    <th>Customer ID</th>
                    <td>${cust != null ? cust.custId : ""}</td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td>${cust != null ? cust.custName : ""}</td>
                </tr>
                <tr>
                    <th>Mobile</th>
                    <td>${cust != null ? cust.custMobile : ""}</td>
                </tr>
                <tr>
                    <th>Location</th>
                    <td>${cust != null ? cust.custLocation : ""}</td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td>${cust != null ? cust.custEmail : ""}</td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td>${cust != null ? cust.custAddress : ""}</td>
                </tr>
                <tr>
                    <th>Shipping Address</th>
                    <td>${cust != null ? cust.custSAddress : ""}</td>
                </tr>
                <tr>
                    <th>Pincode</th>
                    <td>${cust != null ? cust.custPincode : ""}</td>
                </tr>
                <tr>
                    <th>Last Login Date</th>
                    <td>${cust != null ? cust.custLastLoginDate : ""}</td>
                </tr>
            </table>
            <button onclick="editprofile()">EDIT PROFILE</button>
        </div>
    </main>
  <script>
    function editprofile() {
        var ele = document.getElementById("container");
        ele.innerHTML = `
        <form action="updateProfile" method="post">    
            <label>CustomerId:</label>
            <input type="text" id="custId" name="custId" value="${cust != null ? cust.custId : ""}" readonly><br>

            <label for="custName">Name:</label>
            <input type="text" id="custName" name="custName" value="${cust != null ? cust.custName : ""}"><br>

            <label for="custMobile">Mobile:</label>
            <input type="text" id="custMobile" name="custMobile" value="${cust != null ? cust.custMobile : ""}"><br>

            <label for="custLocation">Location:</label>
            <input type="text" id="custLocation" name="custLocation" value="${cust != null ? cust.custLocation : ""}"><br>

            <label for="custAddress">Address:</label>
            <input type="text" id="custAddress" name="custAddress" value="${cust != null ? cust.custAddress : ""}"><br>

            <label for="custSAddress">Shipping Address:</label>
            <input type="text" id="custSAddress" name="custSAddress" value="${cust != null ? cust.custSAddress : ""}"><br>

            <label for="custPincode">Pincode:</label>
            <input type="text" id="custPincode" name="custPincode" value="${cust != null ? cust.custPincode : ""}"><br>

            <input type="submit" value="Update Profile">
        </form>`;
    }
</script>

</body>
</html>
