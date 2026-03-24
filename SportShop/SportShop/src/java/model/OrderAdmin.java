package model;

import java.sql.Timestamp;

public class OrderAdmin {

    private int orderId;
    private Integer cartId;
    private int userId;
    private Timestamp orderDate;
    private String address;
    private double totalPrice;
    private String status;
    private String trackingNumber;
    private String userFullName;

    public OrderAdmin() {
    }

    public OrderAdmin(int orderId, int userId, Timestamp orderDate, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.status = status;
    }

    public OrderAdmin(int orderId, Integer cartId, int userId, Timestamp orderDate, String address, double totalPrice, String status, String trackingNumber, String userFullName) {
        this.orderId = orderId;
        this.cartId = cartId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.address = address;
        this.totalPrice = totalPrice;
        this.status = status;
        this.trackingNumber = trackingNumber;
        this.userFullName = userFullName;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", cartId=" + cartId + ", userId=" + userId + ", orderDate=" + orderDate + ", address=" + address + ", totalPrice=" + totalPrice + ", status=" + status + ", trackingNumber=" + trackingNumber + ", userFullName=" + userFullName + '}';
    }

}
