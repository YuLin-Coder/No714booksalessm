package com.dao;
import com.entity.*;

import java.util.*;
public interface CategoryDAO {
	List<Category> selectAll();
	void add(Category ct);
	Category findById(int id);
	void update(Category category);
	void delete(int id);
	List<Category> search(String key);
	List<Category> selectchildAll(int fatherid);
	List<Category> selectminAll(int fatherid);
	List<Category> selectfatherAll();
	List<Category> selectOne(int fatherid);
}
