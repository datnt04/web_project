package service;

import java.util.List;

import model.OrderDetails;
import repository.OrderDetailsRepository;

public class OrderDetailsService  {
	 private final OrderDetailsRepository orderRepository = new OrderDetailsRepository();

	    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
	        return orderRepository.findOrderDetailsByOrderId(orderId);
	    }
}
