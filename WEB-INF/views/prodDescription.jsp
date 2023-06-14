<%-- 
  
  <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Description</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 800px;
        margin: 0 auto;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
    }

    .product-image {
        text-align: center;
        margin-bottom: 20px;
    }

    .product-image img {
        max-width: 100%;
        max-height: 400px;
    }

    .product-details {
        text-align: center;
    }

    .product-name {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .product-description {
        margin-bottom: 20px;
    }

    .product-price {
        font-size: 20px;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    List<Product> products = (List<Product>) request.getAttribute("products");
   // System.out.println(products);
    Product selectedProduct = null;

    for (Product product : products) {
        if (product.getId()==productId) {
            selectedProduct = product;
            break;
        }
    }
%>

<div class="container">
    <h2>Product Description</h2>
    <div class="product-image">
        <img src="<%= selectedProduct.getImageUrl() %>" alt="<%= selectedProduct.getName() %>">
    </div>
    <div class="product-details">
        <h3 class="product-name"><%= selectedProduct.getName() %></h3>
        <p class="product-description"><%= selectedProduct.getDescription() %></p>
        <p class="product-price"><%= selectedProduct.getPrice() %></p>
    </div>
</div>
</body>
</html>
   --%>
   
   
   
   
   
   
   <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Description</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 800px;
        margin: 0 auto;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
    }

    .product-image {
        text-align: center;
        margin-bottom: 20px;
    }

    .product-image img {
        max-width: 100%;
        max-height: 400px;
    }

    .product-details {
        text-align: center;
    }

    .product-name {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .product-description {
        margin-bottom: 20px;
    }

    .product-price {
        font-size: 20px;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<%
    /* int productId = Integer.parseInt(request.getParameter("productId"));
    out.println("in jsp pid:"+productId); */
    Product product = (Product)request.getAttribute("oneproduct");
    //Product selectedProduct = null;

    
%>

<div class="container">
    <h2>Product Description</h2>
    <div class="product-image">
        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
    </div>
    <div class="product-details">
        <h3 class="product-name"><%= product.getName() %></h3>
        <p class="product-description"><%= product.getDescription() %></p>
        <p class="product-price"><%= product.getPrice() %></p>
    </div>
</div>
</body>
</html>
   