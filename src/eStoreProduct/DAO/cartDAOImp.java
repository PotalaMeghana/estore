package eStoreProduct.DAO;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class cartDAOImp implements cartDAO {
	JdbcTemplate jdbcTemplate;

	@Autowired
	public cartDAOImp(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public void addProduct(int productId, int customerId) throws SQLException {

	}
}