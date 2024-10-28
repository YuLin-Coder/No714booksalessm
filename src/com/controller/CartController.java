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
public class CartController extends BaseController {
	@Resource
	CartDAO cartDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	ProductDAO productDAO;
	@Resource
	CategoryDAO categoryDAO;
	@Resource
	AddressDAO addressDAO;
	

	// 查询购车图书
	@RequestMapping("cartList")
	public String cartList(HttpServletRequest request) {
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
		
		Member member = (Member) request.getSession().getAttribute(
				"sessionmember");
		String index = request.getParameter("index");
		int pageindex = 1;
		if (index != null) {
			pageindex = Integer.parseInt(index);
		}
		Page<Object> page = PageHelper.startPage(pageindex, 6);
		if (member != null) {
			List<Cart> cartlist = cartDAO.selectMyProductList(member.getId());
			String totalstr = "";
			double total = 0.0;
			for (int i = 0; i < cartlist.size(); i++) {
				Member m = memberDAO.findById(cartlist.get(i).getMemberid());
				Product product = productDAO.findById(cartlist.get(i)
						.getProductid());
				cartlist.get(i).setMember(m);
				cartlist.get(i).setProduct(product);
				total += Double.parseDouble(String.valueOf(cartlist.get(i)
						.getNum()))
						* product.getPrice();
				double doublesubtotal = Double.parseDouble(String.valueOf(cartlist.get(i)
						.getNum()))
						*product.getPrice();
				cartlist.get(i).setSubtotal(String.format("%.2f", doublesubtotal));
			}
			totalstr = String.format("%.2f", total);
			request.setAttribute("cartlist", cartlist);
			request.setAttribute("totalstr", totalstr);
		}
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "cartlist";
	}

	// 添加购物车
	@RequestMapping("addCart")
	public void addCart(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter out;
		try {
			out = response.getWriter();
			Member member = (Member) request.getSession().getAttribute(
					"sessionmember");
			if (member != null) {
				String productid = request.getParameter("productid");
				List<Cart> list = cartDAO.selectMyProduct(member.getId(),
						Integer.parseInt(productid));
				if (list.size() == 0) {
					Cart cart = new Cart();
					cart.setMemberid(member.getId());
					cart.setProductid(Integer.parseInt(productid));
					cart.setNum(1);
					cartDAO.add(cart);
				} else {
					Cart ct = new Cart();
					ct.setId(list.get(0).getId());
					ct.setNum(list.get(0).getNum() + 1);
					cartDAO.update(ct);
				}
				out.print("1");
			} else {
				out.println("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 删除购物车中的图书
	@RequestMapping("delCart")
	public void delCart(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter out;
		try {
			out = response.getWriter();
			String id = request.getParameter("id");
			cartDAO.delCart(Integer.parseInt(id));
			out.println("0");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//修改购物车
	@RequestMapping("EditNum")
	public void EditNum(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter out;
		try {
			out = response.getWriter();
			String id = request.getParameter("id");
			String num = request.getParameter("num");
			Cart ct = new Cart();
			ct.setId(Integer.parseInt(id));
			ct.setNum(Integer.parseInt(num));
			cartDAO.updateNum(ct);
			out.println("0");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//结算
	@RequestMapping("accountCart")
	public String accountCart(String total, HttpServletRequest request){
		Member member = (Member)request.getSession().getAttribute("sessionmember");
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
		
		
		//查收货地址到创建订单页面
		List<Address> addresslist = addressDAO.selectAll(member.getId());
		request.setAttribute("addresslist", addresslist);
		
		if(member!=null){
			List<Cart> cartlist = cartDAO.selectMyProductList(member.getId());
			String totalstr = "";
			double totaldouble = 0.0;
			for(int i=0;i<cartlist.size();i++){
				Member m = memberDAO.findById(cartlist.get(i).getMemberid());
				Product product = productDAO.findById(cartlist.get(i).getProductid());
				cartlist.get(i).setMember(m);
				cartlist.get(i).setProduct(product);
				totaldouble+=Double.parseDouble(String.valueOf(cartlist.get(i).getNum()))*product.getPrice();
			}
			totalstr = String.format("%.2f", totaldouble);
			request.setAttribute("cartlist", cartlist);
			request.setAttribute("totalstr", totalstr);
		}
		return "creatorder";
	}

	
	//清空购物车
	@RequestMapping("carDel")
	public String delCart(HttpServletRequest request) {
		Member member = (Member)request.getSession().getAttribute("sessionmember");
		if(member!=null){
			List<Cart> list =  cartDAO.selectMyProductList(member.getId());
			for(Cart cart:list){
				cartDAO.delCart(cart.getId());
			}
			return "redirect:cartList.do";
		}else{
			return "login";
		}
	}
}
