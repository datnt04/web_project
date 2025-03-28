package controller;

import model.Orders;
import repository.OrderRepository;

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
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
}

