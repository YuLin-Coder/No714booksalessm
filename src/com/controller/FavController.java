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
public class FavController extends BaseController {
	@Resource
	FavDAO favDAO;
	@Resource
	CartDAO cartDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	ProductDAO productDAO;
	@Resource
	CategoryDAO categoryDAO;
	
	// 添加到收藏夹
	@RequestMapping("addFav")
	public void addFav(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter out;
		try {
			out = response.getWriter();
			Member member = (Member) request.getSession().getAttribute(
					"sessionmember");
			if (member != null) {
				String productid = request.getParameter("productid");
				List<Fav> list = favDAO.selectMyProduct(member.getId(),Integer.parseInt(productid));
				if (list.size() == 0) {
					Fav fav = new Fav();
					fav.setMemberid(member.getId());
					fav.setProductid(Integer.parseInt(productid));
					favDAO.add(fav);
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
	
	//查询收藏夹里的图书
	@RequestMapping("favList")
	public String favList(HttpServletRequest request) {
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
			if (member != null) {
				List<Fav> list = favDAO.selectAll(member.getId());
				for(int a = 0;a<list.size();a++){
					Product pt = productDAO.findById(list.get(a).getProductid());
					list.get(a).setProduct(pt);
				}
				//查询购物车
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
				request.setAttribute("list", list);
				request.setAttribute("cartlist", cartlist);
				request.setAttribute("totalstr", totalstr);
				return "favlist";
			}else{
				return "login";
			}
	}
	
	//移出收藏夹
	@RequestMapping("delFav")
	public void delFav(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter out;
		try {
			out = response.getWriter();
				String id = request.getParameter("id");
				favDAO.delete(Integer.parseInt(id));
				out.print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
