/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LE DUC ANH
 */
public class DashBoardStats {

    private int totalOrders;
    private int totalItemsSold;
    private int totalInventory;
    private double revenue;
    private String formattedRevenue; // ví dụ: "1,200,000 VND"

    public DashBoardStats() {
    }

    public DashBoardStats(int totalOrders, int totalItemsSold, int totalInventory,
            double revenue, String formattedRevenue) {
        this.totalOrders = totalOrders;
        this.totalItemsSold = totalItemsSold;
        this.totalInventory = totalInventory;
        this.revenue = revenue;
        this.formattedRevenue = formattedRevenue;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getTotalItemsSold() {
        return totalItemsSold;
    }

    public void setTotalItemsSold(int totalItemsSold) {
        this.totalItemsSold = totalItemsSold;
    }

    public int getTotalInventory() {
        return totalInventory;
    }

    public void setTotalInventory(int totalInventory) {
        this.totalInventory = totalInventory;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    public String getFormattedRevenue() {
        return formattedRevenue;
    }

    public void setFormattedRevenue(String formattedRevenue) {
        this.formattedRevenue = formattedRevenue;
    }
}
