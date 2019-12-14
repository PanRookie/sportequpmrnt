package com.sportequipment.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sportequipment.dao.EquipmentDao;
import com.sportequipment.dao.UserDao;
import com.sportequipment.dao.impl.EquipmentDaoImpl;
import com.sportequipment.dao.impl.UserDaoImpl;
import com.sportequipment.domain.Admin;
import com.sportequipment.domain.Apply;
import com.sportequipment.domain.Equipment;
import com.sportequipment.domain.Page;
import com.sportequipment.domain.User;
import com.sportequipment.service.ApplyService;
import com.sportequipment.service.EquipmentService;
import com.sportequipment.service.UserService;
import com.sportequipment.service.impl.ApplyServiceImpl;
import com.sportequipment.service.impl.EquipmentServiceImpl;
import com.sportequipment.service.impl.UserServiceImpl;
import com.sportequipment.util.SecurityUtils;

/*import com.sportequipment.service.UserService;
 import com.sportequipment.service.impl.UserServiceImpl;*/

@WebServlet(urlPatterns = "/userServlet")
public class UserServlet extends HttpServlet {

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

		if ("register".equals(opr)) { // 注册
			User user = new User();
			String scode = (String) request.getSession().getAttribute("scode");
			if (scode.equalsIgnoreCase(request.getParameter("code"))) {
				out.print("ok");
				user.setLoginname(request.getParameter("loginName"));
				user.setPassword(SecurityUtils.md5Hex(request
						.getParameter("password")));
				user.setSex(request.getParameter("sex"));
				user.setEmail(request.getParameter("email"));
				user.setPhonenumber(request.getParameter("phone"));
				user.setSchoolposition(request.getParameter("position"));
				user.setUsername(request.getParameter("username"));
				user.setDapartment(request.getParameter("academy"));
				user.setMajor(request.getParameter("major"));
				user.setIdentityCode(request.getParameter("identityCode"));
				try {
					if (userservice.userRegister(user) > 0) {
						request.setAttribute("success", "注册成功");

						request.getRequestDispatcher("register.jsp").forward(
								request, response);
					} else {
						out.print("<script>alert('注册失败！');location='"
								+ request.getHeader("Referer") + "'</script>");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				out.print("<script>alert('验证码错误！');location='"
						+ request.getHeader("Referer") + "'</script>");
			}
		} else if ("login".equals(opr)) {

			String scode = (String) request.getSession().getAttribute("scode");
			if (scode.equalsIgnoreCase(request.getParameter("validateCode"))) {
				String loginName = request.getParameter("loginName");
				String loginpassword = SecurityUtils.md5Hex(request
						.getParameter("password"));
				String remember = request.getParameter("remember");
				Cookie ck = new Cookie("userName", loginName);
				try {
					User user = userservice.userLogin(loginName, loginpassword);
					if (user != null) {
						out.print("<script>alert('登录成功');</script>");
						if (remember != null) {
							ck.setMaxAge(Integer.MAX_VALUE);// 设置Cookie的有效保存时间
						} else {
							ck.setMaxAge(0);// 删除 Cookie
						}
						response.addCookie(ck);// 将Cookie写回到客户端

						HttpSession session = request.getSession();
						session.setAttribute("user", user);
						request.getRequestDispatcher("/userframe").forward(
								request, response);

					} else {
						out.print("<script>alert('登录失败');location='login.jsp';</script>");
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("err", "不好意思，出错了，请重试。");
					request.getRequestDispatcher("login.jsp").forward(request,
							response);
				}

			} else {
				out.print("<script>alert('验证码错误！');location='"
						+ request.getHeader("Referer") + "'</script>");
				return;
			}
		} else if (opr.equals("isLoginName")) {
			String loginName = request.getParameter("loginName");
			try {
				if (userservice.getUserByLoginName(loginName) != null) {
					out.print("yes");
				} else {
					out.print("no");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (opr.equals("userPage")) {

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo"); // 默认为第一个页面

			String loginName = request.getParameter("loginName") == null ? ""
					: request.getParameter("loginName");
			String userName = request.getParameter("userName") == null ? ""
					: request.getParameter("userName");
			String sex = request.getParameter("sex") == null ? "" : request
					.getParameter("sex");

			String position = request.getParameter("position") == null ? ""
					: request.getParameter("position");
			String major = request.getParameter("major") == null ? "" : request
					.getParameter("major");
			String academy = request.getParameter("academy") == null ? ""
					: request.getParameter("academy");

			String email = request.getParameter("email") == null ? "" : request
					.getParameter("email");
			String phone = request.getParameter("phone") == null ? "" : request
					.getParameter("phone");

			String identityCode = request.getParameter("identityCode") == null ? ""
					: request.getParameter("identityCode");

			Page<User> page = new Page<User>();

			page.setPageNo(Integer.parseInt(pageNo));

			page.setPageSize(10);

			UserDao userdao = new UserDaoImpl();
			try {
				// 获取数据记录总个数
				page.setTotalCount(userdao.getTotalCount(loginName, userName,
						sex, position, academy, major, phone, email,
						identityCode));
				// 获取当前页数据集合
				page.setList(userservice.getUsersByPage(page.getPageNo(),
						page.getPageSize(), loginName, userName, sex, position,
						academy, major, phone, email, identityCode));
				request.setAttribute("userPage", page); // 将page对象存入request对象：page(总记录，总页数，当前页数数据)
				request.getRequestDispatcher("/userSelectByPage").forward(
						request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (opr.equals("equipmentPage")) {
			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo"); // 默认为第一个页面

			String equipmentId = request.getParameter("equipmentId") == null ? ""
					: request.getParameter("equipmentId");
			String equipmentName = request.getParameter("equipmentName") == null ? ""
					: request.getParameter("equipmentName");
			String equipmentType = request.getParameter("equipmentType") == null ? ""
					: request.getParameter("equipmentType");
			String operatPerson = request.getParameter("operatPerson") == null ? ""
					: request.getParameter("operatPerson");
			String equipmentspecification = request
					.getParameter("equipmentSpecification") == null ? ""
					: request.getParameter("equipmentSpecification");

			/*
			 * out.write(pageNo+"  "+equipmentId+"  "+equipmentName+"  "+
			 * equipmentType+"  "+operatPerson+"  "+equipmentspecification);
			 */

			Page<Equipment> page = new Page<Equipment>();

			page.setPageNo(Integer.parseInt(pageNo));

			page.setPageSize(4);

			EquipmentDao equipmentdao = new EquipmentDaoImpl();
			EquipmentService equipmentservice = new EquipmentServiceImpl();
			try {
				// 获取数据记录总个数
				page.setTotalCount(equipmentdao.getTotalCount(equipmentId,
						equipmentName, equipmentType, operatPerson,
						equipmentspecification));

				// 获取当前页数据集合
				page.setList(equipmentservice.getEquipmentsByPage(
						page.getPageNo(), page.getPageSize(), equipmentId,
						equipmentName, equipmentType, operatPerson,
						equipmentspecification));

				request.setAttribute("equipmentPage", page); // 将page对象存入request对象：page(总记录，总页数，当前页数数据)
				request.getRequestDispatcher("/userBorrow").forward(request,
						response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (opr.equals("userBorrow")) {
			ApplyService applyService = new ApplyServiceImpl();
			User user = (User) request.getSession().getAttribute("user");
			Apply apply = new Apply();
			apply.setLoginName(user.getLoginname());
			apply.setEquipmentId(request.getParameter("equipmentId"));
			apply.setBorrowAmount(Integer.valueOf(request
					.getParameter("equipmennumber")));
			apply.setApplyRemark(request.getParameter("applyRemark") != null ? "" : request.getParameter("applyRemark"));
			try {
				if (applyService.addApply(apply) > 0) {
					out.print("<script>alert('申请成功');location='userServlet?opr=equipmentPage';</script>");
				}else{
					out.print("<script>alert('申请失败');location='userServlet?opr=equipmentPage';</script>");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (opr.equals("updateUserData")) {
			User user = (User) request.getSession().getAttribute("user");
			String userName = request.getParameter("username");
			String sex = request.getParameter("sex");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String academy = request.getParameter("academy");
			String major = request.getParameter("major");
			String identityCode = request.getParameter("identityCode");
			try {
				if(userservice.updateUserData(user.getLoginname(), userName, sex, academy, major, phone, email, identityCode) > 0){
					out.print("<script>alert('修改成功');location='./modUserDate';</script>");
				}else{
					out.print("<script>alert('修改失败');location='./modUserDate';</script>");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (opr.equals("collectEquip")){
			User user = (User) request.getSession().getAttribute("user");
			String equipmentId = request.getParameter("equipmentId");
			try {
				if(userservice.collectEquipment(user.getLoginname(), equipmentId) > 0 ){
					out.print("<script>alert('收藏成功');location='userServlet?opr=equipmentPage';</script>");
				}else{
					out.print("<script>alert('收藏失败');location='userServlet?opr=equipmentPage';</script>");
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
