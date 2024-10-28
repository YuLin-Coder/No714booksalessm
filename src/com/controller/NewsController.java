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
public class NewsController extends BaseController {
	@Resource
	NewsDAO newsDAO;
	@Resource
	CategoryDAO categoryDAO;
	
	//后台查询新闻列表
	@RequestMapping("/admin/newsList")
	public String newsList(HttpServletRequest request) {
		String index = request.getParameter("index");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<News> list = newsDAO.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/newslist";
	}
	
	//前台查询新闻列表
	@RequestMapping("listNews")
	public String listNews(HttpServletRequest request) {
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
		
		
		String index = request.getParameter("index");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<News> list = newsDAO.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "newslist";
	}
	
	
	//后台查询结果列表
	@RequestMapping("admin/searchNews")
	public String searchUser(HttpServletRequest request){
		String index = request.getParameter("index");
		String key = request.getParameter("key");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<News> list = newsDAO.searchNews(key);
		request.setAttribute("list", list);
		request.setAttribute("key", key);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/newssearchlist";
	}
	
	
	//添加新闻 
	@RequestMapping("/admin/newsAdd")
	public String newsAdd(News news,HttpServletRequest request){
		newsDAO.add(news);
		return "redirect:newsList.do";
	}
	
	//后台查询新闻
	@RequestMapping("/admin/showNews")
	public String shownews(int id,HttpServletRequest request){
		News news =  newsDAO.findById(id);
		request.setAttribute("news", news);
		return "admin/newsedit";
	}
	
	
	//前台查询新闻
	@RequestMapping("newsShow")
	public String newsShow(int id,HttpServletRequest request){
		News news =  newsDAO.findById(id);
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
		request.setAttribute("news", news);
		return "newsx";
	}
	
	//编辑新闻
	@RequestMapping("/admin/newsEdit")
	public String newsEdit(News news,HttpServletRequest request){
		newsDAO.update(news);
		request.setAttribute("news", news);
		return "redirect:newsList.do";
	}
	
	//删除新闻
	@RequestMapping("admin/newsDelAll")
	public String newsDelAll(HttpServletRequest request,HttpServletResponse response){
		String vals = request.getParameter("vals");
		String[] val = vals.split(",");
		for(int i=0;i<val.length;i++){
			newsDAO.delete(Integer.parseInt(val[i]));
		}
		return "redirect:newsList.do";
	}
	
	
	
	

}
