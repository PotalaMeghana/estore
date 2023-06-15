package eStoreProduct.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import eStoreProduct.DAO.CategoryDAO;
import eStoreProduct.DAO.ProductDAO;
import eStoreProduct.ProductsService.CategoryService;
import eStoreProduct.ProductsService.ProductService;
import eStoreProduct.model.Product;
import eStoreProduct.model.custCredModel;

@Controller
@ComponentScan(basePackages = "Products")
public class ProductController {

	private ProductService productService = null;
	private CategoryService categoryService;
	CategoryDAO categoryDAO;
	ProductDAO pdao;

	@Autowired
	public ProductController(ProductService productService, CategoryService categoryService, CategoryDAO categoryDAO,
			ProductDAO pdao) {
		this.productService = productService;
		this.categoryDAO = categoryDAO;// Instantiate the CategoryDAO class
		this.categoryService = new CategoryService(categoryDAO); // Pass CategoryDAO to CategoryService constructor
		this.pdao = pdao;
	}

	@GetMapping("/categories")
	public String showCategories(Model model) {
		return "prod";
	}

	@GetMapping("/CategoriesServlet")
	@ResponseBody
	public String displayCategories(Model model) {
		List<String> categories = categoryService.getAllCategories();

		StringBuilder htmlContent = new StringBuilder();
		htmlContent.append("<option disabled selected>Products</option>");
		for (String category : categories) {
			htmlContent.append("<option value='").append(category).append("'>").append(category).append("</option>");
		}

		return htmlContent.toString();
	}

	@GetMapping("/products")
	@ResponseBody
	public ModelAndView showCategoryProducts(@RequestParam(value = "category", required = false) String category,
			Model model) {
		List<Product> products = null;
		if (category != null && !category.isEmpty()) {
			products = pdao.getProductsByCategory(category);
		}
		ModelAndView modelAndView = new ModelAndView("productcatalog");
		modelAndView.addObject("products", products);
		// modelAndView.addObject("category", category);

		return modelAndView;
	}

	@GetMapping("/getsearchproduct")
	@ResponseBody
	public ModelAndView showsearchproducts(@RequestParam("pname") String pname, Model model) {
		List<Product> products;
		System.out.println(pname);
		products = pdao.getSearchProducts(pname);
		ModelAndView modelAndView = new ModelAndView("productcatalog");
		modelAndView.addObject("products", products);
		return modelAndView;

	}

	@GetMapping("/addToWishlist")
	@ResponseBody
	public String addToWishlist(@RequestParam(value = "productId", required = true) int productId, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		custCredModel cust = (custCredModel) session.getAttribute("customer");
		int custid = cust.getCustId();
		System.out.println(custid);
		System.out.println("add to wishlist called1");
		return pdao.addToWishlist(productId, custid) + " Added to wishlist";

	}

	@GetMapping("/removeFromWishlist")
	@ResponseBody
	public String removeFromWishlist(@RequestParam(value = "productId", required = true) int productId, Model model)
			throws NumberFormatException, SQLException {
		System.out.println("remove from wishlist called1");
		System.out.println("remove from wishlist called2");
		return pdao.removeFromWishlist(productId) + " remove from wishlist";

	}

	@GetMapping("/wishlistItems")
	@ResponseBody
	public ModelAndView userWishlistItems(@RequestParam(value = "userId", required = true) int cust_id, Model model)
			throws NumberFormatException, SQLException {
		List<Product> products = null;
		System.out.println("wishlist called in controller product");
		products = pdao.getWishlistProds(cust_id);
		for (Product p : products) {
			System.out.println(p.getId());
		}
		ModelAndView modelAndView = new ModelAndView("wishlistcatalog");
		modelAndView.addObject("products", products);

		return modelAndView;
	}

}