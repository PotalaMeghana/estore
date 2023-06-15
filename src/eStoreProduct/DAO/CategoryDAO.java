package eStoreProduct.DAO;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class CategoryDAO {
	JdbcTemplate jdbcTemplate;

	@Autowired
	public CategoryDAO(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public List<String> getAllCategories() {
		String query = "SELECT DISTINCT category FROM productsData";
		RowMapper<String> rowMapper = (resultSet, rowNum) -> resultSet.getString("category");
		return jdbcTemplate.query(query, rowMapper);
	}
}