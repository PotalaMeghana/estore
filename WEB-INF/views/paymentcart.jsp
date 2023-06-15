<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<%@ page import="eStoreProduct.model.custCredModel" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div id="id1">
<div class="container mt-5">
    <div class="row mt-4">
        <%
        custCredModel cust1 = (custCredModel) session.getAttribute("customer");
        HashMap<Integer, Integer> hm = (HashMap<Integer, Integer>) request.getAttribute("hm");
        HashMap<Integer, Integer> hmp = (HashMap<Integer, Integer>) request.getAttribute("h");

        List<Product> products = (List<Product>) request.getAttribute("products");
        int nop = 0, shpch = 0;
        double totalCost = 0;

        for (Product product : products) {
            int quantity = hm.get(product.getId());
            int productCost = hmp.get(product.getId());
            totalCost+=productCost;
        %>
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <img class="card-img-top" src="<%= product.getImageUrl() %>" alt="<%=product.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getPrice() %></p>
                    <p class="card-text">Quantity: <%= quantity %></p>
                    <p class="card-text">Subtotal: <%= productCost %></p>
                </div>
            </div>
        </div>
        <%
        }
        %>
    </div>
</div>
   <div id="cont">
                <label for="custSAddress">Shipping Address:</label>
                <input type="text" class="ship" id="custSAddress"  value="<%=cust1.getCustSAddress()%>"><br>
        </div>
<div>
<p class="card-text">TotalCost: <%= totalCost %></p>
</div>


<div>
    <button class="btn btn-primary back">Back</button>
    <button class="btn btn-primary continue" onclick="continuenext()">Continue</button>
</div>

</div>

<script>
function update(shipadd)
{
	 $.ajax({
		    url: "confirmShipmentAddress",
		    method: 'GET',
		    data: { shipmentadd: shipadd },
		    success: function(response) {
		    },
		    error: function(xhr, status, error) {
		      console.log('AJAX Error: ' + error);
		    }
		  });	
	}
function continuenext()
{  console.log("hiiiiiiiii");
  	window.location.href="done";
	
	}
    $(document).on('click', '.back', function(event) {
        event.preventDefault();
        console.log("Back");
        history.back();
    });
</script>
</body>
</html>
