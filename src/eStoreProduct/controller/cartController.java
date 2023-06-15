package eStoreProduct.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import eStoreProduct.DAO.ProductDAO;
import eStoreProduct.DAO.customerDAO;
import eStoreProduct.ProductsService.BLLClass;
import eStoreProduct.model.Product;
import eStoreProduct.model.custCredModel;

@Controller
@ComponentScan(basePackages = "Products")
public class cartController {
	BLLClass obj = new BLLClass();
	ProductDAO pdao;
	customerDAO cdao;

	List<Product> alist = new ArrayList<>();

	@Autowired
	public cartController(customerDAO customerdao, ProductDAO pdao) {
		cdao = customerdao;

		this.pdao = pdao;
	}

	@GetMapping("/addToCart")
	@ResponseBody
	public String addToCart(@RequestParam(value = "productId", required = true) int productId, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			System.out.println("add to cart called1");
			return pdao.addToCart(productId, cust1.getCustId()) + " Added to cart";
		} else {
			Product product = pdao.getProductById(productId);
			System.out.println("added to cart " + product.getId());
			System.out.println(product);
			alist.add(product);
			return "added to cart";
		}
	}

	@GetMapping("/removeFromCart")
	@ResponseBody
	public String removeFromCart(@RequestParam(value = "productId", required = true) int productId, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		obj.remove(productId);
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			System.out.println("remove from cart login");

			return pdao.removeFromCart(productId) + " remove from cart";
		} else {
			System.out.println("remove from cart nonlogin");
			for (Product p : alist) {
				if (p.getId() == productId)

					alist.remove(p);
			}

			return "remove from cart";
		}
	}

	@GetMapping("/cartItems")
	@ResponseBody
	public ModelAndView userCartItems(@RequestParam(value = "userId", required = true) int cust_id, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		double cartt = 0;
		List<Product> products = null;
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			products = pdao.getcartProds(cust1.getCustId());
			cartt = obj.calcartp(products);
			ModelAndView modelAndView = new ModelAndView("cartcatalog");
			modelAndView.addObject("products", products);
			modelAndView.addObject("cartt", cartt);

			return modelAndView;
		} else {
			ModelAndView modelAndView = new ModelAndView("cartcatalog");
			modelAndView.addObject("products", alist);
			modelAndView.addObject("cartt", cartt);

			return modelAndView;
		}
	}

	@PostMapping("/updateQuantity")
	@ResponseBody
	public String tity(@RequestParam("quantity") int quantity,
			@RequestParam(value = "productId", required = true) int productId) {
		obj.updateQty(productId, quantity);
		int price = obj.getupdateprice();
		System.out.println("price:" + price);
		System.out.print(quantity);
		System.out.print("productid");
		String priceString = "" + price;
		return priceString;
	}

	@GetMapping("/buycartitems")
	public String confirmbuycart(Model model, HttpSession session) {
		HashMap<Integer, Integer> hm = obj.getItemsqty();
		HashMap<Integer, Integer> h = obj.gethmprice();

		List<Product> products = null;
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		products = pdao.getcartProds(cust1.getCustId());
		model.addAttribute("products", products);
		model.addAttribute("hm", hm);
		model.addAttribute("h", h);

		return "paymentcart";

	}

	@GetMapping("/confirmShipmentAddress")
	@ResponseBody
	public String confirm(@RequestParam("shipmentadd") String shaddr, Model model, HttpSession session) {
		System.out.println("confirm shipmentaddress");
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");

		cdao.updateshipmentaddress(cust1.getCustId(), shaddr);
		return "OK";

	}

	@GetMapping("/useecash")
	@ResponseBody
	public String confirmecash(Model model) {
		System.out.println("confirm ecash");
		int amt = 2000;
		model.addAttribute("amt", amt);
		return "ecash";

	}

	/*
	 * @RequestMapping(value = "/done", method = { RequestMethod.POST }) public String orderCreation(Model model) {
	 * System.out.println("Order creation..."); return "payment"; }
	 */
	@GetMapping("/done")
	public String orderCreation(Model model) {
		System.out.println("hiiiiiiiiii");
		return "redirect:/OrderCreation";
	}

	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public String showPaymentOptions(Model model) {
		return "payment";
	}
}
