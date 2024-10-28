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
public class OrdermsgController extends BaseController {
	@Resource
	OrdermsgDAO ordermsgDAO;
	@Resource
	CartDAO cartDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	ProductDAO productDAO;
	@Resource
	OrdermsgdetailsDAO ordermsgdetailsDAO;
	@Resource
	InventoryDAO inventoryDAO;
	@Resource
	CategoryDAO categoryDAO;
	@Resource
	AddressDAO addressDAO;
	
	
	//创建订单
	@RequestMapping("creatOrder")
	public String creatOrder(HttpServletRequest request){
		//图书类别
		List<Category> ctlist = categoryDAO.selectAll();
		request.setAttribute("ctlist", ctlist);
		
		String addrid = request.getParameter("addrid");
		if(addrid!=null){
		Member member = (Member)request.getSession().getAttribute("sessionmember");
			List<Cart> cartlist = cartDAO.selectMyProductList(member.getId());
			String orderno = Info.getOrderNo();
			String totalstr = "";
			double total = 0.0;
			for(int i=0;i<cartlist.size();i++){
				//添加订单详情信息
				Ordermsgdetails ordermsgdetails = new Ordermsgdetails();
				ordermsgdetails.setOrderno(orderno);
				ordermsgdetails.setProductid(cartlist.get(i).getProductid());
				ordermsgdetails.setNum(cartlist.get(i).getNum());
				ordermsgdetails.setMemberid(member.getId());
				ordermsgdetailsDAO.add(ordermsgdetails);
				
				//得到总价
				Member m = memberDAO.findById(cartlist.get(i).getMemberid());
				Product product = productDAO.findById(cartlist.get(i).getProductid());
				cartlist.get(i).setMember(m);
				cartlist.get(i).setProduct(product);
				total+=Double.parseDouble(String.valueOf(cartlist.get(i).getNum()))*product.getPrice();
				
				//删除购物车中的数据
				cartDAO.delCart(cartlist.get(i).getId());
			}
			totalstr = String.format("%.2f", total);
			
			//添加订单
			Ordermsg ordermsg = new Ordermsg();
			ordermsg.setOrderno(orderno);
			ordermsg.setMemberid(member.getId());
			ordermsg.setTotal(totalstr);
			ordermsg.setAddrid(Integer.parseInt(addrid));
			ordermsg.setFkstatus("待付款");
			ordermsgDAO.add(ordermsg);
			return "ordersuc";
		}else{
			return "redirect:addressMsg.do";
		}
		
	}
	
	//前台订单列表
	@RequestMapping("orderList")
	public String orderList(HttpServletRequest request){
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
			
		List<Ordermsg> fklist = ordermsgDAO.selectPayment(member.getId());
		for(int a=0;a<fklist.size();a++ ){
			Member m = memberDAO.findById(fklist.get(a).getMemberid());
			fklist.get(a).setMember(m);
			Address address = addressDAO.findbyid(fklist.get(a).getAddrid());
			fklist.get(a).setAddress(address);
		}
		List<Ordermsg> shlist = ordermsgDAO.selectShouhuo(member.getId());
		for(int b=0;b<shlist.size();b++ ){
			Member m = memberDAO.findById(shlist.get(b).getMemberid());
			shlist.get(b).setMember(m);
			Address address = addressDAO.findbyid(shlist.get(b).getAddrid());
			shlist.get(b).setAddress(address);
		}
		List<Ordermsg> wclist = ordermsgDAO.selectAccomplish(member.getId());
		for(int c=0;c<wclist.size();c++ ){
			Member m = memberDAO.findById(wclist.get(c).getMemberid());
			wclist.get(c).setMember(m);
			Address address = addressDAO.findbyid(wclist.get(c).getAddrid());
			wclist.get(c).setAddress(address);
		}
		request.setAttribute("fklist", fklist);
		request.setAttribute("shlist", shlist);
		request.setAttribute("wclist", wclist);
		return "orderlist";
		
	}
	
	//前台查看订单详情
	@RequestMapping("orderDetails")
	public String orderDetails(String orderno, HttpServletRequest request){
		Member member = (Member)request.getSession().getAttribute("sessionmember");
		if(member!=null){
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
		
		List<Ordermsgdetails> list = ordermsgdetailsDAO.selectorderDetails(orderno);
		for(int a=0;a<list.size();a++ ){
			Product product = productDAO.findById(list.get(a).getProductid());
			list.get(a).setProduct(product);
		}
		request.setAttribute("list", list);
		return "orderdetails";
		
	}
	
    //订单付款
	@RequestMapping("payOrder")
	public String payOrder(int id, HttpServletRequest request){
		Member member = (Member)request.getSession().getAttribute("sessionmember");
		String zffs = request.getParameter("zffs");
		if(member!=null){
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
		
	    Ordermsg ordermsg = ordermsgDAO.findById(id);
		ordermsg.setFkstatus("已付款");
		ordermsg.setShstatus("待发货");
		ordermsg.setZffs(zffs);
		ordermsgDAO.update(ordermsg);
		
		return "redirect:orderList.do";
		
	}
	
    //后台查询所有订单
	@RequestMapping("admin/orderList")
	public String adminorderList(HttpServletRequest request){
		String index = request.getParameter("index");
		String msg = request.getParameter("msg");
		String key = request.getParameter("key");
		String fkstatus = request.getParameter("fkstatus");
		String shstatus = request.getParameter("shstatus");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
   	    
   	    HashMap map = new HashMap();
   	    map.put("key",key);
   	    map.put("fkstatus",fkstatus);
   	    map.put("shstatus",shstatus);
		List<Ordermsg> list = ordermsgDAO.selectAll(map);
		for(int i=0;i<list.size();i++){
			Member m = memberDAO.findById(list.get(i).getMemberid());
			list.get(i).setMember(m);
			Address address = addressDAO.findbyid(list.get(i).getAddrid());
			list.get(i).setAddress(address);
		}
		if(msg!=null&&msg.equals("msg")){
			request.setAttribute("msg", "msg");
		}
		request.setAttribute("list", list);
		request.setAttribute("key", key);
		request.setAttribute("fkstatus", fkstatus);
		request.setAttribute("shstatus", shstatus);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/orderlist";
		
	}
	
	//后台查看订单详情
	@RequestMapping("admin/orderDetails")
	public String orderadminDetails(String orderno, HttpServletRequest request){
		String index = request.getParameter("index");
		String msg = request.getParameter("msg");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<Ordermsgdetails> list = ordermsgdetailsDAO.selectorderDetails(orderno);
		for(int a=0;a<list.size();a++ ){
			Product product = productDAO.findById(list.get(a).getProductid());
			list.get(a).setProduct(product);
		}
		request.setAttribute("list", list);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/orderdetails";
		
	}
	
	//后台查询订单信息
	@RequestMapping("admin/searchOrdername")
	public String searchOrdername(HttpServletRequest request){
		String index = request.getParameter("index");
		String orderno = request.getParameter("orderno");
	   	int pageindex = 1;
	   	if(index!=null){
	   		 pageindex = Integer.parseInt(index);
	   	}
   	    Page<Object> page = PageHelper.startPage(pageindex,6);
		List<Ordermsg> list = ordermsgDAO.searchOrdername(orderno);
		for(int i=0;i<list.size();i++){
			Member m = memberDAO.findById(list.get(i).getMemberid());
			list.get(i).setMember(m);
		}
		request.setAttribute("list", list);
		request.setAttribute("orderno", orderno);
		request.setAttribute("index", page.getPageNum());
		request.setAttribute("pages", page.getPages());
		request.setAttribute("total", page.getTotal());
		return "admin/ordersearchlist";
		
	}
	
	//后台删除订单
	@RequestMapping("admin/orderDelAll")
	public String orderDelAll(HttpServletRequest request){
		String vals = request.getParameter("vals");
		String[] val = vals.split(",");
		for(int i=0;i<val.length;i++){
			Ordermsg ordermsg  = ordermsgDAO.findById(Integer.parseInt(val[i]));
			List<Ordermsgdetails> detailslist = ordermsgdetailsDAO.selectorderDetails(ordermsg.getOrderno());
			for(Ordermsgdetails ordermsgdetails:detailslist ){
				ordermsgdetailsDAO.delete(ordermsgdetails.getId());
			}
			ordermsgDAO.delete(Integer.parseInt(val[i]));
		}
		return "admin/ordersearchlist";
		
	}
	
	//发货
	@RequestMapping("admin/faHuo")
	public String faHuo(Ordermsg ordermsg,HttpServletRequest request){
		Ordermsg order = ordermsgDAO.findById(ordermsg.getId());
		List<Ordermsgdetails> list = ordermsgdetailsDAO.selectorderDetails(order.getOrderno());
		
		boolean flag = true;
		for(Ordermsgdetails ordermsgdetails:list){
			int inventoryrecord = Info.getInventory(ordermsgdetails.getProductid());
			if(inventoryrecord<ordermsgdetails.getNum()){
				flag = false;
				break;
			}
		}
		if(flag==true){
			for(Ordermsgdetails omd:list){
				Inventory inv = new Inventory();
				inv.setNum(omd.getNum());
				inv.setType("out");
				inv.setProductid(String.valueOf( omd.getProductid()));
				inventoryDAO.add(inv);
			}
			ordermsg.setShstatus("待收货");
			ordermsgDAO.update(ordermsg);
			return "redirect:orderList.do";
		}else{
			return "redirect:orderList.do?msg=msg";
		}
		
	}
	
	//收货
	@RequestMapping("orderShouhuo")
	public String orderShouhuo(int id,HttpServletRequest request){
		ordermsgDAO.updateSh(id);
		return "redirect:orderList.do";
	}
	
	//跳转付款页面
	@RequestMapping("orderpay")
	public String orderpay(HttpServletRequest request){
		String id  = request.getParameter("id");
		String total  = request.getParameter("total");
		
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
		request.setAttribute("total", total);
		request.setAttribute("id", id);
		return "orderpay";
	}

}
