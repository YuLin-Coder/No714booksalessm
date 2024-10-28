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
import com.util.Info;

import java.util.*;

@Controller
public class MessageController extends BaseController {
	@Resource
	MessageDAO messageDAO;
	@Resource
	CartDAO cartDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	ProductDAO productDAO;
	@Resource
	CategoryDAO categoryDAO;
	
	//前台留言列表
	@RequestMapping("message_List")
	public String message_List(HttpServletRequest request){
		String msg = request.getParameter("msg");
		List<Message> list = messageDAO.selectAll();
		for(int i=0;i<list.size();i++){
			Member m = memberDAO.findById(list.get(i).getMemberid());
			list.get(i).setMember(m);
		}
		//图书类别
		List<Category> ctlist = categoryDAO.selectfatherAll();
		for(Category category:ctlist){
			List<Category> childlist = categoryDAO.selectchildAll(category.getId());
			category.setChildlist(childlist);
			for(Category childcategory:childlist){
				List<Category> minlist = categoryDAO.selectminAll(childcategory.getId());
				childcategory.setMinlist(minlist);
			}
		}
		request.setAttribute("ctlist", ctlist);
		//购物车
		Member member = (Member)request.getSession().getAttribute("sessionmember");
		if(member!=null){
			//留言列表
			
			List<Cart> cartlist = cartDAO.selectMyProductList(member.getId());
			String totalstr = "";
			double total = 0.0;
			for(int i=0;i<cartlist.size();i++){
				Member m = memberDAO.findById(cartlist.get(i).getMemberid());
				Product product = productDAO.findById(cartlist.get(i).getProductid());
				cartlist.get(i).setMember(m);
				cartlist.get(i).setProduct(product);
				total+=Double.parseDouble(String.valueOf(cartlist.get(i).getNum()))*product.getPrice();
			}
			totalstr = String.format("%.2f", total);
			request.setAttribute("cartlist", cartlist);
			request.setAttribute("totalstr", totalstr);
		}
		request.setAttribute("list", list);
		return "messagelist";
	}
	
	
	//前台留言添加
	@RequestMapping("messageAdd")
	public String messageAdd(HttpServletRequest request){
		Member member = (Member)request.getSession().getAttribute("sessionmember");
		String content = request.getParameter("content");
		if(member!=null){
			Message message = new Message();
			message.setContent(content);
			message.setMemberid(member.getId());
			message.setSavetime(Info.getDateStr());
			messageDAO.add(message);
			return "redirect:message_List.do";
		}else{
			return "login";
		}
	}
	
	//后台留言列表
	@RequestMapping("/admin/messageList")
	public String messageList(HttpServletRequest request) {
		String index = request.getParameter("index");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<Message> list = messageDAO.selectAll();
		for(int i=0;i<list.size();i++){
			Member m = memberDAO.findById(list.get(i).getMemberid());
			list.get(i).setMember(m);
		}
		request.setAttribute("list", list);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/messagelist";
	}
	
	//后台搜索留言
	@RequestMapping("/admin/searchMessage")
	public String searchMessage(String key, HttpServletRequest request) {
		String index = request.getParameter("index");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<Message> list = messageDAO.searchMessage(key);
		for(int i=0;i<list.size();i++){
			Member m = memberDAO.findById(list.get(i).getMemberid());
			list.get(i).setMember(m);
		}
		request.setAttribute("list", list);
		request.setAttribute("key", key);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/messagesearchlist";
	}
	
	//留言回复
	@RequestMapping("/admin/updateMessage")
	public String updateMessage(Message message,HttpServletRequest request) {
		messageDAO.update(message);
		return "redirect:messageList.do";
	}
	
	//删除留言
	@RequestMapping("/admin/messageDelAll")
	public String updateMessage(HttpServletRequest request) {
		String vals = request.getParameter("vals");
		String[] val = vals.split(",");
		for(int i=0;i<val.length;i++){
			messageDAO.delete(Integer.parseInt(val[i]));
		}
		return "redirect:messageList.do";
	}

}
