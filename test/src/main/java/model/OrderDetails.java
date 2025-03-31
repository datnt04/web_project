package model;

public class OrderDetails {
	private int orderDetailID;
	private int orderId;
	private int productID;
	private int quantity;
	private double unitPrice;
	private double Subtotal;
	public OrderDetails() {
		super();
	}
	public OrderDetails(int orderDetailID, int orderId, int productID, int quantity, double unitPrice,
			double subtotal) {
		super();
		this.orderDetailID = orderDetailID;
		this.orderId = orderId;
		this.productID = productID;
		quantity = quantity;
		this.unitPrice = unitPrice;
		Subtotal = subtotal;
	}
	public int getOrderDetailID() {
		return orderDetailID;
	}
	public void setOrderDetailID(int orderDetailID) {
		this.orderDetailID = orderDetailID;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
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
	public double getSubtotal() {
		return Subtotal;
	}
	public void setSubtotal(double subtotal) {
		Subtotal = subtotal;
	}
	
	
}
