package controller;

import model.Orders;
import repository.OrderRepository;
import service.OrderSevice;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderSeverlet extends HttpServlet {
    private OrderRepository orderRepository = new OrderRepository();
   
        protected void doGet (HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String searchKeyword = request.getParameter("search");
            List<Orders> orders;
            
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                orders = orderRepository.searchOrders(searchKeyword); 
            } else {
                orders = orderRepository.findAllOrders(); 
            }
            request.setAttribute("ordersList", orders);
            request.getRequestDispatcher("/order.jsp").forward(request, response);
        }
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String action = request.getParameter("action");

            if ("delete".equals(action)) {
                String orderIdStr = request.getParameter("orderId");
                if (orderIdStr != null) {
                    try {
                        int orderId = Integer.parseInt(orderIdStr);
                        boolean success = orderRepository.deleteOrder(orderId);
                        if (success) {
                            response.sendRedirect("/orders.jsp?success=deleted");
                        } else {
                            response.sendRedirect("/orders.jsp?error=notfound");
                        }
                    } catch (NumberFormatException e) {
                        response.sendRedirect("/orders.jsp?error=invalidId");
                    }
                } else {
                    response.sendRedirect("/orders.jsp?error=missingId");
                }
            }
        }
} 	
        
        


