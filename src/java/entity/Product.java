/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.text.DecimalFormat;

/**
 *
 * @author Beyond Nguyen
 */
public class Product {

    private int id;
    private String name;
    private String description;
    private double price;
    private double discount;
    private int categoryId;

    public Product() {
    }

    public Product(int id, String name, String description, double price, double discount, int categoryId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.categoryId = categoryId;
    }

    public String beforeDiscount() {
        double bDiscount = price / (1 - discount);
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        String beforeDiscount = decimalFormat.format(bDiscount);
        return beforeDiscount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

}
