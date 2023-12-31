/*
 * package eStoreProduct.model;
 * 
 * public class Product { private int id; private String name; private double
 * price; private String description; private String imageUrl; private String
 * category;
 * 
 * public Product(int id, String name, double price, String description, String
 * imageUrl, String category) { this.id = id; this.name = name; this.price =
 * price; this.description = description; this.imageUrl = imageUrl;
 * this.category = category; }
 * 
 * // Getters and setters for the class properties
 * 
 * public int getId() { return id; }
 * 
 * public void setId(int id) { this.id = id; }
 * 
 * public String getName() { return name; }
 * 
 * public void setName(String name) { this.name = name; }
 * 
 * public double getPrice() { return price; }
 * 
 * public void setPrice(double price) { this.price = price; }
 * 
 * public String getDescription() { return description; }
 * 
 * public void setDescription(String description) { this.description =
 * description; }
 * 
 * public String getImageUrl() { return imageUrl; }
 * 
 * public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
 * 
 * public String getCategory() { return category; }
 * 
 * public void setCategory(String category) { this.category = category; } }
 */



package eStoreProduct.model;

public class Product {

	private int prod_id;
	private String prod_title;
	private int prod_prct_id;
	private int prod_gstc_id;
	private String prod_brand;
	private String image_url;
	private String prod_desc;
	private int reorderLevel;

	public Product(int prod_id, String prod_title, int prod_prct_id, int prod_gstc_id, String prod_brand,
			String image_url, String prod_desc, int reorderLevel) {
		super();
		this.prod_id = prod_id;
		this.prod_title = prod_title;
		this.prod_prct_id = prod_prct_id;
		this.prod_gstc_id = prod_gstc_id;
		this.prod_brand = prod_brand;
		this.image_url = image_url;
		this.prod_desc = prod_desc;
		this.reorderLevel = reorderLevel;
	}

	public int getProd_id() {
		return prod_id;
	}

	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}

	public String getProd_title() {
		return prod_title;
	}

	public void setProd_title(String prod_title) {
		this.prod_title = prod_title;
	}

	public int getProd_prct_id() {
		return prod_prct_id;
	}

	public void setProd_prct_id(int prod_prct_id) {
		this.prod_prct_id = prod_prct_id;
	}

	public int getProd_gstc_id() {
		return prod_gstc_id;
	}

	public void setProd_gstc_id(int prod_gstc_id) {
		this.prod_gstc_id = prod_gstc_id;
	}

	public String getProd_brand() {
		return prod_brand;
	}

	public void setProd_brand(String prod_brand) {
		this.prod_brand = prod_brand;
	}

	public String getImage_url() {
		return image_url;
	}

	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}

	public String getProd_desc() {
		return prod_desc;
	}

	public void setProd_desc(String prod_desc) {
		this.prod_desc = prod_desc;
	}

	public int getReorderLevel() {
		return reorderLevel;
	}

	public void setReorderLevel(int reorderLevel) {
		this.reorderLevel = reorderLevel;
	}
}