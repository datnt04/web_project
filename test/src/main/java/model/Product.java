package model;

public class Product {
    private int productId;
    private String name;
    private double price;
    private int stock;
    private String description;
    private String categoryName;
    private String supplierName;
    private String imageUrl;
    private String author;

    public Product(int productId, String name, double price, int stock, String description,
                   String categoryName, String supplierName, String imageUrl, String author) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.categoryName = categoryName;
        this.supplierName = supplierName;
        this.imageUrl = imageUrl;
        this.author = author;
    }

    // Getters
    public int getProductId() { return productId; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getStock() { return stock; }
    public String getDescription() { return description; }
    public String getCategoryName() { return categoryName; }
    public String getSupplierName() { return supplierName; }
    public String getImageUrl() { return imageUrl; }
    public String getAuthor() { return author; }
}
