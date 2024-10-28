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
public class AboutController extends BaseController {
	@Resource
	AboutDAO aboutDAO;
	
	@RequestMapping("/admin/showAbout")
	public String showAbout(int id,HttpServletRequest request){
		About about =  aboutDAO.findById(id);
		request.setAttribute("about", about);
		return "admin/aboutedit";
	}
	
	@RequestMapping("/admin/aboutEdit")
	public String aboutEdit(About about,HttpServletRequest request){
		aboutDAO.update(about);
		return "redirect:showAbout.do?id=1";
	}
	
	
	
	
	

}
