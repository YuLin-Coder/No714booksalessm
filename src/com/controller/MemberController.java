package com.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.dao.*;
import com.entity.*;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import java.util.*;

@Controller
public class MemberController extends BaseController {
	@Resource
	MemberDAO memberDAO;
	
	
	//登录
	@RequestMapping("Login")
	public String Login(String uname,String upass, HttpServletRequest request){
		List<Member> list = memberDAO.selectOne(uname,upass);
		if(list.size()==0){
			request.setAttribute("msg", "upasserr");
			return "login";
		}else{
			request.getSession().setAttribute("sessionmember", list.get(0));
			return "redirect:index.do";	
		}
	}
	
	//注册
	@RequestMapping("Register")
	public String Register(Member member, HttpServletRequest request){
		memberDAO.add(member);
		request.setAttribute("msg", "registersuc");
			return "login";
	}
	
	//检查用户名的唯一性
	@RequestMapping("checkUname")
	public void checkUname(String uname, HttpServletRequest request, HttpServletResponse response){
		try {
			PrintWriter out = response.getWriter();
			List<Member> list = memberDAO.checkUname(uname);
			if(list.size()==0){
				out.print(0);
			}else{
				out.print(1);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//查找用户信息
	@RequestMapping("showMember")
	public String showMember(HttpServletRequest request){
		Member member  = (Member)request.getSession().getAttribute("sessionmember");
		Member m = memberDAO.findById(member.getId());
		request.setAttribute("member", m);
			return "myinfo";
	}
	
	//修改个人信息
	@RequestMapping("memberinfoEidt")
	public String memberinfoEidt(Member member, HttpServletRequest request){
		memberDAO.update(member);
			return "redirect:showMember.do";
	}
	
	//退出
	@RequestMapping("Exit")
	public String Exit(HttpServletRequest request){
		request.getSession().removeAttribute("sessionmember");
		return "redirect:index.do";
	}
	
	
	//后台查询会员列表
	@RequestMapping("/admin/memberList")
	public String memberList(HttpServletRequest request) {
		String index = request.getParameter("index");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<Member> list = memberDAO.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/memberlist";
	}
	
	@RequestMapping("/admin/searchMember")
	public String searchMember(String key, HttpServletRequest request) {
		String index = request.getParameter("index");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<Member> list = memberDAO.selectMember(key);
		request.setAttribute("list", list);
		request.setAttribute("key", key);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/membersearchlist";
	}
	
	//删除会员
	@RequestMapping("admin/memberDelAll")
	public String memberDelAll(HttpServletRequest request,HttpServletResponse response){
		String vals = request.getParameter("vals");
		String[] val = vals.split(",");
		for(int i=0;i<val.length;i++){
			memberDAO.delete(Integer.parseInt(val[i]));
		}
		return "redirect:memberList.do";
	}
	
	//查找会员等级
	@RequestMapping("/admin/showLev")
	public String showLev( int id, HttpServletRequest request){
		Member m = memberDAO.findById(id);
		request.setAttribute("member", m);
			return "admin/showlev";
	}
	
	//提升等级
	@RequestMapping("/admin/levUpate")
	public String levUpate(Member member, HttpServletRequest request){
		memberDAO.updateLev(member);
		return "redirect:memberList.do";
	}
	
	
}
