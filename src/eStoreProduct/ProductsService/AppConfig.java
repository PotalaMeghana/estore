package eStoreProduct.ProductsService;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

	@Bean
	public RazorpyService razorpayService() {
		RazorpyService razorpayService = new RazorpyService();
		razorpayService.setRazorpayApiKey("rzp_test_Xe8wdVU6XUBoBd");
		razorpayService.setRazorpayApiSecret("Y0kKhdQLoVJQALAJ4iHNN0Sq");
		return razorpayService;
	}

	// Other bean definitions and configuration methods...
}
