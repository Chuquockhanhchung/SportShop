package model;

public class CartItem {
    private int cartItemId;
    private int productId;
    private String productName;
    private int quantity;
    private double unitPrice;
    private String imageUrl; // <-- thêm dòng này

    // Getter và Setter
    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getImageUrl() {   // <-- getter
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {  // <-- setter
        this.imageUrl = imageUrl;
    }

    public double getSubtotal() {
        return unitPrice * quantity;
    }
}