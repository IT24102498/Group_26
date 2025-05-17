package com.eventticket.model;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileWriter;
import java.io.IOException;

@WebServlet(name = "ProcessPayment", urlPatterns = {"/ProcessPayment"})
public class ProcessPayment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cn = req.getParameter("cardNumber");
        String expDate = req.getParameter("expiryDate");
        String cvv = req.getParameter("cvv");
        String cardHolderName = req.getParameter("cardName");
        String username = req.getParameter("username");
        String email = req.getParameter("email");

        String fileName = "E:\\UNI\\eventticket\\PaymentDetails.txt";
        try (FileWriter fw = new FileWriter(fileName)) {
            fw.write("Username: " + username + "\n");
            fw.write("Email: " + email + "\n");
            fw.write("Card Number: " + cn + "\n");
            fw.write("Expire Date: " + expDate + "\n");
            fw.write("CVV: " + cvv + "\n");
            fw.write("Card Holder Name: " + cardHolderName + "\n");


            resp.sendRedirect("confirmation.jsp");


        } catch (IOException e) {
            e.getMessage();
        }
    }
}
