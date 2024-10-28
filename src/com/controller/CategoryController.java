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
import com.google.gson.Gson;

import java.util.*;

@Controller
public class CategoryController extends BaseController {
	@Resource
	CategoryDAO categoryDAO;
	
	@RequestMapping("admin/categoryList")
	public String categoryList(HttpServletRequest request) {
		List<Category> list = categoryDAO.selectfatherAll();
		for(Category category:list){
			List<Category> childlist = categoryDAO.selectchildAll(category.getId());
			category.setChildlist(childlist);
			for(Category childcategory:childlist){
				List<Category> minlist = categoryDAO.selectminAll(childcategory.getId());
				childcategory.setMinlist(minlist);
			}
		}
		request.setAttribute("list", list);
		return "admin/categorylist";
	}
	
	@RequestMapping("admin/searchCategory")
	public String searchUser(HttpServletRequest request){
		String index = request.getParameter("index");
		String key = request.getParameter("key");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<Category> list = categoryDAO.search(key);
		request.setAttribute("list", list);
		request.setAttribute("key", key);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/categorysearchlist";
	}
	
	
	@RequestMapping("/admin/categoryAdd")
	public String dingdanAdd(Category ct,HttpServletRequest request){
		String type = request.getParameter("type");
		if(type.equals("father")){
			ct.setFatherid(0);
			ct.setLeaf("1");
			categoryDAO.add(ct);
		}else if(type.equals("leaf")){
			Category category = categoryDAO.findById(ct.getFatherid());
			category.setLeaf("0");
			categoryDAO.update(category);
			ct.setLeaf("1");
			categoryDAO.add(ct);
		}
		return "redirect:categoryList.do";
	}
	
	@RequestMapping("/admin/showCategory")
	public String showCategory(int id,HttpServletRequest request){
		Category category =  categoryDAO.findById(id);
		request.setAttribute("category", category);
		return "admin/categoryedit";
	}
	
	@RequestMapping("/admin/categoryEdit")
	public String categoryEdit(Category category,HttpServletRequest request){
		System.out.println("leaf=="+category.getLeaf());
		categoryDAO.update(category);
		request.setAttribute("category", category);
		return "redirect:categoryList.do";
	}
	
	@RequestMapping("admin/categoryDel")
	public String categoryDel(int id, HttpServletRequest request){
		Category category = categoryDAO.findById(id);
		List<Category> list = (List<Category>)categoryDAO.selectOne(category.getFatherid());
		if(list.size()<=1){
			Category ct = categoryDAO.findById(category.getFatherid());
			ct.setLeaf("1");
			categoryDAO.update(ct);
		}
			categoryDAO.delete(id);
		return "redirect:categoryList.do";
	}
	
	
	//得到二级类别
	@RequestMapping("admin/searchCtype")
	public void searchCtype(HttpServletRequest request,HttpServletResponse response){
		String fid = request.getParameter("fid");
		String xml = "";
	    List<Category> list = categoryDAO.selectchildAll(Integer.parseInt(fid));
		if(list.size()>0){
		    for(Category category:list){
		    	xml += "<option value='"+category.getId()+"'>"+category.getName()+"</option>";
			}
		}else{
			xml ="<option value=''>请选择上一级目录</opion>";
		}
 		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
 		PrintWriter out;
		try {
			out = response.getWriter();
			Gson gson = new Gson();
			String flag = gson.toJson(xml);
			out.write(flag);
	 		out.flush();
	 		out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	

}
