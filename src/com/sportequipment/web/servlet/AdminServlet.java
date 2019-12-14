package com.sportequipment.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sportequipment.domain.Admin;
import com.sportequipment.service.AdminService;
import com.sportequipment.service.impl.AdminServiceImpl;

@WebServlet(urlPatterns = "/adminServlet")
public class AdminServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");
		String opr = request.getParameter("opr");
		AdminService adminservice = new AdminServiceImpl();
		if ("login".equals(opr)) {
			
				String loginName = request.getParameter("adminacount");
				String loginpassword = request.getParameter("password");
				try {
					Admin admin = adminservice.adminLogin(loginName,loginpassword);
					if (admin != null) {
						out.print("<script>alert('��¼�ɹ�');</script>");
						HttpSession session = request.getSession();
						session.setAttribute("admin", admin);
						request.getRequestDispatcher("/frame").forward(request,
								response);
					} else {
						out.print("<script>alert('��¼ʧ��');location='adminlogin.jsp';</script>");
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("err", "������˼�������ˣ������ԡ�");
					request.getRequestDispatcher("adminlogin.jsp").forward(request,
							response);
				}

			}
		
		out.flush();
		out.close();
	}

}
