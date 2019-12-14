package com.sportequipment.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sportequipment.dao.EquipmentDao;
import com.sportequipment.dao.impl.EquipmentDaoImpl;
import com.sportequipment.domain.Admin;
import com.sportequipment.domain.Equipment;
import com.sportequipment.domain.Page;
import com.sportequipment.domain.User;
import com.sportequipment.service.EquipmentService;
import com.sportequipment.service.impl.EquipmentServiceImpl;

@WebServlet(urlPatterns = "/equipmentServlet")
public class EquipmentServlet extends HttpServlet {

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
		EquipmentService equipmentservice = new EquipmentServiceImpl();
		if (opr.equals("add")) {
			
			Equipment equipment = new Equipment();
			SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
			
			Admin admin = (Admin)request.getSession().getAttribute("admin");			
			equipment.setEquipmentId(request.getParameter("equipmentId"));
			equipment.setEquipmentName(request.getParameter("equipmentName"));
			equipment.setEquipmentType(request.getParameter("equipmentType"));
			equipment.setEquipmentPrice(Float.parseFloat(request.getParameter("equipmenPrice")));
			equipment.setEquipmentAmount(Integer.parseInt(request.getParameter("equipmennumber")));
			equipment.setOperatPerson(admin.getAdminName());
			equipment.setEquipmentspecification(request.getParameter("equipmentSpecification"));
			
			try {
				equipment.setPutime(dateformat.parse(dateformat.format(new Date())));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			try {
				if (equipmentservice.addEquipment(equipment) > 0) {
			/*		request.getRequestDispatcher("/addequipment").forward(request,response);
					out.print("<script>alert('?????');</script>");
					*/
					out.print("<script>alert('???????');location='"
							+ request.getHeader("Referer") + "'</script>");
				} else {
					
					request.getRequestDispatcher("/addequipment").forward(request,response);
					out.print("<script>alert('??????');</script>");
				}
			} catch (Exception e) {
				out.print("<script>alert('??????:" + e.getMessage()+ "');</script>");
			}
		}else if(opr.equals("equipmentPage")){
			
			String pageNo = request.getParameter("pageNo") == null ? "1": request.getParameter("pageNo"); //????????????
			
            String equipmentId=request.getParameter("equipmentId") == null ? "": request.getParameter("equipmentId");
            String equipmentName=request.getParameter("equipmentName") == null ? "": request.getParameter("equipmentName");
            String equipmentType=request.getParameter("equipmentType") == null ? "": request.getParameter("equipmentType");
            String operatPerson=request.getParameter("operatPerson") == null ? "": request.getParameter("operatPerson");
            String equipmentspecification=request.getParameter("equipmentSpecification") == null ? "": request.getParameter("equipmentSpecification");
            
         /*  out.write(pageNo+"  "+equipmentId+"  "+equipmentName+"  "+equipmentType+"  "+operatPerson+"  "+equipmentspecification);*/
           
            Page<Equipment> page=new Page<Equipment>();  
            
            page.setPageNo(Integer.parseInt(pageNo));
            
            page.setPageSize(4);
            
            EquipmentDao equipmentdao = new EquipmentDaoImpl();
            try {
            	//??????????????
				page.setTotalCount(equipmentdao.getTotalCount(equipmentId, equipmentName, equipmentType, operatPerson, equipmentspecification));
				
				//??????????????
				page.setList(equipmentservice.getEquipmentsByPage(page.getPageNo(), page.getPageSize(),equipmentId, equipmentName, equipmentType, operatPerson, equipmentspecification));
				
				request.setAttribute("equipmentPage",page); //??page???????request????page(???????????????????????)
				request.getRequestDispatcher("/equipmentSelectByPage").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(opr.equals("delequipment")){
			
			String equipmentId = request.getParameter("equipmentId");
			int equipmentAmount = Integer.valueOf(request.getParameter("equipmentAmount"));
			try {
			
				if(equipmentservice.deleteEquipment(equipmentId, equipmentAmount) > 0){
					out.print("<script>alert('??????');location='equipmentServlet?opr=equipmentPage';</script>");
				}else{
					out.print("<script>alert('??????');location='equipmentServlet?opr=equipmentPage';</script>");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(opr.equals("maintainquipment")){
			String equipmentId = request.getParameter("equipmentId");
			int equipmentAmount = Integer.valueOf(request.getParameter("equipmentAmount"));
			try {
				if(equipmentservice.maintainEquipment(equipmentId,equipmentAmount) > 0){
					out.print("<script>alert('???ио??');location='equipmentServlet?opr=equipmentPage';</script>");
				}else{
					out.print("<script>alert('???????');location='equipmentServlet?opr=equipmentPage';</script>");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		out.flush();
		out.close();
	}

}
