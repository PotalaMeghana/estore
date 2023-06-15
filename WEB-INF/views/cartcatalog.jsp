<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="container mt-5">
        <div class="row mt-4">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
            double cartcost=0;
            int totalitems=0;
            int shipch=0;
           cartcost = (double) request.getAttribute("cartt");


                for (Product product : products) {
                	totalitems++;
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getName() %></h5>
                        <p class="card-text"><%= product.getDescription() %></p>
                        <p class="card-text"><%= product.getPrice() %></p>
                <input type="number" class="form-control qtyinp" style="width: 50px;" min="1" data-product-id="<%= product.getId() %>" onchange="updateQuantity(this)">
                         <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getId() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getId() %>">Add to Wishlist</button>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            <div>
            <div>
            <p>Total Items:<%=totalitems %></p>
            <p>ShipMent Charges:<%=shipch %></p>
            
            </div>
            <div id="costdiv">
            <%
            if(cartcost!=0)
            {
            	%>
            	<p id="cst">TotalCost:$<%=cartcost%></p>
            	<button class="buyid">Buy Now</button>
            	<%
            }
            	else
            	{
            		%><p>No CartProducts</p>
            		<%
            }
            %></div>
            </div>
        </div>
    </div>
</body>
</html>