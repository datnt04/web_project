package service;

import model.Product;
import repository.ProductRepository;
import java.util.List;

public class ProductService {
    private final ProductRepository productRepository = new ProductRepository();

    public List<Product> getAllBooks() {
        return productRepository.findAllBooks();
    }
    public Product getProductById(int id) {
        return productRepository.findById(id);
    }
    public boolean deleteBook(int bookId) {
        return productRepository.deleteBookById(bookId);
    }
}
