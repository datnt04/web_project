package model;

import java.security.Timestamp;

public class Orders {
    private int orderId;
    private String customerId;
    private String orderDate;
    private double totalAmount;
    private String orderNotes;
    private String couponCode;
    private  double discountAmount;
    private String paymentMethod;
    private String status;
    public Orders() {
    }

    public Orders(String customerId, int orderId, String orderDate, double totalAmount, String orderNotes, String couponCode, double discountAmount, String paymentMethod, String status) {
        this.customerId = customerId;
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.orderNotes = orderNotes;
        this.couponCode = couponCode;
        this.discountAmount = discountAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getOrderNotes() {
		return orderNotes;
	}

	public void setOrderNotes(String orderNotes) {
		this.orderNotes = orderNotes;
	}

	public String getCouponCode() {
		return couponCode;
	}

	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}

	public double getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(double discountAmount) {
		this.discountAmount = discountAmount;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

  
}