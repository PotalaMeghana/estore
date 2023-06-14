
  package eStoreProduct.controller;

import java.util.List;
import com.google.gson.Gson;
import com.google.gson.JsonObject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import eStoreProduct.model.Category;
import eStoreProduct.model.Product;
import eStoreProduct.DAO.ProductDAO;
@Controller
//@ComponentScan(basePackages = "Products")
public class ProductController {

	private final ProductDAO pdaoimp;
	
	@Autowired
	public ProductController(ProductDAO productdao)
	{
	    pdaoimp=productdao;
	}

	@GetMapping("/CategoriesServlet")
	@ResponseBody
	public String displayCategories(Model model) {
		List<Category> categories = pdaoimp.getAllCategories();
		StringBuilder htmlContent = new StringBuilder();
		htmlContent.append("<option disabled selected>select Product category</option>");
		for (Category category : categories) {
			htmlContent.append("<option value='").append(category.getPrct_id()).append("'>").append(category.getPrct_title()).append("</option>");
		}

		return htmlContent.toString();
	}

	@GetMapping("/products")
	public String showCategoryProducts(@RequestParam(value = "category_id", required = false) Integer category_id,
			Model model) {
		System.out.println("based on category method" + category_id);

		List<Product> products;
		if (category_id != null && category_id != 0) {
			products = pdaoimp.getProductsByCategory(category_id);
		} else {
			products = pdaoimp.getAllProducts();
		}
		model.addAttribute("products", products);
		return "productCatalog";
	}
	
	
	@GetMapping("/productsDisplay")
	public String showAllProducts(Model model) {
	    //System.out.println("all prod display method mapping");
	    List<Product> products = pdaoimp.getAllProducts();

	    model.addAttribute("products", products);

	    return "productCatalog";
	}	
	@RequestMapping(value = "/prodDescription", method = RequestMethod.GET)
	public String getSignUpPage(Model model) {
		System.out.println("product description Page");

		// call the view
		return "prodDescription";
	}
	//prodDescription
	
	/*
	 * @GetMapping("/getProductDisplayed")
	 * 
	 * @ResponseBody public String showProductDetails(@RequestParam(value =
	 * "productDisplayed", required = false) Integer productId, Model model) {
	 * 
	 * int price = pdaoimp.getPriceOfProductById(productId);
	 * //model.addAttribute("product", product); return "price"; }
	 */
	@GetMapping("/getProductDisplayed")
	@ResponseBody
	public String showProductDetails(@RequestParam(value = "productDisplayed", required = false) Integer productId) {
	    int price = pdaoimp.getPriceOfProductById(productId);

	    // Create a JSON object to hold the price value
	    JsonObject jsonObject = new JsonObject();
	    jsonObject.addProperty("price", price);

	    // Convert the JSON object to a string
	    Gson gson = new Gson();
	    String json = gson.toJson(jsonObject);

	    return json;
	}
	
}