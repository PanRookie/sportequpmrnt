package com.sportequipment.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sportequipment.dao.MaintainDao;
import com.sportequipment.dao.impl.MaintainDaoImpl;
import com.sportequipment.domain.Maintain;
import com.sportequipment.domain.Page;
import com.sportequipment.service.MaintainService;
import com.sportequipment.service.impl.MaintainServiceImpl;

@WebServlet(urlPatterns = "/maintainServlet")
public class MaintainServlet extends HttpServlet {


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
		MaintainService maintainserivce = new MaintainServiceImpl();
		 if(opr.equals("equipmentPage")){
				
				String pageNo = request.getParameter("pageNo") == null ? "1": request.getParameter("pageNo"); //默认为第一个页面
				
	            String equipmentId=request.getParameter("equipmentId") == null ? "": request.getParameter("equipmentId");
	            String equipmentName=request.getParameter("equipmentName") == null ? "": request.getParameter("equipmentName");
	            String equipmentType=request.getParameter("equipmentType") == null ? "": request.getParameter("equipmentType");
	            String operatPerson=request.getParameter("operatPerson") == null ? "": request.getParameter("operatPerson");
	            String equipmentspecification=request.getParameter("equipmentSpecification") == null ? "": request.getParameter("equipmentSpecification");
	            
	            Page<Maintain> page=new Page<Maintain>();  
	            
	            page.setPageNo(Integer.parseInt(pageNo));
	            
	            page.setPageSize(4);
	            
	            MaintainDao maintaindao = new MaintainDaoImpl();
	            try {
	            	//获取数据记录总个数
					page.setTotalCount(maintaindao.getTotalCount(equipmentId, equipmentName, equipmentType, operatPerson, equipmentspecification));
					
					//获取当前页数据集合
					
					page.setList(maintainserivce.getEquipmentsByPage(page.getPageNo(), page.getPageSize(), equipmentId, equipmentName, equipmentType, operatPerson, equipmentspecification));
					
					request.setAttribute("maintainPage",page); //将page对象存入request对象：page(总记录，总页数，当前页数数据)

					request.getRequestDispatcher("/maintainSelectByPage").forward(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
		 }
		out.flush();
		out.close();
	}

}
