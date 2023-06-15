package eStoreProduct.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import eStoreProduct.model.Product;

public class ProductDAO {
	JdbcTemplate jdbcTemplate;
	double totalcartcost = 0;

	@Autowired
	public ProductDAO(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public List<Product> getProductsByCategory(String category) {
		String query = "SELECT * FROM productsData WHERE category = ?";
		Object[] params = { category };
		RowMapper<Product> rowMapper = (resultSet, rowNum) -> {
			int id = resultSet.getInt("id");
			String name = resultSet.getString("name");
			double price = resultSet.getDouble("price");
			String description = resultSet.getString("description");
			String imageUrl = resultSet.getString("image_url");
			return new Product(id, name, price, description, imageUrl, category);
		};
		return jdbcTemplate.query(query, params, rowMapper);
	}

	public int addToCart(int productId, int customerId) {
		String query = "INSERT INTO slam_cart(c_id, p_id) VALUES (?, ?)";
		return jdbcTemplate.update(query, customerId, productId);
	}

	public int addToWishlist(int productId, int customerId) {

		String query = "INSERT INTO slam_wishlist(c_id,p_id) VALUES (?, ?)";

		return jdbcTemplate.update(query, customerId, productId);
	}

	public int removeFromCart(int productId) {
		String query = "DELETE FROM slam_cart WHERE p_id=?";
		return jdbcTemplate.update(query, productId);
	}

	public int removeFromWishlist(int productId) {
		String query = "DELETE FROM SLAM_WISHLIST WHERE p_id=?";
		return jdbcTemplate.update(query, productId);
	}

	public Product getProductById(int productId) {
		String query = "SELECT * FROM productsdata WHERE id = ?";
		Object[] params = { productId };

		Product product = jdbcTemplate.queryForObject(query, params, new RowMapper<Product>() {
			@Override
			public Product mapRow(ResultSet resultSet, int rowNum) throws SQLException {
				Product product = new Product();
				product.setId(resultSet.getInt("id"));
				product.setName(resultSet.getString("name"));
				product.setImageUrl(resultSet.getString("image_url"));
				product.setCategory(resultSet.getString("category"));
				product.setDescription(resultSet.getString("description"));
				product.setPrice(resultSet.getDouble("price"));
				return product;
			}
		});

		return product;
	}

	public List<Product> getcartProds(int cust_id) {
		totalcartcost = 0;
		String query = "SELECT pd.* FROM productsdata pd, slam_cart sc WHERE sc.c_id = ? AND sc.p_id = pd.id";
		RowMapper<Product> rowMapper = (resultSet, rowNum) -> {
			int id = resultSet.getInt("id");
			String name = resultSet.getString("name");
			double price = resultSet.getDouble("price");
			addcartcost(price);
			String description = resultSet.getString("description");
			String imageUrl = resultSet.getString("image_url");
			String category = resultSet.getString("category");
			return new Product(id, name, price, description, imageUrl, category);
		};
		return jdbcTemplate.query(query, new Object[] { cust_id }, rowMapper);

	}

	/*
	 * public List<Product> getWishlistProds(int cust_id) { String query =
	 * "select pd.* from productsdata pd ,slam_wishlist sc where sc.c_id=? and sc.p_id=pd.id"; RowMapper<Product>
	 * rowMapper = (resultSet, rowNum) -> { int id = resultSet.getInt("id"); String name = resultSet.getString("name");
	 * double price = resultSet.getDouble("price"); String description = resultSet.getString("description"); String
	 * imageUrl = resultSet.getString("image_url"); String category = resultSet.getString("category"); return new
	 * Product(id, name, price, description, imageUrl, category); }; List<Product> prd = jdbcTemplate.query(query, new
	 * Object[] { cust_id }, rowMapper); for (Product p : prd) { System.out.println(p.getId()); } return prd; }
	 */
	public List<Product> getWishlistProds(int custId) {
		System.out.println("wishlist method");

		String query = "SELECT pd.* FROM productsdata pd, slam_wishlist sc WHERE sc.c_id = ? AND sc.p_id = pd.id";
		RowMapper<Product> rowMapper = (resultSet, rowNum) -> {
			int id = resultSet.getInt("id");
			String name = resultSet.getString("name");
			double price = resultSet.getDouble("price");
			String description = resultSet.getString("description");
			String imageUrl = resultSet.getString("image_url");
			String category = resultSet.getString("category");
			return new Product(id, name, price, description, imageUrl, category);
		};

		List<Product> products = jdbcTemplate.query(query, new Object[] { custId }, rowMapper);

		for (Product p : products) {
			System.out.println("hiiiiiiiiiiiiiiiii");
		}

		return products;
	}

	public List<Product> getSearchProducts(String pname) {
		String sql = "SELECT * FROM productsData WHERE name ILIKE ? or category ILIKE ?";
		Object[] params = { "%" + pname + "%", "%" + pname + "%" };
		RowMapper<Product> rowMapper = (resultSet, rowNum) -> {
			int id = resultSet.getInt("id");
			String name = resultSet.getString("name");
			double price = resultSet.getDouble("price");
			String description = resultSet.getString("description");
			String imageUrl = resultSet.getString("image_url");
			String category = resultSet.getString("category");
			return new Product(id, name, price, description, imageUrl, category);
		};
		return jdbcTemplate.query(sql, params, rowMapper);
	}

	public double getcartcost() {
		return totalcartcost;
	}

	public void addcartcost(double p) {
		totalcartcost += p;
	}
}
