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
public class AddressController extends BaseController {
	@Resource
	AddressDAO addressDAO;
	@Resource
	CategoryDAO categoryDAO;
	
	
	
	//前台查询地址列表
	@RequestMapping("addressMsg")
	public String addressMsg(HttpServletRequest request) {
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
		Member member = (Member)request.getSession().getAttribute("sessionmember");
		List<Address> list = addressDAO.selectAll(member.getId());
		request.setAttribute("list", list);
		return "addressmsg";
	}
	
	
	
	
	//添加地址 
	@RequestMapping("addressAdd")
	public String addressAdd(Address address,HttpServletRequest request){
		Member member = (Member)request.getSession().getAttribute("sessionmember");
		address.setMemberid(member.getId());
		addressDAO.add(address);
		return "redirect:addressMsg.do";
	}
	
	
	
	//删除地址
	@RequestMapping("addressDel")
	public String addressDelAll(int id,HttpServletRequest request){
		addressDAO.delete(id);
		return "redirect:addressMsg.do";
	}
	

}
