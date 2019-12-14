package com.sportequipment.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.sportequipment.dao.BorrowDao;
import com.sportequipment.dao.impl.BorrowDaoImpl;
import com.sportequipment.domain.Admin;
import com.sportequipment.domain.Borrow;
import com.sportequipment.domain.Equipment;
import com.sportequipment.domain.Page;
import com.sportequipment.domain.User;
import com.sportequipment.service.BorrowService;
import com.sportequipment.service.EquipmentService;
import com.sportequipment.service.UserService;
import com.sportequipment.service.impl.BorrowServiceImpl;
import com.sportequipment.service.impl.EquipmentServiceImpl;
import com.sportequipment.service.impl.UserServiceImpl;
import com.sportequipment.util.SecurityUtils;

@WebServlet(urlPatterns = "/borrowServlet")
public class BorrowServlet extends HttpServlet {

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
		UserService userservice = new UserServiceImpl();
		BorrowService borrowservice = new BorrowServiceImpl();
		EquipmentService equipmentserivce = new EquipmentServiceImpl();
		if ("adminborrow".equals(opr)) {
			Admin admin = (Admin) request.getSession().getAttribute("admin"); //
			String loginName = request.getParameter("loginName");
			String password = SecurityUtils.md5Hex(request
					.getParameter("password"));

			String equipmentId = request.getParameter("equipmentId");
			int equipmennumber = Integer.valueOf(request
					.getParameter("equipmennumber"));
			String operatperson = admin.getAdminName();
			try {

				if (userservice.userLogin(loginName, password) != null
						& equipmentserivce.getEquipmentById(equipmentId) != null) {
					int executepunctuation = borrowservice.lendEquipment(
							loginName, equipmentId, operatperson,
							equipmennumber);
					if (executepunctuation == 3) {
						request.setAttribute("borrowErr", "借出成功");
						request.getRequestDispatcher("/borrowequipment")
								.forward(request, response);
					} else if (executepunctuation == 4) {
						request.setAttribute("borrowErr", "库中已无该球");
						request.getRequestDispatcher("/borrowequipment")
								.forward(request, response);
					} else if (executepunctuation == 1) {
						request.setAttribute("borrowErr", "借出数量多于库中");
						request.getRequestDispatcher("/borrowequipment")
								.forward(request, response);
					} else {
						request.setAttribute("borrowErr", "系统出错，借出事务中断");
						request.getRequestDispatcher("/borrowequipment")
								.forward(request, response);
					}
				} else {
					request.setAttribute("borrowErr", "请输入正确的用户名密码和器材型号");
					request.getRequestDispatcher("/borrowequipment").forward(
							request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("borrowErr", "系统内部出错");
				request.getRequestDispatcher("/borrowequipment").forward(
						request, response);
			}
		} else if ("userauthentication".equals(opr)) {
			String loginName = request.getParameter("loginName");
			try {
				User user = userservice.getUserByLoginName(loginName);
				response.setContentType("application/json");
				if (user != null) {
					out.write(JSONObject.fromObject(user).toString());
				} else {
					out.write(JSONObject.fromObject(new User()).toString());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("equipmentaut".equals(opr)) {
			String equipmentId = request.getParameter("equipmentId");
			try {
				Equipment equipment = equipmentserivce
						.getEquipmentById(equipmentId);
				JSONObject json = new JSONObject();
				if (equipment != null) {

					response.setContentType("application/json");
					json.accumulate("equipmentname",
							equipment.getEquipmentName());
					json.accumulate("equipmentType",
							equipment.getEquipmentType());
					json.accumulate("equipmentAmount",
							equipment.getEquipmentAmount());
					json.accumulate("equipmentspecification",
							equipment.getEquipmentspecification());
					out.write(json.toString());
				} else {
					json.accumulate("equipmentname", "");
					json.accumulate("equipmentType", "");
					json.accumulate("equipmentAmount", "");
					json.accumulate("equipmentspecification", "");
					out.write(json.toString());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (opr.equals("borrowPage")) {

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo"); // 默认为第一个页面

			String equipmentId = request.getParameter("equipmentId") == null ? ""
					: request.getParameter("equipmentId");
			String loginName = request.getParameter("loginName") == null ? ""
					: request.getParameter("loginName");
			/*
			 * SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); try
			 * { Date startdate = (Date)
			 * (format.parse(request.getParameter("startDate")) == null ? ""
			 * :format.parse(request.getParameter("startDate"))); Date enddate =
			 * (Date) (format.parse(request.getParameter("endDate")) == null ?
			 * "": format.parse(request.getParameter("endDate"))); } catch
			 * (ParseException e1) { e1.printStackTrace(); }
			 */
			Page<Borrow> page = new Page<Borrow>();

			page.setPageNo(Integer.parseInt(pageNo));

			page.setPageSize(5);
			BorrowDao borrowdao = new BorrowDaoImpl();
			try {

				page.setTotalCount(borrowdao.getTotalCount(equipmentId,
						loginName));

				page.setList(borrowservice.getEquipmentsByPage(
						page.getPageNo(), page.getPageSize(), equipmentId,
						loginName)); // 获取当前页数据集合

				request.setAttribute("borrowPage", page); // 将page对象存入request对象：page(总记录，总页数，当前页数数据)

				request.getRequestDispatcher("/returnequipment").forward(
						request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (opr.equals("returnequip")) {
			String equipmentId = request.getParameter("equipmentId");
			String loginName = request.getParameter("loginName");
			Integer equipmentnum = Integer.valueOf(request
					.getParameter("equipmentcount"));

			// String operatperson = request.getParameter("operatperson");
			try {
				int executepunctuation = borrowservice.returnBorrow(loginName,
						equipmentId, equipmentnum);
				if (executepunctuation == 2) {
					out.print("<script>alert('归还成功');location='borrowServlet?opr=borrowPage';</script>");
				} else if (executepunctuation == 1) {
					out.print("<script>alert('系统出错，归还事务中断');location='borrowServlet?opr=borrowPage';</script>");
				} else {

					out.print("<script>alert('归还失败');location='borrowServlet?opr=borrowPage';</script>");
				}
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("returnErr", "系统内部出错");
				request.getRequestDispatcher("/returnequipment").forward(
						request, response);
			}
		} else if (opr.equals("deleteborrow")) {
			String equipmentId = request.getParameter("equipmentId");
			String loginName = request.getParameter("loginName");
			Integer equipmentnumber = Integer.valueOf(request
					.getParameter("equipmentcount"));
			int executepunctuation;
			try {
				executepunctuation = borrowservice.deleteEquipment(equipmentId,
						loginName, equipmentnumber);
				if (executepunctuation > 0) {
					out.print("<script>alert('删除成功');location='borrowServlet?opr=borrowPage';</script>");
				}
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("deleteErr", "删除失败");
				request.getRequestDispatcher("/returnequipment").forward(
						request, response);
			}

		} else if (opr.equals("myBorrow")) {
		
			String equipmentId = request.getParameter("equipmentId") == null ? ""
					: request.getParameter("equipmentId");
			
			Page<Borrow> page = new Page<Borrow>();
			
			page.setPageSize(5);
			page.setPageNo(1);
			BorrowDao borrowdao = new BorrowDaoImpl();
			try {
 
				User user = (User) request.getSession().getAttribute("user");
				page.setList(borrowservice.getEquipmentsByPage(page.getPageNo(), page.getPageSize(), equipmentId, user.getLoginname())); // 获取当前页数据集合

				request.setAttribute("borrowPage", page); // 将page对象存入request对象：page(总记录，总页数，当前页数数据)

				request.getRequestDispatcher("/myBorrow").forward(
						request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		out.flush();
		out.close();
	}

}
