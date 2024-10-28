package com.entity;

import java.util.*;

public class Category {
	private int id;
	private String name;
	private int fatherid;
	private String leaf;
	private String delstatus;
	
	private List childlist;
	private List minlist;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDelstatus() {
		return delstatus;
	}
	public void setDelstatus(String delstatus) {
		this.delstatus = delstatus;
	}
	public int getFatherid() {
		return fatherid;
	}
	public void setFatherid(int fatherid) {
		this.fatherid = fatherid;
	}
	
	
	public List getChildlist() {
		return childlist;
	}
	public void setChildlist(List childlist) {
		this.childlist = childlist;
	}
	
	
	public String getLeaf() {
		return leaf;
	}
	public void setLeaf(String leaf) {
		this.leaf = leaf;
	}
	public List getMinlist() {
		return minlist;
	}
	public void setMinlist(List minlist) {
		this.minlist = minlist;
	}
	@Override
	public String toString() {
		return "Category [delstatus=" + delstatus + ", id=" + id + ", name="
				+ name + "]";
	}
	
	
	
}
