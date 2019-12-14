package com.sportequipment.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sportequipment.domain.Admin;
import com.sportequipment.domain.Apply;
import com.sportequipment.domain.Page;
import com.sportequipment.domain.User;
import com.sportequipment.service.ApplyService;
import com.sportequipment.service.impl.ApplyServiceImpl;
@WebServlet(urlPatterns = "/applyServlet")
public class ApplyServlet extends HttpServlet {

	
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
		
		ApplyService applyserice = new ApplyServiceImpl();
		if (opr.equals("myApplyPage")) {

			String equipmentId = request.getParameter("equipmentId") == null ? ""
					: request.getParameter("equipmentId");
			Page<Apply> page = new Page<Apply>();

		    page.setPageNo(1);
			page.setPageSize(10);
			try {
				
				User user = (User) request.getSession().getAttribute("user");
				
				page.setList(applyserice.getApplysByPage(page.getPageNo(), page.getPageSize(), equipmentId,user.getLoginname(), 0, null)); // 获取当前页数据集合

				
				request.setAttribute("applyPage", page); // 将page对象存入request对象：page(总记录，总页数，当前页数数据)

				request.getRequestDispatcher("/myApply").forward(
						request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(opr.equals("deleteMyApply")) {

			String equipmentId = request.getParameter("equipmentId");
			String loginName = request.getParameter("loginName");
			Page<Apply> page = new Page<Apply>();
			try {
				if(applyserice.deleteMyApply(loginName,equipmentId) > 0 ){
					out.print("<script>alert('归还失败');location='applyServlet?opr=myApplyPage';</script>");
				}else{
					out.print("<script>alert('归还失败');location='applyServlet?opr=myApplyPage';</script>");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (opr.equals("allApplyPage")) {
			
			String loginName = request.getParameter("loginName") == null ? ""
					: request.getParameter("loginName");
			
			String equipmentId = request.getParameter("equipmentId") == null ? ""
					: request.getParameter("equipmentId");
			Page<Apply> page = new Page<Apply>();
			
		    page.setPageNo(1);
			page.setPageSize(10);
			try {
				
				User user = (User) request.getSession().getAttribute("user");
				
				page.setList(applyserice.getApplysByPage(page.getPageNo(), page.getPageSize(), equipmentId,loginName, 0, null)); // 获取当前页数据集合

				
				request.setAttribute("applyPage", page); // 将page对象存入request对象：page(总记录，总页数，当前页数数据)

				request.getRequestDispatcher("/allApply").forward(
						request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (opr.equals("passApply")) {
			
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			String equipmentId = request.getParameter("equipmentId");
			String loginName = request.getParameter("loginName");
			int equipmentcount = Integer.valueOf(request.getParameter("equipmentcount"));
			try {
				if(applyserice.passApply(equipmentId, loginName, equipmentcount, admin.getAdminName()) > 0){
					out.print("<script>alert('审核通过');location='applyServlet?opr=allApplyPage';</script>");
				}else{
					out.print("<script>alert('审核失败');location='applyServlet?opr=allApplyPage';</script>");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		out.flush();
		out.close();
	}

}
