package com.dao;
import com.entity.*;

import java.util.*;
public interface AddressDAO {
	List<Address> selectAll(int memberid);
	void add(Address address);
	void delete(int id);
	Address findbyid(int id);
}
