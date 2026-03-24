package model;

import java.math.BigDecimal;

public class Payment {
    private int paymentId;
    private int orderId;
    private String method;
    private String status;
    private double amount;

    public Payment() {
    }

    public Payment(int paymentId, int orderId, String method, String status, double amount) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.method = method;
        this.status = status;
        this.amount = amount;
    }

    

    // GETTERS & SETTERS
    public int getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public String getMethod() {
        return method;
    }
    public void setMethod(String method) {
        this.method = method;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
    
}
