/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class Cart {

    private int cartId;
    private int userId;
    private List<CartItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public void addItem(CartItem item) {
        items.add(item);
    }

    public double getTotal() {
        double total = 0;
        for (CartItem item : items) {
            // Tự tính tổng, không gọi getSubtotal() nữa
            total += (item.getUnitPrice() * item.getQuantity());
        }
        return total;
    }
}
