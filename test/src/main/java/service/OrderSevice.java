package service;

import model.Orders;
import model.Product;
import repository.OrderRepository;
import repository.ProductRepository;

import java.util.List;

public class OrderSevice {
    private  OrderRepository orderRepository = new OrderRepository();
    public List<Orders> getAllOrders() {
        return orderRepository.findAllOrders();
    }
    public List<Orders> getAllBooks() {
        return orderRepository.findAllOrders();
    }
    public Orders getProductById(int id) {
        return orderRepository.findById(id);
    }
    public Orders searchOrders(String keyword) {

        try {
            int orderId = Integer.parseInt(keyword);
            Orders order = orderRepository.findById(orderId);
            return order;
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
