package model;

public class ProductsAdmin {

    private int productId;
    private int categoryId;
    private String productName;
    private String description;
    private String imageUrl;
    private double price;
    private int quantity;
    private String color;
    private String size;
    private String gender;
    private boolean trending;
    private String categoryName;

    public ProductsAdmin() {
    }

    public ProductsAdmin(int productId, String productName, double price, int categoryId, int quantity, String description) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
    }

    public ProductsAdmin(int productId, int categoryId, String productName, String description,
            String imageUrl, double price, int quantity, String color, String size,
            String gender, boolean trending) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.description = description;
        this.imageUrl = imageUrl;
        this.price = price;
        this.quantity = quantity;
        this.color = color;
        this.size = size;
        this.gender = gender;
        this.trending = trending;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public boolean isTrending() {
        return trending;
    }

    public void setTrending(boolean trending) {
        this.trending = trending;
    }

    @Override
    public String toString() {
        return "Products{" + "productId=" + productId + ", categoryId=" + categoryId + ", productName=" + productName + ", description=" + description + ", imageUrl=" + imageUrl + ", price=" + price + ", quantity=" + quantity + ", color=" + color + ", size=" + size + ", gender=" + gender + ", trending=" + trending + ", categoryName=" + categoryName + '}';
    }

}
