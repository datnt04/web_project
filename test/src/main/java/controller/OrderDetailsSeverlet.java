package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.OrderDetails;
import model.Orders;
import repository.OrderDetailsRepository;
import repository.OrderRepository;

@WebServlet("/orderdetails")
public class OrderDetailsSeverlet extends HttpServlet {
	private OrderRepository orderRepository = new OrderRepository();

	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        String orderIdStr = request.getParameter("orderId");

	        if (orderIdStr != null) {
	            try {
	                int orderId = Integer.parseInt(orderIdStr);
	                List<OrderDetails> detailsList = OrderDetailsRepository.findOrderDetailsByOrderId(orderId);

	                request.setAttribute("detailsList", detailsList);
	                request.getRequestDispatcher("/orderDetails.jsp").forward(request, response);
	            } catch (NumberFormatException e) {
	                response.sendRedirect("/order.jsp?error=invalidId");
	            }
	        } else {
	            response.sendRedirect("/order.jsp?error=missingId");
	        }
	    }
    
}
