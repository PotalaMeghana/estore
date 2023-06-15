package eStoreProduct.ProductsService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import eStoreProduct.DAO.CategoryDAO;

public class CategoryService {
	private CategoryDAO categoryDAO;

	@Autowired
	public CategoryService(CategoryDAO categoryDAO) {
		this.categoryDAO = categoryDAO;
	}

	public CategoryService() {
		// TODO Auto-generated constructor stub
	}

	public List<String> getAllCategories() {
		return categoryDAO.getAllCategories();
	}
}